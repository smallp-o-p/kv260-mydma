# axis_demo: one block with an AXI-Stream in and an AXI-Stream out

The smallest block that shows how to wire a PL block's input and output to
the AXI DMA, plus a whole Vivado design and a board test around it. Copy
`axis_demo.v` as the template for a new block and replace the one line of
"computation".

```
   PS --M_AXI_HPM0_FPD--> sc_ctrl --> axi_dma_0 S_AXI_LITE  0xA000_0000 (driver only)

   DDR <-- S_AXI_HP0_FPD <-- sc_mem <-- axi_dma_0 M_AXI_SG / M_AXI_MM2S / M_AXI_S2MM

   axi_dma_0 M_AXIS_MM2S ==> s_axis [ +ADD per 32-bit word, 1 reg stage ] m_axis ==> axi_dma_0 S_AXIS_S2MM
```

Like `lane_checker`, the block has no CPU-visible registers: everything it
needs arrives on the stream, the DMA sets the lengths, and TLAST marks where
each transfer ends. `ADD` is a Verilog parameter (default 1).

| File | What it is |
| --- | --- |
| `axis_demo.v` | The block: AXIS slave in, AXIS master out, 12 ports, mostly comments |
| `tb_axis_demo.v` | Self-checking testbench (random stalls on both sides, full-rate check) |
| `build_bd.tcl` | Builds the whole block design above in a fresh Vivado project |
| `../axis_demo.dts` | Overlay: the DMA for `mydma.ko`, at the address the Tcl sets |
| `../../app/axisdemo.cpp` | Board test: streams a buffer, checks every word is input + ADD |

## AXI4-Stream in a few lines

Each stream port is 5 wires: `TDATA`, `TKEEP`, `TLAST`, `TVALID`, `TREADY`.
A beat moves on a clock edge where `TVALID && TREADY`. The sender raises
`TVALID` when it has data and holds `TDATA/TKEEP/TLAST` until the beat
moves; it must not wait for `TREADY` first. The receiver drives `TREADY`
whenever it likes. `TLAST` ends a packet, and the AXI DMA's S2MM finishes a
transfer on it, so **every output packet needs a TLAST** or the S2MM (and
`MYDMA_XFER_CMD`) waits until the 3 s timeout. The block passes the input's
`TLAST` through, so one MM2S transfer in becomes one S2MM transfer out.

The datapath is one register stage with

```verilog
assign s_axis_tready = !out_valid || m_axis_tready;
```

"I can take a beat if my output is empty, or it is leaving this cycle." That
gives one beat per clock with any stall pattern (the testbench checks
512 beats in 512 cycles), and the outputs are all flops. A deeper pipeline
is the same pattern per stage, or a FIFO with an "almost full" for TREADY.

**Vivado interface attributes.** The `(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDATA" *)`
lines are what turn the 5 loose wires into one `s_axis` bundle in the block
design. The clock's `ASSOCIATED_BUSIF s_axis:m_axis` tells Vivado which
clock those interfaces use; without it validation complains about unknown
clocks.

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
4. Run Connection Automation for the DMA's `S_AXI_LITE` (master
   `M_AXI_HPM0_FPD`) and its `M_AXI_SG/MM2S/S2MM` (slave `S_AXI_HP0_FPD`).
   Check every `*_aclk` is on `pl_clk0`.
5. `xlconcat` with 2 inputs: `mm2s_introut`, `s2mm_introut` into `pl_ps_irq0`.
6. Address Editor: DMA at `0xA000_0000` (64K).

**Package and run:**

```bash
APP=axis_demo bash hw/package.sh hw/axis_demo/axis_demo.bit
make -C app axisdemo
scp -r out/axis_demo driver/mydma.ko app/axisdemo petalinux@<board-ip>:~/

# on the board
sudo cp -r ~/axis_demo /lib/firmware/xilinx/
sudo xmutil unloadapp && sudo xmutil loadapp axis_demo
sudo insmod ~/mydma.ko max_xfer=1048576
sudo ./axisdemo 1048576
# received 1048576 of 1048576 bytes, 0 of 262144 words wrong
# PASS
```

## If you ever do need settings from the CPU

For things like K or tile size, a header beat at the start of the stream is
usually simplest: the block reads it, then processes the rest. An AXI-Lite
register slave is the other option. It adds about 19 wires (5 channels:
AW, W, B, AR, R) and an address in the Address Editor. The first version of
this demo had one; it is in this branch's history (commit `fe2c2b7`).
