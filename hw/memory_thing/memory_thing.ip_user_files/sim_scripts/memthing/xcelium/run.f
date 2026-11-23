-makelib xcelium_lib/xilinx_vip -sv \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xpm -sv \
  "N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_12 -sv \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/1033/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/zynq_ultra_ps_e_vip_v1_0_12 -sv \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_zynq_ultra_ps_e_0_0/sim/memthing_zynq_ultra_ps_e_0_0_vip_wrapper.v" \
  "../../../bd/memthing/ip/memthing_smartconnect_0_0/bd_0/sim/bd_6797.v" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ea34/hdl/sc_mmu_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/4fd2/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8047/hdl/sc_si_converter_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/sc_node_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/c012/hdl/sc_switchboard_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f38e/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/9cc5/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/6bba/hdl/sc_exit_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/axi_register_slice_v2_1_26 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/0a3f/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_13 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xlconstant_v1_1_7 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/fcfc/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_smartconnect_0_0/sim/memthing_smartconnect_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_proc_sys_reset_0_0/sim/memthing_proc_sys_reset_0_0.vhd" \
-endlib
-makelib xcelium_lib/lib_pkg_v1_0_2 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_7 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/83df/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_7 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/83df/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_7 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/83df/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib xcelium_lib/lib_fifo_v1_0_16 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/6c82/hdl/lib_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_srl_fifo_v1_0_2 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_datamover_v5_1_28 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/1bb8/hdl/axi_datamover_v5_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_sg_v4_1_15 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/751a/hdl/axi_sg_v4_1_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_dma_v7_1_27 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/7b0b/hdl/axi_dma_v7_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_axi_dma_0_0/sim/memthing_axi_dma_0_0.vhd" \
-endlib
-makelib xcelium_lib/generic_baseblocks_v2_1_0 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_data_fifo_v2_1_25 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/5390/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_crossbar_v2_1_27 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/3fa0/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_xbar_0/sim/memthing_xbar_0.v" \
-endlib
-makelib xcelium_lib/axi_protocol_converter_v2_1_26 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/90c8/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_clock_converter_v2_1_25 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/e893/hdl/axi_clock_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_5 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/25a8/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/axi_dwidth_converter_v2_1_26 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/b3c7/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_auto_ds_0/sim/memthing_auto_ds_0.v" \
  "../../../bd/memthing/ip/memthing_auto_pc_0/sim/memthing_auto_pc_0.v" \
  "../../../bd/memthing/ip/memthing_auto_ds_1/sim/memthing_auto_ds_1.v" \
  "../../../bd/memthing/ip/memthing_auto_pc_1/sim/memthing_auto_pc_1.v" \
-endlib
-makelib xcelium_lib/axis_infrastructure_v1_1_0 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl/axis_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axis_data_fifo_v2_0_8 \
  "../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/0bd2/hdl/axis_data_fifo_v2_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_axis_data_fifo_0_0/sim/memthing_axis_data_fifo_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/memthing/ip/memthing_axis_incrementer_0_0/sim/memthing_axis_incrementer_0_0.vhd" \
  "../../../bd/memthing/sim/memthing.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

