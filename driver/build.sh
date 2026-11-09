#!/usr/bin/env bash
# Build mydma.ko for the KV260 running PetaLinux 2022.2
# (kernel 5.15.36-xilinx-v2022.2), on Ubuntu or WSL Ubuntu.
#
# Put this script in a folder with mydma.c, Makefile and kconfig.txt
# (kconfig.txt = `zcat /proc/config.gz` from the board), then run:
#     bash build.sh
# Result: mydma.ko in the same folder. Copy it to the board and insmod it.
#
# The kernel source is cloned once into $KDIR (default ~/kv260-kernel,
# about 1 GB after preparing); later runs reuse it.
set -euo pipefail

KTAG=xlnx_rebase_v5.15_LTS_2022.2         # AMD linux-xlnx tag = 5.15.36
WANT_RELEASE=5.15.36-xilinx-v2022.2       # must equal `uname -r` on the board
KDIR=${KDIR:-$HOME/kv260-kernel}
HERE=$(cd "$(dirname "$0")" && pwd)

# Board kernel was built with GCC 11; use the same major version.
CC_BIN=aarch64-linux-gnu-gcc-11
export ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
export LOCALVERSION=                      # stop kbuild appending "+" or a git hash
MAKE=(make CC="$CC_BIN")

for f in mydma.c Makefile kconfig.txt; do
	[[ -f "$HERE/$f" ]] || { echo "missing $HERE/$f" >&2; exit 1; }
done

# 1. Tools (Ubuntu/Debian package names)
PKGS=(gcc-11-aarch64-linux-gnu make bc flex bison libssl-dev libelf-dev git device-tree-compiler)
MISSING=()
for p in "${PKGS[@]}"; do dpkg -s "$p" >/dev/null 2>&1 || MISSING+=("$p"); done
if ((${#MISSING[@]})); then
	echo ">> installing: ${MISSING[*]}"
	sudo apt-get update
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${MISSING[@]}"
fi

# 2. Kernel source matching the board
if [[ ! -f "$KDIR/Makefile" ]]; then
	echo ">> cloning linux-xlnx $KTAG into $KDIR"
	git clone --depth 1 --branch "$KTAG" https://github.com/Xilinx/linux-xlnx "$KDIR"
fi

# 3. Board's config, then prepare headers for module builds
cp "$HERE/kconfig.txt" "$KDIR/.config"
"$KDIR/scripts/config" --file "$KDIR/.config" -d LOCALVERSION_AUTO
"${MAKE[@]}" -C "$KDIR" olddefconfig
"${MAKE[@]}" -C "$KDIR" -j"$(nproc)" modules_prepare

GOT=$("${MAKE[@]}" -s -C "$KDIR" kernelrelease)
if [[ "$GOT" != "$WANT_RELEASE" ]]; then
	echo "kernel release is '$GOT', expected '$WANT_RELEASE'; the board would refuse the module" >&2
	exit 1
fi

# 4. The module
"${MAKE[@]}" -C "$KDIR" M="$HERE" modules
echo
echo ">> built $HERE/mydma.ko"
modinfo "$HERE/mydma.ko" 2>/dev/null | grep -E '^(vermagic|alias)' || true

# 5. compile_commands.json for clangd, from the flags kbuild just used.
#    Points into $KDIR, so it stays valid as long as that tree exists.
python3 -W ignore "$KDIR/scripts/clang-tools/gen_compile_commands.py" \
	-d "$KDIR" -o "$HERE/compile_commands.json" "$HERE"
echo ">> wrote $HERE/compile_commands.json"
