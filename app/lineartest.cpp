// lineartest.cpp - one LINEAR call through hw/controller, checked against a
// CPU reference. Decode shape: one token, y = W x.
//
//   tx (activations) --axi_dma_4 MM2S--> activation_buffer --+
//   w0..w3 (packed weights) --axi_dma_0..3 MM2S--> FIFOs ----+--> axi_controller <--> tile
//   rx <--axi_dma_4 S2MM-- results <--------------------------+
//
// Version A (controller LEVEL2 = 0): the board returns one exact integer per
//   (output n, K-group g), the raw tile sum as int64 (fp8_golden's level 1).
// Version B (LEVEL2 = 1): the buffer also gets the activation scales, and the
//   board returns y[n] as fp32 (level 2 on chip), bit-exact with fp8_golden.
//
// Random FP8 data and scales; weights packed like fp8_golden.pack_weight_streams.
// The call needs two DMA commands at once: MYDMA_XFER_CMD (activations in,
// results out) blocks until the results arrive, and they only arrive while
// MYDMA_STREAM_CMD feeds the weights. So XFER runs on a second thread.
//
// Build:  make -C app lineartest
// Run:    sudo insmod mydma.ko max_xfer=1048576
//         sudo ./lineartest                     # version A, N = 1024, K = 1024
//         sudo ./lineartest 4096 1024 5 B       # N, K, calls, version
// Sim:    ./lineartest 256 1024 1 B <dir>       # no board: writes the same data as
//                                               # hex for hw/controller/sim/tb_axi_controller.v
// Limits: N a multiple of 64 (128 in version B, the weight-scale block),
//         K a multiple of 128 and <= 3072, results <= 1 MiB.

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

static uint32_t bits(float f) { uint32_t u; std::memcpy(&u, &f, 4); return u; }

// fp8_golden.level2 for one output: same order and roundings, no fused
// multiply-add (each step goes through a volatile float; the Makefile also
// builds with -ffp-contract=off).
static float level2(const int64_t *iacc, const float *sa, const float *sw, unsigned G) {
    volatile float acc = 0.0f;
    for (unsigned g = 0; g < G; ++g) {
        volatile float p = float(iacc[g]) * 0x1p-18f;   // int64 -> float rounds to nearest even
        volatile float s = sa[g] * sw[g];
        volatile float t = p * s;
        acc = acc + t;
    }
    return acc;
}

// Hex files for hw/controller/sim/tb_axi_controller.v (one beat per line, byte 0 = LSB).
static void dump(const char *dir, const std::vector<uint8_t> *lane, uint32_t lane_bytes,
                 const std::vector<uint8_t> &tx, const std::vector<uint8_t> &expect,
                 unsigned word_bytes, unsigned G, unsigned N, bool ver_b) {
    ::mkdir(dir, 0755);                      // fine if it already exists
    auto open_w = [&](const char *name) {
        std::string path = std::string(dir) + "/" + name;
        FILE *f = std::fopen(path.c_str(), "w");
        if (!f) die(path.c_str());
        return f;
    };
    auto lines = [](FILE *f, const uint8_t *b, size_t n, unsigned w) {
        for (size_t i = 0; i < n; i += w) {
            for (int k = int(w) - 1; k >= 0; --k) std::fprintf(f, "%02x", b[i + k]);
            std::fprintf(f, "\n");
        }
        std::fclose(f);
    };
    char name[32];
    for (unsigned p = 0; p < P; ++p) {
        std::snprintf(name, sizeof name, "port%u.hex", p);
        lines(open_w(name), lane[p].data(), lane_bytes, 16);
    }
    lines(open_w("act.hex"), tx.data(), tx.size(), 16);
    lines(open_w("exp.hex"), expect.data(), expect.size(), word_bytes);
    FILE *f = open_w("params.vh");
    std::fprintf(f, "`define G %u\n`define LANE_BEATS %u\n`define NSUMS %u\n`define NOUT %u\n"
                    "`define LEVEL2 %d\n`define VDIR \"%s\"\n",
                 G, lane_bytes / 16, N * G, N, ver_b ? 1 : 0, dir);
    std::fclose(f);
    std::printf("wrote test vectors to %s\n", dir);
}

