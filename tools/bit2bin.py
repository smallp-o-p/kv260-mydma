#!/usr/bin/env python3
"""
Convert a Vivado .bit file into the .bit.bin the ZynqMP FPGA manager loads,
without needing bootgen. Equivalent to:
    bootgen -arch zynqmp -image x.bif -process_bitstream bin

A .bit file is a small header (design name, part, date) followed by the raw
configuration data. The FPGA manager wants just that data, with every 32-bit
word byte-swapped.

Usage: python3 bit2bin.py <design.bit> <output.bit.bin>
"""
import struct
import sys

SYNC_SWAPPED = bytes.fromhex("665599aa")   # AA995566 sync word, byte-swapped


def parse_bit(d):
    """Return (fields, raw_bitstream) from a .bit file."""
    # Header: 16-bit length + magic bytes, then the 16-bit value 1,
    # then keyed fields: 'a' design, 'b' part, 'c' date, 'd' time, 'e' data.
    (n,) = struct.unpack_from(">H", d, 0)
    pos = 2 + n + 2
    fields = {}
    while pos < len(d):
        key = chr(d[pos]); pos += 1
        if key == "e":
            (n,) = struct.unpack_from(">I", d, pos); pos += 4
            return fields, d[pos:pos + n]
        if key not in "abcd":
            break
        (n,) = struct.unpack_from(">H", d, pos); pos += 2
        fields[key] = d[pos:pos + n].rstrip(b"\0").decode(errors="replace")
        pos += n
    sys.exit("not a Vivado .bit file (no bitstream field found)")


def main(src, dst):
    d = open(src, "rb").read()
    fields, raw = parse_bit(d)
    print(f"design: {fields.get('a', '?')}")
    print(f"part:   {fields.get('b', '?')}  built {fields.get('c', '?')} {fields.get('d', '?')}")

    if not fields.get("b", "").lower().startswith("xck26"):
        print("warning: part is not an XCK26 (Kria K26 SOM)", file=sys.stderr)
    if len(raw) % 4:
        sys.exit("bitstream length is not a multiple of 4 bytes")

    out = b"".join(raw[i:i + 4][::-1] for i in range(0, len(raw), 4))
    if SYNC_SWAPPED not in out[:0x100]:
        sys.exit("sync word not found near the start; refusing to write")

    open(dst, "wb").write(out)
    print(f"wrote {dst}: {len(out)} bytes")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
