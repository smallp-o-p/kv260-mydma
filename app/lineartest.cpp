// lineartest.cpp - one LINEAR call through hw/controller (version A), checked
// against a CPU reference. Decode shape: one token, y = W x.
//
//   tx (activations) --axi_dma_4 MM2S--> activation_buffer --+
//   w0..w3 (packed weights) --axi_dma_0..3 MM2S--> FIFOs ----+--> axi_controller <--> tile
//   rx <--axi_dma_4 S2MM-- raw 44-bit group sums (as int64) <--+
//
// Version A has no level 2 on chip, so the board returns one exact integer
// per (output n, K-group g): sum over k in the group of x[k] * W[n][k], with
// each FP8 value decoded to an integer in units of 2^-9 (fp8_golden.py's
// level 1). This program builds random FP8 data, packs the weights the way
// fp8_golden.pack_weight_streams does, runs the call and compares every sum.
//
// The call needs two DMA commands at once: MYDMA_XFER_CMD (activations in,
// results out) blocks until the results arrive, and they only arrive while
// MYDMA_STREAM_CMD feeds the weights. So XFER runs on a second thread.
//
// Build:  make -C app lineartest
// Run:    sudo insmod mydma.ko max_xfer=1048576
//         sudo ./lineartest                 # N = 1024, K = 1024
//         sudo ./lineartest 4096 1024 5     # N, K, calls
// Sim:    ./lineartest 256 1024 1 <dir>     # writes the same data as hex files for
//                                           # hw/controller/sim/tb_axi_controller.v, no board needed
// Limits: N a multiple of 64, K a multiple of 128 and <= 3072, N*K/16 <= 1 MiB
// of results (N * K/128 * 8 bytes).

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#include <string>
#include <thread>
#include <vector>

#include "mydma_uapi.h"

constexpr unsigned T = 16, P = 4, GROUP = 128;

static void die(const char *what) {
    std::perror(what);
    std::exit(1);
}

// E4M3 code -> value * 2^9 as an exact integer. NaN codes (0x7F, 0xFF) -> 0,
// as in fp8_golden.E4M3_TO_INT9 and hw/controller/tile_ref.v.
static int32_t dec(uint8_t c) {
    const unsigned e = (c >> 3) & 15, m = c & 7;
    int32_t mag;
    if ((c & 0x7f) == 0x7f) mag = 0;
    else if (e == 0)        mag = int32_t(m);
    else                    mag = int32_t((8 + m) << (e - 1));
    return (c & 0x80) ? -mag : mag;
}

static uint8_t random_code(std::mt19937 &rng) {
    uint8_t c;
    do c = uint8_t(rng()); while ((c & 0x7f) == 0x7f);   // no NaNs
    return c;
}

// Hex files for hw/controller/sim/tb_axi_controller.v (one beat per line, byte 0 = LSB),
// so the RTL can be simulated on exactly the data this program sends.
static void dump(const char *dir, const std::vector<uint8_t> *lane, uint32_t lane_bytes,
                 const std::vector<uint8_t> &x, const std::vector<int64_t> &expect,
                 unsigned G, unsigned N) {
    ::mkdir(dir, 0755);                      // fine if it already exists
    auto open_w = [&](const char *name) {
        std::string path = std::string(dir) + "/" + name;
        FILE *f = std::fopen(path.c_str(), "w");
        if (!f) die(path.c_str());
        return f;
    };
    auto beats = [](FILE *f, const uint8_t *b, size_t n) {
        for (size_t i = 0; i < n; i += 16) {
            for (int k = 15; k >= 0; --k) std::fprintf(f, "%02x", b[i + k]);
            std::fprintf(f, "\n");
        }
        std::fclose(f);
    };
    char name[32];
    for (unsigned p = 0; p < P; ++p) {
        std::snprintf(name, sizeof name, "port%u.hex", p);
        beats(open_w(name), lane[p].data(), lane_bytes);
    }
    beats(open_w("act.hex"), x.data(), x.size());
    FILE *f = open_w("exp.hex");
    for (int64_t v : expect) std::fprintf(f, "%016llx\n", (unsigned long long)v);
    std::fclose(f);
    f = open_w("params.vh");
    std::fprintf(f, "`define G %u\n`define LANE_BEATS %u\n`define NSUMS %u\n`define VDIR \"%s\"\n",
                 G, lane_bytes / 16, N * G, dir);
    std::fclose(f);
    std::printf("wrote test vectors to %s\n", dir);
}

