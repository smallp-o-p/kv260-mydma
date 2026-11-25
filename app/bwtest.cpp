// bwtest.cpp - DDR -> PL read bandwidth over the weight engines w0..w3,
// checked end to end through hw/lane_checker.v.
//
// Each weight engine is an MM2S-only AXI DMA on its own HP port (HP0..HP3),
// feeding lane_checker. For every finished transfer lane_checker writes one
// 16-byte result beat back through the activation DMA's S2MM (on HPC0):
//   [63:0] XOR of the lane's data folded to 64 bits, [95:64] beat count,
//   [103:96] lane id, [127:104] 0xC0FFEE.
// bwtest computes the same XOR over its own buffer and checks every beat of
// every run, so a pass means the bytes really arrived, not just that the DMA
// said it finished. It also proves the driver's cache sync: the buffers are
// filled through a cached mapping.
//
// Build in WSL:   make -C app
// Run on board:   sudo ./bwtest              # 16 MiB per engine, 20 runs each
//                 sudo ./bwtest 8 50         # 8 MiB per engine, 50 runs
//                 sudo ./bwtest --diag       # each piece alone, with IRQ counts
//
// It runs every engine alone, then the pairs, triples and all four. The pairs
// show whether two HP ports share a DDR controller port: a pair that shares
// one tops out lower than a pair that doesn't.

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#include <algorithm>
#include <cerrno>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#include "mydma_uapi.h"

