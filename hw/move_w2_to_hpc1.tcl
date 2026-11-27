# move_w2_to_hpc1.tcl - move weight lane 2 (axi_dma_2) from S_AXI_HP2 to S_AXI_HPC1.
#
# Why: HP1 and HP2 enter the DDR controller through the same port (port 4), so
# w1 and w2 split one port's bandwidth when all four lanes run. HPC1 reaches
# DDR through the CCI (ports 1/2) instead, which leaves each of the four weight
# lanes on its own DDR controller port:
#   w0 HP0 -> port 3 (shared with DisplayPort, idle here)
#   w1 HP1 -> port 4 (now alone)
#   w2 HPC1 -> CCI -> ports 1/2 (shared with the CPUs and the act lane on HPC0)
#   w3 HP3 -> port 5 (shared with FPD DMA, idle here)
#
# Run in Vivado's Tcl console with memthing.bd open:
#   source <repo>/hw/move_w2_to_hpc1.tcl
# then Generate Block Design and Generate Bitstream.
#
# Nothing else changes: same AXI-Lite address (0xA0120000), same IRQ, same
# device tree, same driver. multi_hp.dts already sets every AFI port,
# HPC1 included, to 128 bits (config-afi), and HPC1 stays non-coherent
# (PSU__AFI1_COHERENCY 0), like HPC0 is today.
#
# GUI equivalent:
#   1. Zynq PS > PS-PL Configuration > PS-PL Interfaces > Slave Interface >
#      AXI HPC > tick AXI HPC1 FPD, data width 128. Under AXI HP, untick
#      AXI HP2 FPD.
#   2. Wire smartconnect_2/M00_AXI -> S_AXI_HPC1_FPD and
#      pl_clk0 -> saxihpc1_fpd_aclk.
#   3. Address Editor: under axi_dma_2, assign HPC1_DDR_LOW to both Data_MM2S
#      and Data_SG (offset 0x0, 2G, as HP2_DDR_LOW was).

set ps [get_bd_cells zynq_ultra_ps_e_0]

# 1. Unhook HP2: data path first, then its clock pin.
delete_bd_objs [get_bd_intf_nets -of_objects [get_bd_intf_pins smartconnect_2/M00_AXI]]
disconnect_bd_net [get_bd_nets -of_objects [get_bd_pins zynq_ultra_ps_e_0/saxihp2_fpd_aclk]] \
    [get_bd_pins zynq_ultra_ps_e_0/saxihp2_fpd_aclk]

# 2. Enable HPC1 at 128 bits and turn HP2 off.
#    (S_AXI_GP0/1 = HPC0/1, GP2..5 = HP0..3.)
set_property -dict [list \
    CONFIG.PSU__USE__S_AXI_GP1 {1} \
    CONFIG.PSU__SAXIGP1__DATA_WIDTH {128} \
    CONFIG.PSU__USE__S_AXI_GP4 {0} \
] $ps

# 3. Wire lane 2 to HPC1, on the same 250 MHz clock as everything else.
connect_bd_intf_net [get_bd_intf_pins smartconnect_2/M00_AXI] \
    [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HPC1_FPD]
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] \
    [get_bd_pins zynq_ultra_ps_e_0/saxihpc1_fpd_aclk]

# 4. Address map. The HP2 segments went away with the port; give both of
#    axi_dma_2's masters (data and scatter-gather) the low 2 GB of DDR via HPC1.
foreach space {Data_MM2S Data_SG} {
    assign_bd_address -offset 0x00000000 -range 2G \
        -target_address_space [get_bd_addr_spaces axi_dma_2/$space] \
        [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP1/HPC1_DDR_LOW] -force
}

validate_bd_design
save_bd_design
puts "axi_dma_2 now on S_AXI_HPC1_FPD. Check the Address Editor shows HPC1_DDR_LOW for axi_dma_2, then build."
