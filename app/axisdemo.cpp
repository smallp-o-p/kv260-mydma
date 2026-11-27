// axisdemo.cpp - stream a buffer through hw/axis_demo/axis_demo.v and check it.
//
//   memory --MM2S--> s_axis [ +ADD per 32-bit word ] m_axis --S2MM--> memory
//
// The block has no registers, so the whole test is one MYDMA_XFER_CMD.
//
// Build in WSL:   make -C app
// Run on board:   sudo xmutil unloadapp && sudo xmutil loadapp axis_demo
//                 sudo insmod mydma.ko max_xfer=1048576
//                 sudo ./axisdemo                  # 64 KiB, expects ADD = 1
//                 sudo ./axisdemo 1048576 1        # 1 MiB
// The second argument is the ADD the bitstream was built with (default 1).

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <random>

#include "mydma_uapi.h"

constexpr unsigned BEAT_BYTES = 16;   // 128-bit stream

int main(int argc, char **argv) {
    const unsigned long bytes = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 65536;
    const uint32_t add = argc > 2 ? std::strtoul(argv[2], nullptr, 0) : 1;
    if (bytes == 0 || bytes % BEAT_BYTES || bytes > MYDMA_BUF_SIZE) {
        std::fprintf(stderr, "usage: %s [bytes (multiple of 16, max %d)] [add]\n",
                     argv[0], MYDMA_BUF_SIZE);
        return 2;
    }

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
        rx[i] = 0;   // so a stale buffer can't pass
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

    std::printf("received %u of %lu bytes, %zu of %zu words wrong\n",
                a.rx_bytes, bytes, bad, words);
    bool ok = !bad && a.rx_bytes == bytes;
    std::printf("%s\n", ok ? "PASS" : "FAIL");
    return ok ? 0 : 1;
}
