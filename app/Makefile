# Cross-compile the user-space programs for the KV260 (run in WSL/Ubuntu).
#   sudo apt install g++-aarch64-linux-gnu
#   make -C app
# Static linking: Ubuntu's glibc is newer than the board's (PetaLinux 2022.2),
# so a dynamically linked binary would refuse to start there.
#
#   dmatest     - mmap + ioctl loopback test (needs the ioctl-capable driver)
#   dmatest_rw  - the older read()/write() test (has a start-up race; see source)

# Plain `=`: make predefines CXX as g++, so `?=` would silently build for x86.
# Still overridable: make CXX=...
CXX      = aarch64-linux-gnu-g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra
CPPFLAGS += -I../driver      # mydma_uapi.h, shared with the driver
LDFLAGS  ?= -static -pthread

PROGS = dmatest dmatest_rw

all: $(PROGS)

dmatest: dmatest.cpp ../driver/mydma_uapi.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $< -o $@ $(LDFLAGS)

dmatest_rw: dmatest_rw.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $< -o $@ $(LDFLAGS)

# For clangd: one entry per source, with the exact cross-compile command.
compile_commands.json: Makefile
	@printf '[\n' > $@
	@first=1; for f in $(wildcard *.cpp); do \
	  [ $$first = 1 ] || printf ',\n' >> $@; first=0; \
	  printf '  {"directory": "%s", "file": "%s", "command": "%s %s %s -c %s"}' \
	    "$(CURDIR)" "$(CURDIR)/$$f" "$(shell command -v $(CXX))" "$(CPPFLAGS)" "$(CXXFLAGS)" "$$f" >> $@; \
	done
	@printf '\n]\n' >> $@
	@echo ">> wrote $(CURDIR)/$@"

compile_commands: compile_commands.json

clean:
	rm -f $(PROGS) compile_commands.json

.PHONY: all clean compile_commands
