"""Test vectors for tb_axi_controller.v.

    python3 gen_vectors.py <fp8-flow dir> <out dir> N K [seed]

Writes, one 128-bit beat (or 32-bit value) per line, byte 0 = LSB:
    port0..3.hex  weight lane streams (pack_weight_streams)
    act.hex       activation buffer words: 8G words of 16 codes (M = 1, decode),
                  then s_a[g] at word 8G + g (fp32 in bytes 0-3)
    exp.hex       expected fp32 outputs, ascending n (fp8_golden.golden_linear_q)
    params.vh     `define lines for the testbench
"""
import sys, os
import numpy as np
sys.path.insert(0, sys.argv[1])
import fp8_golden as g

out, N, K = sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
seed = int(sys.argv[5]) if len(sys.argv) > 5 else 0
T, P, G = 16, 4, K // 128
os.makedirs(out, exist_ok=True)
rng = np.random.default_rng(seed)
w = rng.standard_normal((N, K)).astype(np.float32) * 0.05
wc, ws = g.quantize_weight_blockwise(w)
x = (rng.standard_normal((1, K)) * rng.lognormal(0, 1, (1, K))).astype(np.float32)
a, sa = g.quantize_act(x)

bufs = g.pack_weight_streams(wc, ws, T, P)
for p, b in enumerate(bufs):
    with open(f"{out}/port{p}.hex", "w") as f:
        for i in range(0, len(b), 16):
            f.write(b[i:i + 16][::-1].hex() + "\n")
with open(f"{out}/act.hex", "w") as f:
    row = a[0].tobytes()
    for i in range(0, K, 16):
        f.write(row[i:i + 16][::-1].hex() + "\n")
    for gg in range(G):                        # s_a[g] at word 8G + g, bytes 0-3
        f.write(f"{0:024x}{int(sa[0, gg].view(np.uint32)):08x}\n")

s = g.level1_group_sums(a, wc)[0]            # [G, N] int64, units of 2^-18 (for the printout)
y = g.golden_linear_q(a, sa, wc, ws)[0]
with open(f"{out}/exp.hex", "w") as f:
    for v in y.view(np.uint32):
        f.write(f"{int(v):08x}\n")
with open(f"{out}/params.vh", "w") as f:
    f.write(f"`define G {G}\n`define LANE_BEATS {len(bufs[0]) // 16}\n"
            f"`define NOUT {N}\n"
            f"`define VDIR \"{out}\"\n")
print(f"N={N} K={K} G={G}: {len(bufs[0])//16} beats per lane, {N} outputs, max |level-1 sum| = {np.abs(s).max()}")
