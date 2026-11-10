// dmatest.cpp - loopback test for /dev/mydma using mmap + ioctl.
//
// Single-threaded: the driver's MYDMA_XFER_CMD arms S2MM before starting MM2S,
// so there is no start-up race (unlike the old read()/write() test, now
// dmatest_rw.cpp).
//
// Build in WSL:   make -C app
// Run on board:   sudo ./dmatest                 # 1000 round trips of 4 KiB
//                 sudo ./dmatest 1048576 100     # 100 round trips of 1 MiB
// Sizes above 16383 bytes need the module loaded with max_xfer, e.g.
//   sudo insmod mydma.ko max_xfer=1048576
//
// The PL design adds 1 to every 32-bit word, so the check is out[i] == in[i] + 1.

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#include <cerrno>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#include <string>
#include <system_error>

#include "mydma_uapi.h"

class MyDma {
public:
    explicit MyDma(const char *path = "/dev/mydma") {
        fd_ = ::open(path, O_RDWR);
        if (fd_ < 0)
            fail(std::string("open ") + path);
        tx_ = map(MYDMA_TX_OFFSET, "mmap tx buffer");
        rx_ = map(MYDMA_RX_OFFSET, "mmap rx buffer");
    }

    ~MyDma() {
        if (rx_) ::munmap(rx_, MYDMA_BUF_SIZE);
        if (tx_) ::munmap(tx_, MYDMA_BUF_SIZE);
        if (fd_ >= 0) ::close(fd_);
    }

    MyDma(const MyDma &) = delete;
    MyDma &operator=(const MyDma &) = delete;

    // The DMA buffers themselves. Write input into tx() before xfer(); read
    // the result from rx() after it. Both are uncached on this board: fine for
    // filling and checking, slow for heavy processing (copy out first).
    std::uint32_t *tx() { return static_cast<std::uint32_t *>(tx_); }
    const std::uint32_t *rx() const { return static_cast<const std::uint32_t *>(rx_); }

    // One round trip: send tx_bytes from tx(), receive up to rx_bytes into
    // rx(). Returns the bytes actually received.
    std::size_t xfer(std::uint32_t tx_bytes, std::uint32_t rx_bytes) {
        mydma_xfer_args args{};
        args.tx_bytes = tx_bytes;
        args.rx_bytes = rx_bytes;
        if (::ioctl(fd_, MYDMA_XFER_CMD, &args) < 0)
            fail("ioctl MYDMA_XFER_CMD");
        return args.rx_bytes;
    }

private:
    void *map(off_t offset, const char *what) {
        void *p = ::mmap(nullptr, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE,
                         MAP_SHARED, fd_, offset);
        if (p == MAP_FAILED)
            fail(what);
        return p;
    }

    [[noreturn]] void fail(const std::string &what) {
        int err = errno;
        // Clean up what was opened so far; the destructor won't run.
        if (rx_) ::munmap(rx_, MYDMA_BUF_SIZE);
        if (tx_) ::munmap(tx_, MYDMA_BUF_SIZE);
        if (fd_ >= 0) ::close(fd_);
        rx_ = tx_ = nullptr;
        fd_ = -1;
        throw std::system_error(err, std::generic_category(), what);
    }

    int fd_ = -1;
    void *tx_ = nullptr;
    void *rx_ = nullptr;
};

int main(int argc, char **argv) {
    const unsigned long bytes = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 4096;
    const long iterations = argc > 2 ? std::strtol(argv[2], nullptr, 0) : 1000;

    if (bytes == 0 || bytes % 4 || bytes > MYDMA_BUF_SIZE || iterations < 1) {
        std::fprintf(stderr,
                     "usage: %s [bytes (multiple of 4, max %d)] [iterations]\n",
                     argv[0], MYDMA_BUF_SIZE);
        return 2;
    }
    const std::size_t words = bytes / 4;

    try {
        MyDma dma;
        std::mt19937 rng(12345);
        double dma_seconds = 0;
        long failures = 0;

        for (long it = 0; it < iterations; ++it) {
            // Fresh data every iteration, so a stale rx buffer can't pass.
            std::uint32_t *in = dma.tx();
            for (std::size_t i = 0; i < words; ++i)
                in[i] = rng();

            auto t0 = std::chrono::steady_clock::now();
            std::size_t got = dma.xfer(bytes, bytes);
            dma_seconds += std::chrono::duration<double>(
                               std::chrono::steady_clock::now() - t0).count();

            if (got != bytes) {
                std::printf("iteration %ld: received %zu of %lu bytes\n", it, got, bytes);
                ++failures;
                continue;
            }

            const std::uint32_t *out = dma.rx();
            std::size_t bad = 0;
            for (std::size_t i = 0; i < words; ++i) {
                if (out[i] != in[i] + 1u) {
                    if (bad < 3)
                        std::printf("iteration %ld, word %zu: sent 0x%08x, got 0x%08x\n",
                                    it, i, in[i], out[i]);
                    ++bad;
                }
            }
            if (bad) {
                std::printf("iteration %ld: %zu of %zu words wrong\n", it, bad, words);
                ++failures;
            }
        }

        std::printf("%ld round trips of %lu bytes: %ld failed\n",
                    iterations, bytes, failures);
        std::printf("DMA time %.3f s, %.1f MB/s each way (ioctl only; filling and "
                    "checking excluded)\n",
                    dma_seconds, iterations * double(bytes) / dma_seconds / 1e6);
        return failures ? 1 : 0;
    } catch (const std::system_error &e) {
        std::fprintf(stderr, "error: %s\n", e.what());
        if (e.code().value() == EINVAL)
            std::fprintf(stderr, "hint: is the size above max_xfer? "
                                 "cat /sys/module/mydma/parameters/max_xfer\n");
        if (e.code().value() == ENOTTY)
            std::fprintf(stderr, "hint: the driver doesn't recognise MYDMA_XFER_CMD; "
                                 "are both built from the same mydma_uapi.h?\n");
        return 1;
    }
}
