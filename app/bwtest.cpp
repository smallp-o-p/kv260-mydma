// bwtest.cpp - DDR -> PL read bandwidth over the weight engines w0..w3.
//
// Each weight engine is an AXI DMA on its own HP port. In the standard
// multi_hp design (4 readers + 1 writer) every lane is MM2S only, into
// hw/lane_checker.v, which writes one 16-byte result per finished transfer
// through the activation DMA's S2MM. bwtest checks every result: magic,
// lane id, beat count and the XOR of the lane's data, computed here.
// Other lane types (use --no-results for a design without lane_checker):
//   - sink lane: MM2S only, into hw/axis_sink.v. Measures pure DDR reads.
//   - loopback lane (the driver reports a w<i>rx channel): MM2S ->
//     hw/axis_incrementer.vhd (DATA_WIDTH=128) -> S2MM. Checks the data:
//     every 32-bit word must come back as the word sent plus 1. The DDR then
//     carries each byte twice (read and write back), so GB/s here is the
//     read rate with an equal write load running at the same time.
// MYDMA_STREAM_CMD starts the chosen engines together and reports when each
// one finished.
//
// Build in WSL:   make -C app
// Run on board:   sudo ./bwtest              # 16 MiB per engine, 20 runs each
//                 sudo ./bwtest 8 50         # 8 MiB per engine, 50 runs
//                 sudo ./bwtest 16 20 --no-results   # no lane_checker
//
// It runs every engine alone, then the pairs, then all of them. The pairs
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

[[noreturn]] void die(const char *what) {
    std::fprintf(stderr, "error: %s: %s\n", what, std::strerror(errno));
    std::exit(1);
}

struct Result {
    double agg_gbs;                  // total bytes / (first start -> last done)
    double eng_gbs[MYDMA_NUM_W];     // bytes_i / (first start -> engine i done)
};

std::string mask_name(unsigned mask) {
    std::string s;
    for (int i = 0; i < MYDMA_NUM_W; ++i)
        if (mask & (1u << i))
            s += (s.empty() ? "w" : "+w") + std::to_string(i);
    return s;
}

// What lane_checker should report for each lane's buffer, and where its
// result beats land (the activation DMA's rx buffer).
bool g_results = true;
std::uint64_t g_expect_xor[MYDMA_NUM_W];
std::uint32_t g_expect_beats;
const volatile std::uint32_t *g_res = nullptr;
long g_result_errors = 0;

void check_results(unsigned mask) {
    unsigned seen = 0;
    const int n = __builtin_popcount(mask);
    for (int k = 0; k < n; ++k) {
        const volatile std::uint32_t *b = g_res + 4 * k;   // one 16-byte beat
        const std::uint64_t x = std::uint64_t(b[0]) | (std::uint64_t(b[1]) << 32);
        const std::uint32_t beats = b[2], top = b[3];
        const unsigned lane = top & 0xff;
        const bool ok = (top >> 8) == 0xC0FFEEu && lane < MYDMA_NUM_W &&
                        (mask & (1u << lane)) && !(seen & (1u << lane)) &&
                        beats == g_expect_beats && x == g_expect_xor[lane];
        if (!ok) {
            if (g_result_errors < 10)
                std::printf("  result %d of %s wrong: %08x %08x %08x %08x "
                            "(want C0FFEE0%u, %u beats, xor %016llx)\n", k,
                            mask_name(mask).c_str(), top, beats, b[1], b[0],
                            lane < MYDMA_NUM_W ? lane : 0, g_expect_beats,
                            (unsigned long long)g_expect_xor[lane < MYDMA_NUM_W ? lane : 0]);
            ++g_result_errors;
        }
        seen |= 1u << (lane & 31);
    }
}

