#!/usr/bin/env bash
# Package the PL design as a Kria app folder, ready to copy to the board.
#
# Usage:  bash hw/package.sh [design.bit] [outdir]
#   design.bit  default: hw/memthing_wrapper.bit
#   outdir      default: out/
# Result: <outdir>/memory_thing/{memory_thing.bit.bin, memory_thing.dtbo, shell.json}
# On the board: sudo cp -r memory_thing /lib/firmware/xilinx/ && sudo xmutil loadapp memory_thing
#
# Needs python3 and dtc (`sudo apt install device-tree-compiler`).
set -euo pipefail

HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(dirname "$HERE")
BIT=${1:-$HERE/memthing_wrapper.bit}
OUT=${2:-$ROOT/out}
APP=memory_thing            # folder name, .bit.bin name and .dtbo name must match

mkdir -p "$OUT/$APP"
python3 "$ROOT/tools/bit2bin.py" "$BIT" "$OUT/$APP/$APP.bit.bin"
# -q hides two harmless warnings about AMD's generated dma-channel@ node names
dtc -@ -q -I dts -O dtb -o "$OUT/$APP/$APP.dtbo" "$HERE/$APP.dts"
cp "$HERE/shell.json" "$OUT/$APP/"

echo ">> packaged $OUT/$APP/"
ls -l "$OUT/$APP"
