# Cross-compile the user-space programs for the KV260 (run in WSL/Ubuntu).
#   sudo apt install g++-aarch64-linux-gnu
#   make -C app
# Static linking: Ubuntu's glibc is newer than the board's (PetaLinux 2022.2),
# so a dynamically linked binary would refuse to start there.
# Plain `=`: make predefines CXX as g++, so `?=` would silently build for x86.
# Still overridable: make CXX=...
CXX      = aarch64-linux-gnu-g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra
LDFLAGS  ?= -static -pthread

all: dmatest

dmatest: dmatest.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)

clean:
	rm -f dmatest

.PHONY: all clean
