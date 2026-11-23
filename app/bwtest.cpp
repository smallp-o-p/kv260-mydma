// bwtest.cpp - DDR -> PL read bandwidth over the weight engines w0..w3.
//
// Each weight engine is an MM2S-only AXI DMA on its own HP port, streaming
// into a sink that always accepts (hw/axis_sink.v). MYDMA_STREAM_CMD starts
// the chosen engines together and reports when each one finished, so this
// measures what the HP ports and the DDR controller can actually deliver.
//
// Build in WSL:   make -C app
// Run on board:   sudo ./bwtest              # 32 MiB per engine, 20 runs each
//                 sudo ./bwtest 16 50        # 16 MiB per engine, 50 runs
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

Result run_once(int fd, unsigned mask, std::uint32_t bytes) {
    mydma_stream_args a{};
    a.mask = mask;
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
    return r;
}

std::string mask_name(unsigned mask) {
    std::string s;
    for (int i = 0; i < MYDMA_NUM_W; ++i)
        if (mask & (1u << i))
            s += (s.empty() ? "w" : "+w") + std::to_string(i);
    return s;
}

}  // namespace

int main(int argc, char **argv) {
    const unsigned long mib = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 32;
    const long runs = argc > 2 ? std::strtol(argv[2], nullptr, 0) : 20;

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
        std::printf("w%d: %u MiB buffer, testing %lu MiB\n", i,
                    info.w_buf_bytes[i] >> 20, mib);
    }

    // Every single engine, every pair, every triple, then all four.
    std::vector<unsigned> masks;
    for (int n = 1; n <= MYDMA_NUM_W; ++n)
        for (unsigned m = 1; m < (1u << MYDMA_NUM_W); ++m)
            if ((m & info.w_mask) == m && __builtin_popcount(m) == n)
                masks.push_back(m);

    std::printf("\n%-14s %10s %10s   per engine GB/s (median run)\n",
                "engines", "best GB/s", "median");
    for (unsigned m : masks) {
        run_once(fd, m, bytes);                      // warm-up, not counted
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
    ::close(fd);
    return 0;
}