int main(int argc, char **argv) {
    const unsigned N = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 1024;
    const unsigned K = argc > 2 ? std::strtoul(argv[2], nullptr, 0) : 1024;
    const unsigned calls = argc > 3 ? std::strtoul(argv[3], nullptr, 0) : 1;
    const char *dump_dir = argc > 4 ? argv[4] : nullptr;
    const unsigned G = K / GROUP;
    if (N == 0 || N % (T * P) || K == 0 || K % GROUP || K > 3072 || calls == 0) {
        std::fprintf(stderr, "usage: %s [N (multiple of 64)] [K (multiple of 128, <= 3072)] [calls]\n",
                     argv[0]);
        return 2;
    }
    const uint32_t lane_bytes = (N / (T * P)) * G * (16 + GROUP * T);
    const uint32_t res_bytes = N * G * 8;
    if (res_bytes > MYDMA_BUF_SIZE) {
        std::fprintf(stderr, "results (%u bytes) don't fit the 1 MiB rx buffer\n", res_bytes);
        return 2;
    }

    // ---- random FP8 weights W[N][K] (PyTorch layout) and activations x[K] ----
    std::mt19937 rng(1);
    std::vector<uint8_t> W(size_t(N) * K), x(K);
    for (auto &c : W) c = random_code(rng);
    for (auto &c : x) c = random_code(rng);

    // ---- pack the lanes: n-tile j -> lane j % 4; per tile, per group:
    //      one scale beat (fp32 1.0, unused in version A) + 128 rows of 16 bytes,
    //      row k, byte c = W[16j + c][k]   (fp8_golden.pack_weight_streams) ----
    std::vector<uint8_t> lane[P];
    for (auto &l : lane) l.assign(lane_bytes, 0);
    uint32_t pos[P] = {};
    const float one = 1.0f;
    for (unsigned j = 0; j < N / T; ++j) {
        const unsigned p = j % P;
        for (unsigned g = 0; g < G; ++g) {
            std::memcpy(&lane[p][pos[p]], &one, 4);
            pos[p] += 16;
            for (unsigned k = g * GROUP; k < (g + 1) * GROUP; ++k)
                for (unsigned c = 0; c < T; ++c)
                    lane[p][pos[p]++] = W[size_t(j * T + c) * K + k];
        }
    }

    // ---- expected sums, in the order the controller sends them:
    //      for quad q, for group g, for lane p: 16 columns of tile 4q + p ----
    std::vector<int64_t> expect;
    expect.reserve(N * G);
    for (unsigned q = 0; q < N / (T * P); ++q)
        for (unsigned g = 0; g < G; ++g)
            for (unsigned p = 0; p < P; ++p)
                for (unsigned c = 0; c < T; ++c) {
                    const unsigned n = (q * P + p) * T + c;
                    int64_t s = 0;
                    for (unsigned k = g * GROUP; k < (g + 1) * GROUP; ++k)
                        s += int64_t(dec(x[k])) * dec(W[size_t(n) * K + k]);
                    expect.push_back(s);
                }

    std::printf("N = %u, K = %u (G = %u): %u bytes per weight lane, %u result bytes\n",
                N, K, G, lane_bytes, res_bytes);

    if (dump_dir) {                          // write the same data for the RTL testbench
        dump(dump_dir, lane, lane_bytes, x, expect, G, N);
        return 0;
    }

    int fd = ::open("/dev/mydma", O_RDWR);
    if (fd < 0) die("open /dev/mydma (insmod mydma.ko?)");
    mydma_info_args info{};
    if (::ioctl(fd, MYDMA_INFO_CMD, &info) < 0) die("ioctl MYDMA_INFO_CMD");
    if ((info.w_mask & 0xF) != 0xF) {
        std::fprintf(stderr, "need all 4 weight engines, driver reports mask 0x%x\n", info.w_mask);
        return 1;
    }

    auto *tx = static_cast<uint8_t *>(::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE,
                                             MAP_SHARED, fd, MYDMA_TX_OFFSET));
    auto *rx = static_cast<int64_t *>(::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE,
                                             MAP_SHARED, fd, MYDMA_RX_OFFSET));
    if (tx == MAP_FAILED || rx == MAP_FAILED) die("mmap tx/rx");
    uint8_t *w[P];
    for (unsigned p = 0; p < P; ++p) {
        if (lane_bytes > info.w_buf_bytes[p]) {
            std::fprintf(stderr, "lane %u needs %u bytes, buffer is %u (insmod wbuf_mb=...)\n",
                         p, lane_bytes, info.w_buf_bytes[p]);
            return 2;
        }
        void *m = ::mmap(nullptr, lane_bytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                         off_t(MYDMA_W_OFFSET(p)));
        if (m == MAP_FAILED) die("mmap weight buffer");
        w[p] = static_cast<uint8_t *>(m);
    }

    for (unsigned p = 0; p < P; ++p) std::memcpy(w[p], lane[p].data(), lane_bytes);


    unsigned failed_calls = 0;
    for (unsigned call = 0; call < calls; ++call) {
        std::memcpy(tx, x.data(), K);                 // version A: codes only
        std::memset(rx, 0, res_bytes);                // a stale buffer can't pass

        mydma_xfer_args xa{};
        xa.tx_bytes = K;
        xa.rx_bytes = res_bytes;
        int xfer_ret = 0, xfer_errno = 0;
        std::thread act([&] {
            xfer_ret = ::ioctl(fd, MYDMA_XFER_CMD, &xa);
            xfer_errno = errno;
        });
        std::this_thread::sleep_for(std::chrono::milliseconds(5));   // let XFER arm S2MM first

        mydma_stream_args sa{};
        sa.mask = 0xF;
        for (unsigned p = 0; p < P; ++p) sa.bytes[p] = lane_bytes;
        const int stream_ret = ::ioctl(fd, MYDMA_STREAM_CMD, &sa);
        const int stream_errno = errno;
        act.join();

        if (stream_ret < 0) { errno = stream_errno; std::perror("MYDMA_STREAM_CMD (dmesg?)"); }
        if (xfer_ret < 0)   { errno = xfer_errno;   std::perror("MYDMA_XFER_CMD (max_xfer? dmesg?)"); }

        size_t bad = 0;
        const size_t got = xfer_ret < 0 ? 0 : xa.rx_bytes / 8;
        for (size_t i = 0; i < expect.size(); ++i)
            if (i >= got || rx[i] != expect[i]) {
                if (bad < 5)
                    std::printf("  sum %zu (n = %zu, g = %zu): got %lld, expected %lld\n", i,
                                ((i / (T * P * G)) * P + (i / T) % P) * T + i % T,
                                (i / (T * P)) % G,
                                (long long)(i < got ? rx[i] : 0), (long long)expect[i]);
                ++bad;
            }
        const bool ok = stream_ret == 0 && xfer_ret == 0 && got == expect.size() && bad == 0;
        if (!ok) ++failed_calls;
        std::printf("call %u: %zu of %zu sums received, %zu wrong, weights streamed in %.1f us -> %s\n",
                    call, got, expect.size(), bad, sa.elapsed_ns / 1e3, ok ? "OK" : "FAIL");
    }
    std::printf("%s\n", failed_calls ? "FAIL" : "PASS");
    return failed_calls ? 1 : 0;
}
