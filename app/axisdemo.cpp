// axisdemo.cpp - drive hw/axis_demo/axis_demo.v from Linux, using both of
// its kinds of AXI port:
//
//   AXI4-Lite registers  -> mmap of /dev/mem at 0xA001_0000 (plain loads/stores)
//   AXI4-Stream in/out   -> /dev/mydma MYDMA_XFER_CMD (MM2S in, S2MM out)
//
// Build in WSL:   make -C app
// Run on board:   sudo xmutil unloadapp && sudo xmutil loadapp axis_demo
//                 sudo insmod mydma.ko max_xfer=1048576
//                 sudo ./axisdemo                  # 64 KiB, ADD = 7
//                 sudo ./axisdemo 1048576 100      # 1 MiB, ADD = 100
//
// Check: every 32-bit word comes back as input + ADD, and the block's
// BEATS / PACKETS counters say exactly one packet of bytes/16 beats went in.

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <random>

#include "mydma_uapi.h"

// Must match hw/axis_demo/build_bd.tcl and hw/axis_demo.dts.
constexpr off_t DEMO_BASE = 0xA0010000;
constexpr size_t DEMO_SPAN = 0x1000;
enum : unsigned { REG_ID = 0x00, REG_ADD = 0x04, REG_BEATS = 0x08, REG_PACKETS = 0x0C, REG_CTRL = 0x10 };
constexpr uint32_t DEMO_ID = 0xA5D00001;
constexpr unsigned BEAT_BYTES = 16;   // 128-bit stream

// One AXI-Lite access = one volatile 32-bit load or store to the mapping.
struct Regs {
    volatile uint32_t *p;
    uint32_t rd(unsigned off) const { return p[off / 4]; }
    void wr(unsigned off, uint32_t v) const { p[off / 4] = v; }
};

int main(int argc, char **argv) {
    const unsigned long bytes = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 65536;
    const uint32_t add = argc > 2 ? std::strtoul(argv[2], nullptr, 0) : 7;
    if (bytes == 0 || bytes % BEAT_BYTES || bytes > MYDMA_BUF_SIZE) {
        std::fprintf(stderr, "usage: %s [bytes (multiple of 16, max %d)] [add]\n",
                     argv[0], MYDMA_BUF_SIZE);
        return 2;
    }

    // ---- registers ----
    int memfd = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd < 0) { std::perror("open /dev/mem (run with sudo)"); return 1; }
    void *rp = mmap(nullptr, DEMO_SPAN, PROT_READ | PROT_WRITE, MAP_SHARED, memfd, DEMO_BASE);
    if (rp == MAP_FAILED) { std::perror("mmap registers"); return 1; }
    Regs regs{static_cast<volatile uint32_t *>(rp)};

    uint32_t id = regs.rd(REG_ID);
    std::printf("ID      = 0x%08x %s\n", id, id == DEMO_ID ? "(ok)" : "(WRONG: is axis_demo loaded?)");
    if (id != DEMO_ID) return 1;
    regs.wr(REG_ADD, add);
    regs.wr(REG_CTRL, 1);   // clear counters
    std::printf("ADD     = %u\n", regs.rd(REG_ADD));

    // ---- stream ----
    int fd = open("/dev/mydma", O_RDWR);
    if (fd < 0) { std::perror("open /dev/mydma (insmod mydma.ko?)"); return 1; }
    auto *tx = static_cast<uint32_t *>(mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE,
                                            MAP_SHARED, fd, MYDMA_TX_OFFSET));
    auto *rx = static_cast<uint32_t *>(mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE,
                                            MAP_SHARED, fd, MYDMA_RX_OFFSET));
    if (tx == MAP_FAILED || rx == MAP_FAILED) { std::perror("mmap dma buffers"); return 1; }

    const size_t words = bytes / 4;
    std::mt19937 rng(1);
    for (size_t i = 0; i < words; ++i) {
        tx[i] = rng();
        rx[i] = 0;
    }

    mydma_xfer_args a{};
    a.tx_bytes = bytes;   // MM2S: memory -> s_axis (TLAST on the last beat)
    a.rx_bytes = bytes;   // S2MM: m_axis -> memory, ends at TLAST
    if (ioctl(fd, MYDMA_XFER_CMD, &a) < 0) {
        std::perror("MYDMA_XFER_CMD (bytes > max_xfer?)");
        return 1;
    }

    size_t bad = 0;
    for (size_t i = 0; i < words; ++i)
        if (rx[i] != tx[i] + add && bad++ < 3)
            std::printf("word %zu: sent 0x%08x, got 0x%08x\n", i, tx[i], rx[i]);

    uint32_t beats = regs.rd(REG_BEATS), packets = regs.rd(REG_PACKETS);
    std::printf("BEATS   = %u (expect %lu)\nPACKETS = %u (expect 1)\n",
                beats, bytes / BEAT_BYTES, packets);
    std::printf("received %u of %lu bytes, %zu of %zu words wrong\n",
                a.rx_bytes, bytes, bad, words);

    bool ok = !bad && a.rx_bytes == bytes && beats == bytes / BEAT_BYTES && packets == 1;
    std::printf("%s\n", ok ? "PASS" : "FAIL");
    return ok ? 0 : 1;
}
