# axis_demo: one block with AXI in, AXI out, and AXI-Lite registers

The smallest block that shows every AXI connection the accelerator needs,
plus a whole Vivado design and a board test around it. Copy `axis_demo.v`
as the template for a new block and replace the one line of "computation".

```
            M_AXI_HPM0_FPD                     +--> axi_dma_0 S_AXI_LITE  0xA000_0000
   PS  -------------------------> sc_ctrl -----+
                                               +--> axis_demo s_axil      0xA001_0000
                                                     (ID, ADD, BEATS, PACKETS, CTRL)

   DDR <-- S_AXI_HP0_FPD <-- sc_mem <-- axi_dma_0 M_AXI_SG / M_AXI_MM2S / M_AXI_S2MM

   axi_dma_0 M_AXIS_MM2S ==> s_axis [ +ADD per 32-bit word, 1 reg stage ] m_axis ==> axi_dma_0 S_AXIS_S2MM
```

| File | What it is |
| --- | --- |
| `axis_demo.v` | The block: AXIS slave in, AXIS master out, AXI-Lite slave, ~260 lines, mostly comments |
| `tb_axis_demo.v` | Self-checking testbench (random stalls on both sides, all AXI-Lite write orders) |
| `build_bd.tcl` | Builds the whole block design above in a fresh Vivado project |
| `../axis_demo.dts` | Overlay: the DMA for `mydma.ko`, at the addresses the Tcl sets |
| `../../app/axisdemo.cpp` | Board test: sets ADD over AXI-Lite, streams a buffer, checks data and counters |

## Registers

| Offset | Name | Access | Meaning |
| --- | --- | --- | --- |
| 0x00 | ID | RO | `0xA5D00001`, to check you are talking to the right block |
| 0x04 | ADD | RW | Added to every 32-bit word of the stream. Reset value 1 |
| 0x08 | BEATS | RO | Input beats accepted since the last clear |
| 0x0C | PACKETS | RO | Output packets (TLASTs) since the last clear |
| 0x10 | CTRL | WO | Write 1 to clear BEATS and PACKETS |

From the board shell, no program needed:

```bash
sudo devmem 0xA0010000 32          # 0xA5D00001
sudo devmem 0xA0010004 32 7        # ADD = 7
sudo devmem 0xA0010008 32          # BEATS
```

## The three interfaces in a few lines each

**AXI4-Stream (s_axis in, m_axis out).** A beat moves on a clock edge where
`TVALID && TREADY`. The sender raises `TVALID` when it has data and holds
`TDATA/TKEEP/TLAST` until the beat moves; it must not wait for `TREADY`
first. The receiver drives `TREADY` whenever it likes. `TLAST` ends a
packet, and the AXI DMA's S2MM finishes a transfer on it, so **every output
packet needs a TLAST** or the S2MM (and `MYDMA_XFER_CMD`) waits until the 3 s
timeout. The block passes the input's `TLAST` through, so one MM2S transfer
in becomes one S2MM transfer out.

The datapath is one register stage with

```verilog
assign s_axis_tready = !out_valid || m_axis_tready;
```

"I can take a beat if my output is empty, or it is leaving this cycle." That
gives one beat per clock with any stall pattern (the testbench checks
512 beats in 512 cycles), and the outputs are all flops. A deeper pipeline
is the same pattern per stage, or a FIFO with an "almost full" for TREADY.

**AXI4-Lite (s_axil).** Five channels, each its own VALID/READY: AW (write
address), W (write data), B (write response), AR (read address), R (read
data). The two rules people trip on: AW and W can arrive in **either order
or together**, so take each when it comes and write once you have both; and
don't accept a new request while the response (B or R) is still waiting.
The block does exactly that and always answers OKAY.

**Vivado interface attributes.** The `(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDATA" *)`
lines are what turn loose ports into one `s_axis` bundle in the block design.
The clock's `ASSOCIATED_BUSIF s_axis:m_axis:s_axil` tells Vivado which clock
those interfaces use; without it validation complains about unknown clocks.

## Build it

**Simulate** (from the repo root):

```bash
iverilog -g2005 -o tb hw/axis_demo/axis_demo.v hw/axis_demo/tb_axis_demo.v && vvp tb
# full rate: 512 beats in 512 cycles
# PASS: ... beats in 40 packets, all correct
```

**Vivado 2022.1**: new RTL project for `xck26-sfvc784-2LV-c` (or the KV260
board), then in the Tcl console

```tcl
source <repo>/hw/axis_demo/build_bd.tcl
```

It adds `axis_demo.v`, builds the design, validates, makes the wrapper the
top. Then Generate Bitstream and copy
`<proj>.runs/impl_1/axis_demo_bd_wrapper.bit` to `hw/axis_demo/axis_demo.bit`.

**By hand instead** (what the Tcl does, in GUI terms):

1. Add Sources > `axis_demo.v`. In the block design, right-click > Add Module > `axis_demo`.
2. Add IP > AXI Direct Memory Access. Scatter Gather **on**, Control/Status
   Stream **off**, buffer length register 26 bits, address width 32, MM2S
   and S2MM both on, memory-map and stream widths 128, burst 256,
   DRE off.
3. Wire `M_AXIS_MM2S` to `axis_demo_0/s_axis`, and `axis_demo_0/m_axis` to
   `S_AXIS_S2MM`. One drag each.
4. Run Connection Automation for `S_AXI_LITE`, `s_axil` (master
   `M_AXI_HPM0_FPD`) and the DMA's `M_AXI_SG/MM2S/S2MM` (slave `S_AXI_HP0_FPD`).
   Check every `*_aclk` is on `pl_clk0`.
5. `xlconcat` with 2 inputs: `mm2s_introut`, `s2mm_introut` into `pl_ps_irq0`.
6. Address Editor: DMA at `0xA000_0000` (64K), `axis_demo_0` at `0xA001_0000` (4K).

**Package and run:**

```bash
APP=axis_demo bash hw/package.sh hw/axis_demo/axis_demo.bit
make -C app axisdemo
scp -r out/axis_demo driver/mydma.ko app/axisdemo petalinux@<board-ip>:~/

# on the board
sudo cp -r ~/axis_demo /lib/firmware/xilinx/
sudo xmutil unloadapp && sudo xmutil loadapp axis_demo
sudo insmod ~/mydma.ko max_xfer=1048576
sudo ./axisdemo 1048576 100
# ID = 0xa5d00001 (ok) ... BEATS = 65536 ... PACKETS = 1 ... PASS
```

## Putting it in the multi_hp design instead

`0xA001_0000` is free there too, and `axi_dma_4` (HPC0) is configured the
same way as this design's DMA. In `memthing.bd`, move `axi_dma_4/M_AXIS_MM2S`
and `axi_dma_4/S_AXIS_S2MM` from `lane_checker_1` (`s_act`, `m_res`) to
`axis_demo_0` as in step 3, and add one master port on `axi_interconnect_0`
for `s_axil`. Then `axisdemo` tests the activation path with `multi_hp.dts`
unchanged. The catch: S2MM has one input, so `lane_checker`'s results have
nowhere to go and `bwtest`'s result check (`MYDMA_STREAM_RESULTS`) stops
working. Keep it as a separate app (above) unless you need both at once.
