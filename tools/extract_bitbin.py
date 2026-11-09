#!/usr/bin/env python3
"""
Pull the raw PL bitstream out of a ZynqMP boot image (BOOT.BIN format).

The FPGA manager / xmutil wants the bare processed bitstream, which is what
`bootgen -arch zynqmp -image x.bif -process_bitstream bin` produces. If bootgen
was run without -process_bitstream, you get a boot image wrapping it instead.
This script recovers the bare bitstream from such a file.

Usage: python3 extract_bitbin.py <boot-image> <output.bit.bin>
"""
import struct
import sys

PL = 2  # partition destination device: 0 none, 1 PS, 2 PL, 3 PMU


def main(src, dst):
    d = open(src, "rb").read()

    if d[0x20:0x24] != bytes.fromhex("665599aa") or d[0x24:0x28] != b"XNLX":
        # Already a bare bitstream starts with FF padding, then the bus-width word.
        sys.exit(f"{src}: not a ZynqMP boot image (maybe it is already a bare .bit.bin)")

    ph = struct.unpack_from("<I", d, 0x9C)[0]  # partition header table offset (bytes)
    found = []
    while ph:
        w = struct.unpack_from("<16I", d, ph)
        total_words, next_words, data_words, attr = w[2], w[3], w[8], w[9]
        if (attr >> 4) & 7 == PL:
            found.append((data_words * 4, total_words * 4))
        ph = next_words * 4

    if len(found) != 1:
        sys.exit(f"expected exactly one PL partition, found {len(found)}")

    off, length = found[0]
    bit = d[off:off + length]
    if bytes.fromhex("bb00000044002211") not in bit[:0x100]:
        sys.exit("PL partition does not start like a processed bitstream; not writing")

    open(dst, "wb").write(bit)
    print(f"wrote {dst}: {length} bytes from offset {hex(off)}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
