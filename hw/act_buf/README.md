# act_replay: temporary reader for the activation buffer

`act_replay.v` stands in for the array's controller so the activation buffer
can be tested on the board before the array exists:

```
axi_dma_4 MM2S --> activation_buffer --rd_*--> act_replay --m_axis--> lane_checker_1/s_act
```

When the buffer says `loaded`, it reads words `0 .. beat_count-1` once, sends
them on `m_axis` with TLAST on the last word, then pulses `rel`. lane_checker
returns the XOR and beat count of what came out of the BRAM, so bwtest's
existing line `activation path (8 KiB in, 1 result out): OK` proves the whole
write/read path. Delete it when the controller arrives; the controller drives
the same pins.

Words already requested from the RAM keep arriving after `m_axis_tready`
drops, so they land in a 4-word FIFO, and a read is only issued while
`requested - sent < FIFO_DEPTH`. That keeps one word per clock with the
buffer's `READ_LATENCY = 2` (needs `FIFO_DEPTH >= READ_LATENCY + 2`).

## Simulate (Icarus)

`sim/xpm_memory_sdpram_sim.v` is a simulation-only model of AMD's XPM RAM so
Icarus can run `activation_buffer.v`. Never add it to the Vivado project.

```bash
iverilog -g2012 -o tb hw/act_buf/sim/tb_act_replay.v hw/act_buf/act_replay.v \
         hw/act_buf/sim/xpm_memory_sdpram_sim.v path/to/activation_buffer.v && vvp tb
# replay of 512 words: 516 cycles
# PASS: 8793 words in 11 loads (incl. 1, 3072 and an over-long 3080), all correct
```

The testbench expects the buffer's ports as discussed: `s_act_*`, `rd_en`,
`rd_addr`, `rd_data`, `rd_valid`, `loaded`, `beat_count`, `rel`, and the
parameters `MAX_ENTRIES`, `AXI_STREAM_DATA_BITS`, `ADDR_WIDTH`.

## Block design

1. Add Sources: `activation_buffer.v`, `act_replay.v` (not the `sim/` files).
   Right-click the canvas > Add Module, once for each.
2. Delete the net `axi_dma_4/M_AXIS_MM2S -> lane_checker_1/s_act`.
3. `axi_dma_4/M_AXIS_MM2S -> activation_buffer_0/s_act`
4. `act_replay_0/m_axis -> lane_checker_1/s_act`
5. Pin to pin between the two: `loaded`, `beat_count`, `rel`, `rd_en`,
   `rd_addr`, `rd_data`, `rd_valid`.
6. Both `aclk` to `zynq_ultra_ps_e_0/pl_clk0`, both `aresetn` to
   `proc_sys_reset_0/peripheral_aresetn`.
7. Validate, generate the bitstream, package `multi_hp`, then
   `sudo ./bwtest 16 5` twice in a row.
