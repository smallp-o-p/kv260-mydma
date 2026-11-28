# Matmul controller: first LINEAR call on the board

```
axi_dma_4 MM2S --s_act--> activation_buffer --rd_*/loaded/rel--> axi_controller --t_*--> tile
fifo_w0..3     --s_w0..3-------------------------------------> axi_controller <--t_c--
axi_dma_4 S2MM <--m_res------------------ level2 <------------ axi_controller
```

One LINEAR call, decode shape (one token): `y = W x`, returned as fp32.
Design: "Matmul controller sketch" doc.

- The activation buffer holds the 8G code words (16 codes each, G = K/128),
  then `s_a[g]` (fp32, bytes 0-3) at word 8G+g. So `beat_count` = 9G, and
  the controller gets G from it (no header). K <= 3072, so G <= 24.
- For every granule (one lane's scale beat + 128 rows) the tile does 128 steps,
  then `level2.v` takes its 16 sums and does fp8_golden's level 2:
  `p = fp32(sum) * 2^-18`, `t = p * fp32(s_a[g] * s_w)`, `acc += t`.
- After the last group, `level2.v` sends y on `m_res`: one fp32 per output n,
  ascending n, 4 per beat, TLAST on the call's last beat. Bit-exact with
  `fp8_golden.golden_linear_q` (denormals flush to zero, which never happens
  at these magnitudes).

| File | What it is |
| --- | --- |
| `axi_controller.v` | The controller: IDLE, LOADA, SCALE, RUN, WAIT, HAND, NEXT, REL |
| `level2.v` | fp32 convert, scale, accumulate over g; output FIFO |
| `fp32_funcs.vh` | The fp32 convert/multiply/add as functions (`include`d by `level2.v`) |
| `tile_ref.v` | Reference tile with the same ports: row 0 only (decode), 16 DSPs. Use it to bring the chain up, then swap in the systolic tile |
| `../../sim_1/new/tb_axi_controller.v` | Self-checking bench: buffer model, 4 lanes with random gaps, `tile_ref` with `t_c` delayed 30 clocks and the controller waiting on its `t_done` (`-DDONE_EARLY=2` = done two clocks early, must FAIL), random S2MM back-pressure, 2 calls back to back |
| `../../sim_1/new/gen_vectors.py` | Test vectors from `fp8_golden.py` (real quantized data) |
| `../../sim_1/new/tb_fp32.v`, `../../sim_1/new/gen_fp_vectors.py` | Checks the fp32 functions alone against numpy |
| `app/lineartest.cpp` (repo root) | Board test: random FP8 W and x, packs the lanes, runs the call, checks every output. Can also dump its data for the bench |

## The tile contract

Your tile can replace `tile_ref` if it does this (all in `tile_ref.v`'s header too):

- A step happens on a clock with `t_valid = 1`. Lanes stall, so `t_valid`
  can drop at any time: carry valid along with the data.
- `t_a` byte i = row i's A value (decode: only byte 0 is real, the rest are 0).
  `t_b` byte c = column c's B value. Both are E4M3 codes.
- `t_clear` (one clock) zeroes every sum. It comes before each group's first
  step, only while the tile is idle (no steps in flight, `t_c` already read),
  so apply it straight to the accumulators (DSP48E2: `RSTP`). No start/end
  markers.
- Products are exact integers: decode each code to value x 2^9
  (`(8+m) << (e-1)`, or `m` when e = 0, NaN codes give 0), multiply, add into
  44-bit signed sums.
- `t_done` = 1 when no step is in flight, i.e. `t_c` includes every step
  taken so far. It must be 0 from the clock right after the edge that takes
  a step until that step is in `t_c` (it is also 1 while idle and after
  `t_clear`). The controller waits for it after a group's last step, then
  reads `t_c`, so the tile's latency can be anything, even variable. Easiest
  way: carry a valid bit down every pipeline stage next to the data and
  NOR them all (`tile_ref` does that). Then **hold** `t_c` until `t_clear`.
  `t_c[44c +: 44]` = row 0, column c. In an output-stationary array that is
  just row 0's accumulators wired out, and the valid chain runs along the
  skew to PE (0,15) plus the PE pipeline (`pe_mac`: 4).

## Simulate

```bash
cd hw/memory_thing/memory_thing.srcs/sim_1/new
python3 gen_vectors.py <path to fp8-flow> vec 128 1024      # N K
iverilog -g2005 -I vec -I ../../sources_1/new -o tb tb_axi_controller.v ../../sources_1/new/axi_controller.v ../../sources_1/new/tile_ref.v ../../sources_1/new/level2.v && vvp tb
# PASS: 2 calls x 128 fp32 outputs (G = 8), bit-exact with golden_linear_q

# the fp32 functions alone: ~700k numpy vectors
python3 gen_fp_vectors.py fpvec && iverilog -g2005 -I ../../sources_1/new -o tbfp tb_fp32.v && vvp tbfp +dir=fpvec
```

Or simulate exactly what the board test sends: build `lineartest` natively
(`g++ -O2 -std=c++17 -ffp-contract=off -I../../../../../driver ../../../../../app/lineartest.cpp -o lt -pthread`),
run `./lt 256 1024 1 vec`, then the same `iverilog` line. To test your own
tile, replace `../../sources_1/new/tile_ref.v` with it and change the instance in the bench.

Passes in Icarus for (N, K) = (128, 256), (256, 128), (128, 1024), (128, 3072),
(512, 256), and on `lineartest`'s own data (256x1024, 128x3072). With K = 3200
(G = 25) the controller raises `err` and sends nothing, as it should.

## Block design (multi_hp project, replacing lane_checker)

Save a copy of the project first: bwtest needs lane_checker.

1. The RTL is already in this project's `memory_thing.srcs/sources_1/new`
   (benches in `sim_1/new`). If Sources doesn't list `level2.v`,
   `fp32_funcs.vh` and `tile_ref.v` yet, Add Sources > Add Files (leave
   "Copy sources into project" off) and mark `fp32_funcs.vh` as a Verilog
   Header (Vivado finds the include next to the file, or mark it Global
   Include). `axi_controller.v` and `activation_buffer.v` are listed already.
   Right-click the canvas > Add Module for the controller, the tile and the
   buffer (`level2` sits inside the controller).
2. Delete `lane_checker_1`.
3. `fifo_w0..3/M_AXIS` -> `axi_controller_0/s_w0..3` (one drag each).
4. `axi_dma_4/M_AXIS_MM2S` -> `activation_buffer_0/s_act`.
5. `axi_controller_0/m_res` -> `axi_dma_4/S_AXIS_S2MM`.
6. Buffer to controller, pin to pin: `loaded`, `beat_count`, `rel`, `rd_en`,
   `rd_addr`, `rd_data`, `rd_valid`. (`beat_count` must be the number of
   words received, 9G; for K = 3072 that is 216.)
7. Controller to tile, pin to pin: `t_valid`, `t_clear`, `t_a`, `t_b`
   (controller -> tile) and `t_c`, `t_done` (tile -> controller).
8. Every `aclk` to `pl_clk0`, every `aresetn` to `proc_sys_reset_0/peripheral_aresetn`.
   Leave `err` open, or put it on a System ILA.
9. Validate, generate the bitstream, package it as before
   (`APP=multi_hp bash hw/package.sh <bit>`): the DMAs and addresses are
   unchanged, so the overlay is the same.

Timing at 250 MHz is unchecked: each fp32 step is one function split in two
halves. If a path fails, the add's half 2 (subtract, leading-zero count,
round) is the likely one; split it again and add a stage to the pipeline in
`level2.v` (the tags ride along).

## Run on the board

```bash
make -C app lineartest
# on the board, after loading the app
sudo insmod ~/mydma.ko max_xfer=1048576
sudo ./lineartest                 # N = 1024, K = 1024
sudo ./lineartest 4096 1024 5     # qkv shape, 5 calls back to back
# call 0: 4096 of 4096 outputs received, 0 wrong, weights streamed in ... us -> OK
# PASS
```

If it hangs for 3 s and the DMA times out, check `err` on an ILA. It latches
on a `beat_count` that isn't 9G with 1 <= G <= 24 (the call is then skipped),
or on a TLAST in the wrong place (wrong lane length).
