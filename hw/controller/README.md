# axi_controller: matmul controller, version A

Feeds one 16x16 tile from the activation buffer and the 4 weight lanes, and
sends the tile's raw level-1 sums to S2MM. The CPU does level 2 (fp32 scaling)
in version A. Design: "Matmul controller sketch" doc.

| File | What it is |
| --- | --- |
| `axi_controller.v` | The controller (states IDLE, LOADA, SCALE, RUN, WAIT, OUT, REL) |
| `sim/tb_axi_controller.v` | Self-checking bench: buffer model, 4 lanes with random gaps, behavioural tile, random S2MM back-pressure, 2 calls back to back |
| `sim/gen_vectors.py` | Writes the lane streams, activation words and expected sums from `fp8_golden.py` |

Output: per granule (lane p, group g) 8 beats, two sign-extended 64-bit sums
per beat (columns 2b, 2b+1). Order: for quad, for g, for p. TLAST on the last
beat of the call. So the CPU receives N x G x 8 bytes.

```bash
cd hw/controller/sim
python3 gen_vectors.py <path to fp8-flow> vec 128 1024      # N K
iverilog -g2005 -I vec -o tb tb_axi_controller.v ../axi_controller.v && vvp tb
# PASS: 2 calls x 1024 sums (G = 8), all match level1_group_sums
```

Tested in Icarus for (N, K) = (128, 256), (256, 128), (128, 1024), (128, 3072).
The tile must carry `t_valid` with the data (stalls make bubbles) and hold
its sums from `t_done` until the next `t_first`.