namespace {

constexpr unsigned NW = MYDMA_W_NUM_CHANNELS;

[[noreturn]] void die(const char *what) {
    std::fprintf(stderr, "error: %s: %s\n", what, std::strerror(errno));
    std::exit(1);
}

struct Result {
    double agg_gbs;          // total bytes / (first start -> last lane done)
    double eng_gbs[NW];      // bytes_i / (first start -> lane i done)
};

std::string mask_name(unsigned mask) {
    std::string s;
    for (unsigned i = 0; i < NW; ++i)
        if (mask & (1u << i))
            s += (s.empty() ? "w" : "+w") + std::to_string(i);
    return s;
}

// What lane_checker should report for each lane, and where its result beats
// land (start of the activation DMA's rx buffer, in the order lanes finish).
std::uint64_t g_expect_xor[NW];
std::uint32_t g_expect_beats;
volatile std::uint32_t *g_res = nullptr;
long g_result_errors = 0;

void clear_results(unsigned n) {
    for (unsigned k = 0; k < 4 * n; ++k)
        g_res[k] = 0;                        // so a stale beat can't pass
}

void check_results(unsigned mask) {
    unsigned seen = 0;
    const unsigned n = __builtin_popcount(mask);
    for (unsigned k = 0; k < n; ++k) {
        const volatile std::uint32_t *b = g_res + 4 * k;   // one 16-byte beat
        const std::uint64_t x = std::uint64_t(b[0]) | (std::uint64_t(b[1]) << 32);
        const std::uint32_t beats = b[2], top = b[3];
        const unsigned lane = top & 0xff;
        const bool ok = (top >> 8) == 0xC0FFEEu && lane < NW &&
                        (mask & (1u << lane)) && !(seen & (1u << lane)) &&
                        beats == g_expect_beats && x == g_expect_xor[lane];
        if (!ok) {
            if (g_result_errors < 10)
                std::printf("  result %u of %s wrong: %08x %08x %08x %08x "
                            "(want C0FFEE0x, %u beats, xor %016llx for lane x)\n", k,
                            mask_name(mask).c_str(), top, beats, b[1], b[0], g_expect_beats,
                            (unsigned long long)g_expect_xor[lane < NW ? lane : 0]);
            ++g_result_errors;
        }
        seen |= 1u << (lane & 31);
    }
}

Result run_once(int fd, unsigned mask, std::uint32_t bytes) {
    mydma_stream_args a{};
    a.mask = mask;
    a.flags = MYDMA_STREAM_RESULTS;
    clear_results(NW);
    for (unsigned i = 0; i < NW; ++i)
        if (mask & (1u << i))
            a.bytes[i] = bytes;
    if (::ioctl(fd, MYDMA_STREAM_CMD, &a) < 0)
        die("ioctl MYDMA_STREAM_CMD (check dmesg)");

    Result r{};
    double total = 0;
    for (unsigned i = 0; i < NW; ++i) {
        if (!(mask & (1u << i)))
            continue;
        total += bytes;
        r.eng_gbs[i] = double(bytes) / double(a.done_ns[i]);   // bytes/ns = GB/s
    }
    r.agg_gbs = total / double(a.elapsed_ns);
    check_results(mask);
    return r;
}

// ---- --diag: test each piece on its own, and show which DMA IRQs fire ----

void print_dma_irqs(const char *when) {
    std::printf("  DMA interrupt counts %s:\n", when);
    FILE *f = std::fopen("/proc/interrupts", "r");
    if (!f) {
        std::printf("    (can't read /proc/interrupts)\n");
        return;
    }
    char line[512];
    while (std::fgets(line, sizeof line, f))
        if (std::strstr(line, "dma") && !std::strstr(line, "zynqmp"))
            std::printf("    %s", line);
    std::fclose(f);
}

void print_beat(const char *what) {
    std::printf("  %s: %08x %08x %08x %08x\n", what, g_res[3], g_res[2], g_res[1], g_res[0]);
}

int diag(int fd) {
    void *rp = ::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                      MYDMA_RX_OFFSET);
    void *tp = ::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                      MYDMA_TX_OFFSET);
    if (rp == MAP_FAILED || tp == MAP_FAILED)
        die("mmap act tx/rx");
    g_res = static_cast<volatile std::uint32_t *>(rp);
    auto *t = static_cast<std::uint32_t *>(tp);
    int fails = 0;

    print_dma_irqs("at start");

    // 1. Activation path only: act MM2S -> lane_checker input 4 -> act S2MM.
    //    No weight engines involved. A stale result from an earlier failed
    //    run would show up here with that lane's id instead of 04.
    std::printf("\n[1] activation path: XFER 8 KiB in, 16 B out\n");
    for (std::uint32_t k = 0; k < 8192 / 4; ++k)
        t[k] = k;
    clear_results(1);
    mydma_xfer_args xa{};
    xa.tx_bytes = 8192;
    xa.rx_bytes = MYDMA_RESULT_BYTES;
    if (::ioctl(fd, MYDMA_XFER_CMD, &xa) < 0) {
        std::printf("  FAILED: %s\n", std::strerror(errno));
        ++fails;
    } else {
        std::printf("  ok, %u bytes back\n", xa.rx_bytes);
    }
    print_beat("result beat (want c0ffee04 00000200 ...)");
    print_dma_irqs("after [1]");

    // 2. Each weight engine alone, 64 KiB, with results.
    mydma_info_args info{};
    if (::ioctl(fd, MYDMA_INFO_CMD, &info) < 0)
        die("ioctl MYDMA_INFO_CMD");
    const std::uint32_t bytes = 64 * 1024;
    for (unsigned i = 0; i < NW; ++i) {
        if (!(info.w_mask & (1u << i)))
            continue;
        std::printf("\n[2.%u] w%u alone: STREAM 64 KiB with results\n", i, i);
        void *p = ::mmap(nullptr, bytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                         off_t(MYDMA_W_OFFSET(i)));
        if (p == MAP_FAILED)
            die("mmap weight buffer");
        std::memset(p, 0x11 * (i + 1), bytes);
        ::munmap(p, bytes);
        clear_results(1);
        mydma_stream_args a{};
        a.mask = 1u << i;
        a.bytes[i] = bytes;
        a.flags = MYDMA_STREAM_RESULTS;
        if (::ioctl(fd, MYDMA_STREAM_CMD, &a) < 0) {
            std::printf("  FAILED: %s\n", std::strerror(errno));
            ++fails;
        } else {
            std::printf("  ok, lane done after %llu ns\n", (unsigned long long)a.done_ns[i]);
        }
        std::printf("  result beat (want c0ffee0%u 00001000 00000000 00000000): ", i);
        std::printf("%08x %08x %08x %08x\n", g_res[3], g_res[2], g_res[1], g_res[0]);
        print_dma_irqs("after this step");
    }

    std::printf("\n%s. Send this output and `dmesg | tail -30`.\n",
                fails ? "Some steps FAILED" : "All steps passed");
    return fails ? 1 : 0;
}

}  // namespace

