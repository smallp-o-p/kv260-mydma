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

# For clangd: one entry per source, with the exact cross-compile command.
compile_commands.json: Makefile
	@printf '[\n' > $@
	@first=1; for f in $(wildcard *.cpp); do \
	  [ $$first = 1 ] || printf ',\n' >> $@; first=0; \
	  printf '  {"directory": "%s", "file": "%s", "command": "%s %s -c %s"}' \
	    "$(CURDIR)" "$(CURDIR)/$$f" "$(shell command -v $(CXX))" "$(CXXFLAGS)" "$$f" >> $@; \
	done
	@printf '\n]\n' >> $@
	@echo ">> wrote $(CURDIR)/$@"

compile_commands: compile_commands.json

clean:
	rm -f dmatest compile_commands.json

.PHONY: all clean compile_commands
