# add_fifos.tcl - put a 4 KiB AXI4-Stream Data FIFO on each weight lane.
#
#   axi_dma_<i>/M_AXIS_MM2S -> fifo_w<i> -> lane_checker_1/s_w<i>   (i = 0..3)
#
# Run in Vivado's Tcl console with memthing.bd open:
#   source <repo>/hw/add_fifos.tcl
# then Validate Design, Generate Block Design, Generate Bitstream.
#
# Settings, if you'd rather click through Add IP > AXI4-Stream Data FIFO:
#   FIFO depth 256 (x 16 B = 4 KiB, one 256-beat DMA burst), Block RAM,
#   Independent clocks No, Packet mode OFF, everything else default.
# Packet mode must stay off: it holds a packet until TLAST arrives, and a
# whole weight transfer (MiBs) can never fit, so the lane would hang.
#
# The activation lane (axi_dma_4) is left as is: it will fill the activation
# buffer, which does its own buffering.

for {set i 0} {$i < 4} {incr i} {
    set f fifo_w$i
    create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 $f
    set_property -dict [list \
        CONFIG.FIFO_DEPTH {256} \
        CONFIG.FIFO_MEMORY_TYPE {block} \
        CONFIG.FIFO_MODE {1} \
        CONFIG.IS_ACLK_ASYNC {0} \
    ] [get_bd_cells $f]

    delete_bd_objs [get_bd_intf_nets -of_objects [get_bd_intf_pins axi_dma_$i/M_AXIS_MM2S]]
    connect_bd_intf_net [get_bd_intf_pins axi_dma_$i/M_AXIS_MM2S] [get_bd_intf_pins $f/S_AXIS]
    connect_bd_intf_net [get_bd_intf_pins $f/M_AXIS] [get_bd_intf_pins lane_checker_1/s_w$i]
    connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins $f/s_axis_aclk]
    connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins $f/s_axis_aresetn]
}
regenerate_bd_layout
validate_bd_design
