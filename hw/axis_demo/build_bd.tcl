# build_bd.tcl - a complete, minimal KV260 design around axis_demo.v:
#
#                 M_AXI_HPM0_FPD (CPU -> DMA registers)
#   PS ---------------------------> sc_ctrl ----> axi_dma_0/S_AXI_LITE  @ 0xA000_0000
#
#   DDR <--S_AXI_HP0_FPD-- sc_mem <--+-- axi_dma_0/M_AXI_SG    (descriptors)
#                                    +-- axi_dma_0/M_AXI_MM2S  (reads input)
#                                    +-- axi_dma_0/M_AXI_S2MM  (writes output)
#
#   axi_dma_0/M_AXIS_MM2S --> axis_demo_0/s_axis   (stream IN,  128 bits)
#   axis_demo_0/m_axis    --> axi_dma_0/S_AXIS_S2MM (stream OUT, 128 bits)
#
#   mm2s_introut, s2mm_introut --> xlconcat --> pl_ps_irq0[0], [1] (GIC SPI 89, 90)
#
# Everything runs on pl_clk0 (250 MHz) with one reset (proc_sys_reset_0).
# It is the multi_hp activation path (axi_dma_4) with lane_checker swapped
# for axis_demo and the weight lanes left out, so the board side is the same
# mydma.ko + MYDMA_XFER_CMD that dmatest already uses.
#
# Use (Vivado 2022.1):
#   1. New RTL project, part xck26-sfvc784-2LV-c (or board "Kria KV260").
#   2. Tcl console:  source <repo>/hw/axis_demo/build_bd.tcl
#   3. Generate Bitstream. Copy <proj>.runs/impl_1/axis_demo_bd_wrapper.bit
#      to hw/axis_demo/axis_demo.bit.
#   4. APP=axis_demo bash hw/package.sh hw/axis_demo/axis_demo.bit
#
# The DMA settings that matter, and why:
#   c_include_sg 1                 mydma uses xilinx_dma in scatter-gather mode
#   c_sg_include_stscntrl_strm 0   ON makes S2MM wait for a status stream
#                                  nobody sends (the Nov 25 S2MM hang)
#   c_sg_length_width 26           up to 64 MiB - 1 per descriptor; must match
#                                  xlnx,sg-length-width in the overlay
#   *_data_width 128, burst 256    full HP port width, 4 KiB bursts
#   c_include_*_dre 0              mydma's buffers are aligned; DRE costs LUTs
#                                  and timing at 250 MHz

set here [file dirname [file normalize [info script]]]
if {[llength [get_files -quiet axis_demo.v]] == 0} {
    add_files -norecurse $here/axis_demo.v
    update_compile_order -fileset sources_1
}

create_bd_design axis_demo_bd

# ---- Zynq UltraScale+ PS ----------------------------------------------------
set ps [create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.4 zynq_ultra_ps_e_0]
# The KV260 preset only matters for a standalone boot; under Linux the PS is
# already set up and an overlay only loads the PL. Apply it if the project
# has the board selected.
if {[get_property board_part [current_project]] ne ""} {
    apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e \
        -config {apply_board_preset "1"} $ps
}
set_property -dict [list \
    CONFIG.PSU__USE__M_AXI_GP0 {1} \
    CONFIG.PSU__USE__M_AXI_GP1 {0} \
    CONFIG.PSU__USE__M_AXI_GP2 {0} \
    CONFIG.PSU__USE__S_AXI_GP2 {1} \
    CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
    CONFIG.PSU__USE__IRQ0 {1} \
    CONFIG.PSU__FPGA_PL0_ENABLE {1} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {250} \
] $ps
# M_AXI_GP0 = M_AXI_HPM0_FPD (CPU -> PL, 0xA000_0000..), S_AXI_GP2 = S_AXI_HP0_FPD.

set clk  [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]

set rst [create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0]
connect_bd_net $clk [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins proc_sys_reset_0/ext_reset_in]
set rstn [get_bd_pins proc_sys_reset_0/peripheral_aresetn]

