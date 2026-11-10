// dmatest_rw.cpp - /dev/mydma via read()/write(): loopback check + throughput loop.
//
// Build in WSL (static, so the board's older glibc doesn't matter):
//   sudo apt install g++-aarch64-linux-gnu
//   make -C app
// Run on the board:
//   sudo ./dmatest_rw              # one 1 MiB round trip, checked
//   sudo ./dmatest_rw 4096 1000    # 1000 round trips of 4 KiB, timed
//
// How the driver behaves (see mydma.c):
//   write(fd, buf, n) sends n bytes on MM2S and blocks until the DMA is done.
//   read(fd, buf, n)  arms S2MM for up to n bytes, blocks until a packet
//                     (TLAST) or n bytes arrive, returns the bytes received.
//   Both give up after 3 s with ETIMEDOUT; each call moves at most max_xfer
//   bytes (module parameter).
// A write blocks until its data has left, and a loopback design can't take
// data until S2MM is armed, so the read and the write must run on separate
// threads.
//
// KNOWN ISSUE: S2MM must be armed BEFORE MM2S starts. If data reaches an
// unarmed S2MM, the received data is silently corrupted (seen: 8 words sent,
// "2 3 0 0 0 0 0 0" received, full length reported). round_trip() below
// starts the reader thread and writes immediately, so it can lose that race.
// User space can't know when another thread's read() has armed S2MM; the fix
// is a driver call that arms S2MM first, then starts MM2S (planned ioctl).

#include <fcntl.h>
#include <unistd.h>

#include <cerrno>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <future>
#include <random>
#include <stdexcept>
#include <string>
#include <system_error>
#include <vector>

class MyDma {
public:
    explicit MyDma(const char *path = "/dev/mydma") : fd_(::open(path, O_RDWR)) {
        if (fd_ < 0)
            throw std::system_error(errno, std::generic_category(),
                                    std::string("open ") + path);
    }
    ~MyDma() { if (fd_ >= 0) ::close(fd_); }
    MyDma(const MyDma &) = delete;
    MyDma &operator=(const MyDma &) = delete;

    // Send len bytes as one MM2S transfer. Returns bytes sent (may be less
    // than len if len > max_xfer).
    size_t send(const void *data, size_t len) {
        ssize_t n = ::write(fd_, data, len);
        if (n < 0)
            throw std::system_error(errno, std::generic_category(), "mydma write");
        return static_cast<size_t>(n);
    }

    // Receive one S2MM transfer of up to len bytes. Returns bytes received.
    size_t receive(void *data, size_t len) {
        ssize_t n = ::read(fd_, data, len);
        if (n < 0)
            throw std::system_error(errno, std::generic_category(), "mydma read");
        return static_cast<size_t>(n);
    }

    // Send `in` and collect what comes back, concurrently.
    size_t round_trip(const std::vector<uint32_t> &in, std::vector<uint32_t> &out) {
        const size_t bytes = in.size() * sizeof(uint32_t);
        out.assign(in.size(), 0);
        auto rx = std::async(std::launch::async,
                             [&] { return receive(out.data(), bytes); });
        size_t sent = send(in.data(), bytes);
        size_t got = rx.get();   // rethrows if the read failed
        if (sent != bytes)
            throw std::runtime_error("short write: " + std::to_string(sent) +
                                     " of " + std::to_string(bytes) +
                                     " bytes (raise max_xfer?)");
        return got;
    }

private:
    int fd_;
};

int main(int argc, char **argv) {
    const size_t bytes = argc > 1 ? std::strtoul(argv[1], nullptr, 0) : 1 << 20;
    const int iterations = argc > 2 ? std::atoi(argv[2]) : 1;
    if (bytes == 0 || bytes % 4) {
        std::fprintf(stderr, "size must be a non-zero multiple of 4 bytes\n");
        return 2;
    }

    try {
        MyDma dma;
        std::vector<uint32_t> in(bytes / 4), out;
        std::mt19937 rng(12345);
        for (auto &w : in) w = rng();

        auto t0 = std::chrono::steady_clock::now();
        size_t got = 0;
        for (int i = 0; i < iterations; ++i)
            got = dma.round_trip(in, out);
        auto t1 = std::chrono::steady_clock::now();

        // The PL adds 1 to each 32-bit word.
        size_t bad = 0;
        for (size_t i = 0; i < got / 4; ++i)
            if (out[i] != in[i] + 1u) {
                if (bad++ < 5)
                    std::printf("word %zu: sent 0x%08x, got 0x%08x\n", i, in[i], out[i]);
            }

        double s = std::chrono::duration<double>(t1 - t0).count();
        std::printf("%d round trip(s) of %zu bytes: received %zu bytes per trip, "
                    "%zu bad words\n", iterations, bytes, got, bad);
        std::printf("%.3f s total, %.1f MB/s each way (includes the copies "
                    "through the kernel buffer)\n",
                    s, iterations * double(bytes) / s / 1e6);
        return (bad == 0 && got == bytes) ? 0 : 1;
    } catch (const std::exception &e) {
        std::fprintf(stderr, "error: %s\n", e.what());
        return 1;
    }
}