int main(int argc, char **argv) {
    const unsigned N = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 1024;
    const unsigned K = argc > 2 ? std::strtoul(argv[2], nullptr, 0) : 1024;
    const unsigned calls = argc > 3 ? std::strtoul(argv[3], nullptr, 0) : 1;
    const bool ver_b = argc > 4 && (argv[4][0] == 'B' || argv[4][0] == 'b');
    const char *dump_dir = argc > 5 ? argv[5] : nullptr;
    const unsigned G = K / GROUP;
    if (N == 0 || N % (ver_b ? GROUP : T * P) || K == 0 || K % GROUP || K > 3072 || calls == 0) {
        std::fprintf(stderr, "usage: %s [N] [K] [calls] [A|B] [dump dir]\n"
                             "  N multiple of 64 (128 for B), K multiple of 128 and <= 3072\n",
                     argv[0]);
        return 2;
    }
    const unsigned word_bytes = ver_b ? 4 : 8;           // fp32 out, or int64 sums
    const unsigned n_words = ver_b ? N : N * G;
    const uint32_t lane_bytes = (N / (T * P)) * G * (16 + GROUP * T);
    const uint32_t res_bytes = n_words * word_bytes;
    if (res_bytes > MYDMA_BUF_SIZE) {
        std::fprintf(stderr, "results (%u bytes) don't fit the 1 MiB rx buffer\n", res_bytes);
        return 2;
    }

    // ---- random FP8 weights W[N][K] (PyTorch layout), activations x[K], and
    //      scales: s_w per 128x128 block of W, s_a per group (all positive) ----
    std::mt19937 rng(1);
    std::uniform_real_distribution<float> scale(1e-4f, 1e-2f);
    std::vector<uint8_t> W(size_t(N) * K), x(K);
    for (auto &c : W) c = random_code(rng);
    for (auto &c : x) c = random_code(rng);
    std::vector<float> sw(size_t((N + GROUP - 1) / GROUP) * G), sa(G);
    for (auto &v : sw) v = ver_b ? scale(rng) : 1.0f;
    for (auto &v : sa) v = scale(rng);

    // ---- activation buffer contents: codes, then (version B) s_a[g] at word 8G + g ----
    std::vector<uint8_t> tx(K + (ver_b ? 16 * G : 0), 0);
    std::memcpy(tx.data(), x.data(), K);
    if (ver_b)
        for (unsigned g = 0; g < G; ++g) std::memcpy(&tx[K + 16 * g], &sa[g], 4);

    // ---- pack the lanes: n-tile j -> lane j % 4; per tile, per group:
    //      one scale beat (s_w in bytes 0-3) + 128 rows of 16 bytes,
    //      row k, byte c = W[16j + c][k]   (fp8_golden.pack_weight_streams) ----
    std::vector<uint8_t> lane[P];
    for (auto &l : lane) l.assign(lane_bytes, 0);
    uint32_t pos[P] = {};
    for (unsigned j = 0; j < N / T; ++j) {
        const unsigned p = j % P;
        for (unsigned g = 0; g < G; ++g) {
            std::memcpy(&lane[p][pos[p]], &sw[(j * T / GROUP) * G + g], 4);
            pos[p] += 16;
            for (unsigned k = g * GROUP; k < (g + 1) * GROUP; ++k)
                for (unsigned c = 0; c < T; ++c)
                    lane[p][pos[p]++] = W[size_t(j * T + c) * K + k];
        }
    }

    // ---- level-1 sums for every (n, g) ----
    std::vector<int64_t> iacc(size_t(N) * G);
    for (unsigned n = 0; n < N; ++n)
        for (unsigned g = 0; g < G; ++g) {
            int64_t s = 0;
            for (unsigned k = g * GROUP; k < (g + 1) * GROUP; ++k)
                s += int64_t(dec(x[k])) * dec(W[size_t(n) * K + k]);
            iacc[size_t(n) * G + g] = s;
        }

    // ---- expected results, as bytes, in the order the board sends them ----
    //   A: for quad q, for group g, for lane p: 16 sums of tile 4q + p (int64)
    //   B: y[0 .. N-1] (fp32)
    std::vector<uint8_t> expect(size_t(n_words) * word_bytes);
    if (!ver_b) {
        size_t i = 0;
        for (unsigned q = 0; q < N / (T * P); ++q)
            for (unsigned g = 0; g < G; ++g)
                for (unsigned p = 0; p < P; ++p)
                    for (unsigned c = 0; c < T; ++c, ++i)
                        std::memcpy(&expect[8 * i], &iacc[size_t((q * P + p) * T + c) * G + g], 8);
    } else {
        for (unsigned n = 0; n < N; ++n) {
            const float y = level2(&iacc[size_t(n) * G], sa.data(), &sw[(n / GROUP) * G], G);
            std::memcpy(&expect[4 * size_t(n)], &y, 4);
        }
    }

    std::printf("version %c, N = %u, K = %u (G = %u): %u bytes per weight lane, %u result bytes\n",
                ver_b ? 'B' : 'A', N, K, G, lane_bytes, res_bytes);

    if (dump_dir) {
        dump(dump_dir, lane, lane_bytes, tx, expect, word_bytes, G, N, ver_b);
        return 0;
    }

    // ---- the board ----
    int fd = ::open("/dev/mydma", O_RDWR);
    if (fd < 0) die("open /dev/mydma (insmod mydma.ko?)");
    mydma_info_args info{};
    if (::ioctl(fd, MYDMA_INFO_CMD, &info) < 0) die("ioctl MYDMA_INFO_CMD");
    if ((info.w_mask & 0xF) != 0xF) {
        std::fprintf(stderr, "need all 4 weight engines, driver reports mask 0x%x\n", info.w_mask);
        return 1;
    }
    auto *txm = static_cast<uint8_t *>(::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE,
                                              MAP_SHARED, fd, MYDMA_TX_OFFSET));
    auto *rxm = static_cast<uint8_t *>(::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE,
                                              MAP_SHARED, fd, MYDMA_RX_OFFSET));
    if (txm == MAP_FAILED || rxm == MAP_FAILED) die("mmap tx/rx");
    for (unsigned p = 0; p < P; ++p) {
        if (lane_bytes > info.w_buf_bytes[p]) {
            std::fprintf(stderr, "lane %u needs %u bytes, buffer is %u (insmod wbuf_mb=...)\n",
                         p, lane_bytes, info.w_buf_bytes[p]);
            return 2;
        }
        void *m = ::mmap(nullptr, lane_bytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                         off_t(MYDMA_W_OFFSET(p)));
        if (m == MAP_FAILED) die("mmap weight buffer");
        std::memcpy(m, lane[p].data(), lane_bytes);
    }

    unsigned failed_calls = 0;
    for (unsigned call = 0; call < calls; ++call) {
        std::memcpy(txm, tx.data(), tx.size());
        std::memset(rxm, 0, res_bytes);               // a stale buffer can't pass

        mydma_xfer_args xa{};
        xa.tx_bytes = uint32_t(tx.size());
        xa.rx_bytes = res_bytes;
        int xfer_ret = 0, xfer_errno = 0;
        std::thread act([&] {
            xfer_ret = ::ioctl(fd, MYDMA_XFER_CMD, &xa);
            xfer_errno = errno;
        });
        std::this_thread::sleep_for(std::chrono::milliseconds(5));   // let XFER arm S2MM first

        mydma_stream_args st{};
        st.mask = 0xF;
        for (unsigned p = 0; p < P; ++p) st.bytes[p] = lane_bytes;
        const int stream_ret = ::ioctl(fd, MYDMA_STREAM_CMD, &st);
        const int stream_errno = errno;
        act.join();

        if (stream_ret < 0) { errno = stream_errno; std::perror("MYDMA_STREAM_CMD (dmesg?)"); }
        if (xfer_ret < 0)   { errno = xfer_errno;   std::perror("MYDMA_XFER_CMD (max_xfer? dmesg?)"); }

        size_t bad = 0;
        const size_t got = xfer_ret < 0 ? 0 : xa.rx_bytes / word_bytes;
        for (size_t i = 0; i < n_words; ++i) {
            const bool same = i < got && std::memcmp(&rxm[i * word_bytes], &expect[i * word_bytes],
                                                     word_bytes) == 0;
            if (same) continue;
            if (bad < 5) {
                if (ver_b) {
                    float g, e;
                    std::memcpy(&g, &rxm[4 * i], 4);
                    std::memcpy(&e, &expect[4 * i], 4);
                    std::printf("  y[%zu]: got %.9g (%08x), expected %.9g (%08x)\n", i, g, bits(g),
                                e, bits(e));
                } else {
                    int64_t g, e;
                    std::memcpy(&g, &rxm[8 * i], 8);
                    std::memcpy(&e, &expect[8 * i], 8);
                    std::printf("  sum %zu (n = %zu, g = %zu): got %lld, expected %lld\n", i,
                                ((i / (T * P * G)) * P + (i / T) % P) * T + i % T,
                                (i / (T * P)) % G, (long long)g, (long long)e);
                }
            }
            ++bad;
        }
        const bool ok = stream_ret == 0 && xfer_ret == 0 && got == n_words && bad == 0;
        if (!ok) ++failed_calls;
        std::printf("call %u: %zu of %u %s received, %zu wrong, weights streamed in %.1f us -> %s\n",
                    call, got, n_words, ver_b ? "outputs" : "sums", bad, st.elapsed_ns / 1e3,
                    ok ? "OK" : "FAIL");
    }
    std::printf("%s\n", failed_calls ? "FAIL" : "PASS");
    return failed_calls ? 1 : 0;
}