Result run_once(int fd, unsigned mask, std::uint32_t bytes) {
    mydma_stream_args a{};
    a.mask = mask;
    a.flags = g_results ? MYDMA_STREAM_RESULTS : 0;
    if (g_results)
        for (int k = 0; k < 4 * MYDMA_NUM_W; ++k)
            const_cast<volatile std::uint32_t *>(g_res)[k] = 0;   // no stale pass
    for (int i = 0; i < MYDMA_NUM_W; ++i)
        if (mask & (1u << i))
            a.bytes[i] = bytes;
    if (::ioctl(fd, MYDMA_STREAM_CMD, &a) < 0)
        die("ioctl MYDMA_STREAM_CMD");

    Result r{};
    double total = 0;
    for (int i = 0; i < MYDMA_NUM_W; ++i) {
        if (!(mask & (1u << i)))
            continue;
        total += bytes;
        r.eng_gbs[i] = double(bytes) / double(a.done_ns[i]);   // bytes/ns = GB/s
    }
    r.agg_gbs = total / double(a.elapsed_ns);
    if (g_results)
        check_results(mask);
    return r;
}


}  // namespace

int main(int argc, char **argv) {
    std::vector<const char *> pos;
    for (int k = 1; k < argc; ++k) {
        if (std::strcmp(argv[k], "--no-results") == 0)
            g_results = false;
        else
            pos.push_back(argv[k]);
    }
    const unsigned long mib = pos.size() > 0 ? std::strtoul(pos[0], nullptr, 0) : 16;
    const long runs = pos.size() > 1 ? std::strtol(pos[1], nullptr, 0) : 20;

    int fd = ::open("/dev/mydma", O_RDWR);
    if (fd < 0)
        die("open /dev/mydma");

    mydma_info_args info{};
    if (::ioctl(fd, MYDMA_INFO_CMD, &info) < 0)
        die("ioctl MYDMA_INFO_CMD (driver too old?)");
    if (!info.w_mask) {
        std::fprintf(stderr, "no weight engines: the overlay has no w0..w3 in dma-names\n");
        return 1;
    }

    const std::uint32_t bytes = std::uint32_t(mib << 20);
    g_expect_beats = bytes / 16;
    if (g_results) {
        void *p = ::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                         MYDMA_RX_OFFSET);
        if (p == MAP_FAILED)
            die("mmap rx (result) buffer");
        g_res = static_cast<const volatile std::uint32_t *>(p);
    }
    std::uint32_t *txbuf[MYDMA_NUM_W] = {};
    std::uint32_t *rxbuf[MYDMA_NUM_W] = {};
    for (int i = 0; i < MYDMA_NUM_W; ++i) {
        if (!(info.w_mask & (1u << i)))
            continue;
        if (mib == 0 || bytes > info.w_buf_bytes[i]) {
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
        txbuf[i] = w;
        std::uint64_t x = 0;                     // lane_checker's XOR fold
        for (std::size_t k = 0; k + 1 < bytes / 4; k += 2)
            x ^= std::uint64_t(w[k]) | (std::uint64_t(w[k + 1]) << 32);
        g_expect_xor[i] = x;
        const bool loop = info.w_rx_mask & (1u << i);
        if (loop) {
            void *q = ::mmap(nullptr, bytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
                             off_t(MYDMA_W_RX_OFFSET(i)));
            if (q == MAP_FAILED)
                die("mmap loopback rx buffer");
            rxbuf[i] = static_cast<std::uint32_t *>(q);
        }
        std::printf("w%d: %u MiB buffer, testing %lu MiB, %s lane\n", i,
                    info.w_buf_bytes[i] >> 20, mib, loop ? "loopback (checked)" : "sink");
    }

    // Loopback lanes: clear rx, run once, then every word must be tx + 1.
    long bad_lanes = 0;
    auto check = [&](unsigned mask) {
        for (int i = 0; i < MYDMA_NUM_W; ++i)
            if ((mask & (1u << i)) && rxbuf[i])
                std::memset(rxbuf[i], 0, bytes);
        run_once(fd, mask, bytes);
        for (int i = 0; i < MYDMA_NUM_W; ++i) {
            if (!(mask & (1u << i)) || !rxbuf[i])
                continue;
            std::size_t bad = 0, first = 0;
            for (std::size_t k = 0; k < bytes / 4; ++k)
                if (rxbuf[i][k] != txbuf[i][k] + 1u && bad++ == 0)
                    first = k;
            if (bad) {
                std::printf("  %s: w%d DATA ERROR: %zu of %u words wrong, first at word %zu "
                            "(sent 0x%08x, got 0x%08x)\n", mask_name(mask).c_str(), i, bad,
                            bytes / 4, first, txbuf[i][first], rxbuf[i][first]);
                ++bad_lanes;
            }
        }
    };

    // Every single engine, every pair, every triple, then all four.
    std::vector<unsigned> masks;
    for (int n = 1; n <= MYDMA_NUM_W; ++n)
        for (unsigned m = 1; m < (1u << MYDMA_NUM_W); ++m)
            if ((m & info.w_mask) == m && __builtin_popcount(m) == n)
                masks.push_back(m);

    std::printf("\n%-14s %10s %10s   per engine GB/s (median run)\n",
                "engines", "best GB/s", "median");
    for (unsigned m : masks) {
        check(m);                                    // warm-up + data check, not timed
        std::vector<Result> rs;
        for (long k = 0; k < runs; ++k)
            rs.push_back(run_once(fd, m, bytes));
        std::sort(rs.begin(), rs.end(),
                  [](const Result &a, const Result &b) { return a.agg_gbs < b.agg_gbs; });
        const Result &med = rs[rs.size() / 2];
        std::printf("%-14s %10.2f %10.2f  ", mask_name(m).c_str(),
                    rs.back().agg_gbs, med.agg_gbs);
        for (int i = 0; i < MYDMA_NUM_W; ++i)
            if (m & (1u << i))
                std::printf(" w%d=%.2f", i, med.eng_gbs[i]);
        std::printf("\n");
    }

    std::printf("\nCeiling per engine: 16 B x f_clk (4.0 GB/s at 250 MHz). "
                "DDR4-2400 x64 peak is 19.2 GB/s.\n");
    if (info.w_rx_mask)
        std::printf("Loopback lanes also write every byte back, so DDR traffic on them "
                    "is twice the GB/s shown.\n%s\n",
                    bad_lanes ? "DATA CHECK FAILED (see above)" : "Data check: all loopback lanes OK");
    // The activation path: MM2S on the activation DMA into lane_checker's
    // input 4, one result back through the same S2MM. 8 KiB stays under the
    // driver's default max_xfer.
    if (g_results) {
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
        for (int k = 0; k < 4; ++k)
            const_cast<volatile std::uint32_t *>(g_res)[k] = 0;
        mydma_xfer_args xa{};
        xa.tx_bytes = act_bytes;
        xa.rx_bytes = MYDMA_RESULT_BYTES;
        if (::ioctl(fd, MYDMA_XFER_CMD, &xa) < 0)
            die("ioctl MYDMA_XFER_CMD (activation path)");
        const std::uint64_t gx = std::uint64_t(g_res[0]) | (std::uint64_t(g_res[1]) << 32);
        const bool ok = xa.rx_bytes == MYDMA_RESULT_BYTES && g_res[3] == 0xC0FFEE04u &&
                        g_res[2] == act_bytes / 16 && gx == x;
        std::printf("activation path (8 KiB in, 1 result out): %s\n",
                    ok ? "OK" : "WRONG");
        if (!ok) {
            std::printf("  got %08x %08x %08x %08x, want c0ffee04 %08x xor %016llx\n",
                        g_res[3], g_res[2], g_res[1], g_res[0], act_bytes / 16,
                        (unsigned long long)x);
            ++g_result_errors;
        }
        ::munmap(p, MYDMA_BUF_SIZE);
    }

    if (g_results)
        std::printf("Result beats: %s\n", g_result_errors
                        ? (std::to_string(g_result_errors) + " wrong (see above)").c_str()
                        : "all correct (count and XOR on every lane, every run)");
    ::close(fd);
    return (bad_lanes || g_result_errors) ? 1 : 0;
}