int main(int argc, char **argv) {
    if (argc > 1 && std::strcmp(argv[1], "--diag") == 0) {
        int fd = ::open("/dev/mydma", O_RDWR);
        if (fd < 0)
            die("open /dev/mydma");
        return diag(fd);
    }
    const unsigned long mib = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 16;
    const long runs = argc > 2 ? std::strtol(argv[2], nullptr, 0) : 20;
    if (runs < 1) {
        std::fprintf(stderr, "usage: %s [MiB per engine] [runs >= 1]\n", argv[0]);
        return 2;
    }

    int fd = ::open("/dev/mydma", O_RDWR);
    if (fd < 0)
        die("open /dev/mydma");

    mydma_info_args info{};
    if (::ioctl(fd, MYDMA_INFO_CMD, &info) < 0)
        die("ioctl MYDMA_INFO_CMD (driver too old?)");
    if (!info.w_mask) {
        std::fprintf(stderr, "no weight engines reported by the driver\n");
        return 1;
    }

    const std::uint32_t bytes = std::uint32_t(mib << 20);
    g_expect_beats = bytes / 16;

    void *rp = ::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                      MYDMA_RX_OFFSET);
    if (rp == MAP_FAILED)
        die("mmap rx (result) buffer");
    g_res = static_cast<volatile std::uint32_t *>(rp);

    for (unsigned i = 0; i < NW; ++i) {
        if (!(info.w_mask & (1u << i)))
            continue;
        if (mib == 0 || mib > 4095 || bytes > info.w_buf_bytes[i]) {
            std::fprintf(stderr, "usage: %s [MiB per engine, 1..%u] [runs]\n",
                         argv[0], info.w_buf_bytes[i] >> 20);
            return 2;
        }
        // Map and fill each buffer once, so the DMA reads real bytes.
        void *p = ::mmap(nullptr, bytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                         off_t(MYDMA_W_OFFSET(i)));
        if (p == MAP_FAILED)
            die("mmap weight buffer");
        auto *w = static_cast<std::uint32_t *>(p);
        for (std::size_t k = 0; k < bytes / 4; ++k)
            w[k] = std::uint32_t(k * 2654435761u) ^ std::uint32_t(i);
        std::uint64_t x = 0;                     // lane_checker's XOR fold
        for (std::size_t k = 0; k + 1 < bytes / 4; k += 2)
            x ^= std::uint64_t(w[k]) | (std::uint64_t(w[k + 1]) << 32);
        g_expect_xor[i] = x;
        std::printf("w%u: %u MiB buffer, testing %lu MiB\n", i,
                    info.w_buf_bytes[i] >> 20, mib);
    }

    // Every single engine, every pair, every triple, then all four.
    std::vector<unsigned> masks;
    for (unsigned n = 1; n <= NW; ++n)
        for (unsigned m = 1; m < (1u << NW); ++m)
            if ((m & info.w_mask) == m && unsigned(__builtin_popcount(m)) == n)
                masks.push_back(m);

    std::printf("\n%-14s %10s %10s   per engine GB/s (median run)\n",
                "engines", "best GB/s", "median");
    for (unsigned m : masks) {
        run_once(fd, m, bytes);                  // warm-up, checked but not timed
        std::vector<Result> rs;
        for (long k = 0; k < runs; ++k)
            rs.push_back(run_once(fd, m, bytes));
        std::sort(rs.begin(), rs.end(),
                  [](const Result &a, const Result &b) { return a.agg_gbs < b.agg_gbs; });
        const Result &med = rs[rs.size() / 2];
        std::printf("%-14s %10.2f %10.2f  ", mask_name(m).c_str(),
                    rs.back().agg_gbs, med.agg_gbs);
        for (unsigned i = 0; i < NW; ++i)
            if (m & (1u << i))
                std::printf(" w%u=%.2f", i, med.eng_gbs[i]);
        std::printf("\n");
    }

    std::printf("\nCeiling per engine: 16 B x f_clk (4.0 GB/s at 250 MHz). "
                "DDR4-2400 x64 peak is 19.2 GB/s.\n");

    // The activation path: MM2S on the activation DMA into lane_checker's
    // input 4, one result back through the same S2MM, via MYDMA_XFER_CMD.
    // 8 KiB stays under the driver's default max_xfer.
    {
        const std::uint32_t act_bytes = 8192;
        void *p = ::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                         MYDMA_TX_OFFSET);
        if (p == MAP_FAILED)
            die("mmap tx (activation) buffer");
        auto *t = static_cast<std::uint32_t *>(p);
        std::uint64_t x = 0;
        for (std::uint32_t k = 0; k < act_bytes / 4; ++k)
            t[k] = k * 0x9E3779B9u + 1;
        for (std::uint32_t k = 0; k < act_bytes / 4; k += 2)
            x ^= std::uint64_t(t[k]) | (std::uint64_t(t[k + 1]) << 32);
        clear_results(1);
        mydma_xfer_args xa{};
        xa.tx_bytes = act_bytes;
        xa.rx_bytes = MYDMA_RESULT_BYTES;
        if (::ioctl(fd, MYDMA_XFER_CMD, &xa) < 0)
            die("ioctl MYDMA_XFER_CMD (activation path)");
        const std::uint64_t gx = std::uint64_t(g_res[0]) | (std::uint64_t(g_res[1]) << 32);
        const bool ok = xa.rx_bytes == MYDMA_RESULT_BYTES && g_res[3] == 0xC0FFEE04u &&
                        g_res[2] == act_bytes / 16 && gx == x;
        std::printf("activation path (8 KiB in, 1 result out): %s\n", ok ? "OK" : "WRONG");
        if (!ok) {
            std::printf("  got %08x %08x %08x %08x (%u bytes), want c0ffee04 %08x xor %016llx\n",
                        g_res[3], g_res[2], g_res[1], g_res[0], xa.rx_bytes, act_bytes / 16,
                        (unsigned long long)x);
            ++g_result_errors;
        }
        ::munmap(p, MYDMA_BUF_SIZE);
    }

    std::printf("Result beats: %s\n", g_result_errors
                    ? (std::to_string(g_result_errors) + " wrong (see above)").c_str()
                    : "all correct (count and XOR on every lane, every run)");
    ::close(fd);
    return g_result_errors ? 1 : 0;
}