# ---- AXI DMA ----------------------------------------------------------------
set dma [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0]
set_property -dict [list \
    CONFIG.c_include_sg {1} \
    CONFIG.c_sg_include_stscntrl_strm {0} \
    CONFIG.c_sg_length_width {26} \
    CONFIG.c_addr_width {32} \
    CONFIG.c_include_mm2s {1} \
    CONFIG.c_m_axi_mm2s_data_width {128} \
    CONFIG.c_m_axis_mm2s_tdata_width {128} \
    CONFIG.c_mm2s_burst_size {256} \
    CONFIG.c_include_mm2s_dre {0} \
    CONFIG.c_include_s2mm {1} \
    CONFIG.c_m_axi_s2mm_data_width {128} \
    CONFIG.c_s_axis_s2mm_tdata_width {128} \
    CONFIG.c_s2mm_burst_size {256} \
    CONFIG.c_include_s2mm_dre {0} \
] $dma

# ---- The demo block (RTL module reference) ----------------------------------
set demo [create_bd_cell -type module -reference axis_demo axis_demo_0]
set_property -dict [list CONFIG.DATA_WIDTH {128} CONFIG.ADD {1}] $demo

# Stream IN and OUT: one interface wire each.
connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_demo_0/s_axis]
connect_bd_intf_net [get_bd_intf_pins axis_demo_0/m_axis]    [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]

# ---- Control path: PS -> the DMA's registers (axis_demo has none) -----------
set scc [create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 sc_ctrl]
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] $scc
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD] [get_bd_intf_pins sc_ctrl/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins sc_ctrl/M00_AXI] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]

# ---- Data path: DMA -> DDR --------------------------------------------------
set scm [create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 sc_mem]
set_property -dict [list CONFIG.NUM_SI {3} CONFIG.NUM_MI {1}] $scm
connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXI_SG]   [get_bd_intf_pins sc_mem/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins sc_mem/S01_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins sc_mem/S02_AXI]
connect_bd_intf_net [get_bd_intf_pins sc_mem/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]

# ---- Clocks and resets: every AXI port on pl_clk0 ---------------------------
# (Forgetting saxihp0_fpd_aclk / maxihpm0_fpd_aclk is the usual validate error.)
foreach p {
    zynq_ultra_ps_e_0/maxihpm0_fpd_aclk
    zynq_ultra_ps_e_0/saxihp0_fpd_aclk
    axi_dma_0/s_axi_lite_aclk
    axi_dma_0/m_axi_sg_aclk
    axi_dma_0/m_axi_mm2s_aclk
    axi_dma_0/m_axi_s2mm_aclk
    axis_demo_0/aclk
    sc_ctrl/aclk
    sc_mem/aclk
} { connect_bd_net $clk [get_bd_pins $p] }
foreach p {
    axi_dma_0/axi_resetn
    axis_demo_0/aresetn
    sc_ctrl/aresetn
    sc_mem/aresetn
} { connect_bd_net $rstn [get_bd_pins $p] }

# ---- Interrupts -------------------------------------------------------------
set cc [create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 irq_concat]
set_property CONFIG.NUM_PORTS {2} $cc
connect_bd_net [get_bd_pins axi_dma_0/mm2s_introut] [get_bd_pins irq_concat/In0]
connect_bd_net [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins irq_concat/In1]
connect_bd_net [get_bd_pins irq_concat/dout] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]

# ---- Address map (must match hw/axis_demo.dts) -----------------------------
assign_bd_address -target_address_space /zynq_ultra_ps_e_0/Data \
    -offset 0xA0000000 -range 64K [get_bd_addr_segs axi_dma_0/S_AXI_LITE/*]
assign_bd_address    ;# the DMA's three masters -> HP0 DDR
# Optional: Window > Address Editor to check; DMA spaces see HP0_DDR_LOW at 0.

regenerate_bd_layout
validate_bd_design
save_bd_design

# ---- HDL wrapper as top -----------------------------------------------------
set bdf [get_files axis_demo_bd.bd]
make_wrapper -files $bdf -top
set wrapper [file join [file dirname $bdf] hdl axis_demo_bd_wrapper.v]
if {![file exists $wrapper]} {
    # Vivado puts generated files under .gen/ in recent versions
    set wrapper [glob -nocomplain [get_property DIRECTORY [current_project]]/*.gen/sources_1/bd/axis_demo_bd/hdl/axis_demo_bd_wrapper.v]
}
add_files -norecurse $wrapper
set_property top axis_demo_bd_wrapper [current_fileset]
update_compile_order -fileset sources_1
puts ">> axis_demo_bd ready: Generate Bitstream next"
