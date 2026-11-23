vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_12
vlib modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_12
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/smartconnect_v1_0
vlib modelsim_lib/msim/axi_register_slice_v2_1_26
vlib modelsim_lib/msim/lib_cdc_v1_0_2
vlib modelsim_lib/msim/proc_sys_reset_v5_0_13
vlib modelsim_lib/msim/xlconstant_v1_1_7
vlib modelsim_lib/msim/lib_pkg_v1_0_2
vlib modelsim_lib/msim/fifo_generator_v13_2_7
vlib modelsim_lib/msim/lib_fifo_v1_0_16
vlib modelsim_lib/msim/lib_srl_fifo_v1_0_2
vlib modelsim_lib/msim/axi_datamover_v5_1_28
vlib modelsim_lib/msim/axi_sg_v4_1_15
vlib modelsim_lib/msim/axi_dma_v7_1_27
vlib modelsim_lib/msim/generic_baseblocks_v2_1_0
vlib modelsim_lib/msim/axi_data_fifo_v2_1_25
vlib modelsim_lib/msim/axi_crossbar_v2_1_27
vlib modelsim_lib/msim/axi_protocol_converter_v2_1_26
vlib modelsim_lib/msim/axi_clock_converter_v2_1_25
vlib modelsim_lib/msim/blk_mem_gen_v8_4_5
vlib modelsim_lib/msim/axi_dwidth_converter_v2_1_26
vlib modelsim_lib/msim/axis_infrastructure_v1_1_0
vlib modelsim_lib/msim/axis_data_fifo_v2_0_8

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_12 modelsim_lib/msim/axi_vip_v1_1_12
vmap zynq_ultra_ps_e_vip_v1_0_12 modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_12
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap smartconnect_v1_0 modelsim_lib/msim/smartconnect_v1_0
vmap axi_register_slice_v2_1_26 modelsim_lib/msim/axi_register_slice_v2_1_26
vmap lib_cdc_v1_0_2 modelsim_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 modelsim_lib/msim/proc_sys_reset_v5_0_13
vmap xlconstant_v1_1_7 modelsim_lib/msim/xlconstant_v1_1_7
vmap lib_pkg_v1_0_2 modelsim_lib/msim/lib_pkg_v1_0_2
vmap fifo_generator_v13_2_7 modelsim_lib/msim/fifo_generator_v13_2_7
vmap lib_fifo_v1_0_16 modelsim_lib/msim/lib_fifo_v1_0_16
vmap lib_srl_fifo_v1_0_2 modelsim_lib/msim/lib_srl_fifo_v1_0_2
vmap axi_datamover_v5_1_28 modelsim_lib/msim/axi_datamover_v5_1_28
vmap axi_sg_v4_1_15 modelsim_lib/msim/axi_sg_v4_1_15
vmap axi_dma_v7_1_27 modelsim_lib/msim/axi_dma_v7_1_27
vmap generic_baseblocks_v2_1_0 modelsim_lib/msim/generic_baseblocks_v2_1_0
vmap axi_data_fifo_v2_1_25 modelsim_lib/msim/axi_data_fifo_v2_1_25
vmap axi_crossbar_v2_1_27 modelsim_lib/msim/axi_crossbar_v2_1_27
vmap axi_protocol_converter_v2_1_26 modelsim_lib/msim/axi_protocol_converter_v2_1_26
vmap axi_clock_converter_v2_1_25 modelsim_lib/msim/axi_clock_converter_v2_1_25
vmap blk_mem_gen_v8_4_5 modelsim_lib/msim/blk_mem_gen_v8_4_5
vmap axi_dwidth_converter_v2_1_26 modelsim_lib/msim/axi_dwidth_converter_v2_1_26
vmap axis_infrastructure_v1_1_0 modelsim_lib/msim/axis_infrastructure_v1_1_0
vmap axis_data_fifo_v2_0_8 modelsim_lib/msim/axis_data_fifo_v2_0_8

vlog -work xilinx_vip  -incr -mfcu -sv -L axi_vip_v1_1_12 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_12 -L xilinx_vip "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"N:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -mfcu -sv -L axi_vip_v1_1_12 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_12 -L xilinx_vip "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"N:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_12  -incr -mfcu -sv -L axi_vip_v1_1_12 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_12 -L xilinx_vip "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/1033/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_12  -incr -mfcu -sv -L axi_vip_v1_1_12 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_12 -L xilinx_vip "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/memthing/ip/memthing_zynq_ultra_ps_e_0_0/sim/memthing_zynq_ultra_ps_e_0_0_vip_wrapper.v" \
"../../../bd/memthing/ip/memthing_smartconnect_0_0/bd_0/sim/bd_6797.v" \

vlog -work smartconnect_v1_0  -incr -mfcu -sv -L axi_vip_v1_1_12 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_12 -L xilinx_vip "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ea34/hdl/sc_mmu_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/4fd2/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8047/hdl/sc_si_converter_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/sc_node_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/c012/hdl/sc_switchboard_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f38e/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/9cc5/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/6bba/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work axi_register_slice_v2_1_26  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/0a3f/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vcom -work lib_cdc_v1_0_2  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vlog -work xlconstant_v1_1_7  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/fcfc/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/memthing/ip/memthing_smartconnect_0_0/sim/memthing_smartconnect_0_0.v" \

vcom -work xil_defaultlib  -93 \
"../../../bd/memthing/ip/memthing_proc_sys_reset_0_0/sim/memthing_proc_sys_reset_0_0.vhd" \

vcom -work lib_pkg_v1_0_2  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_7  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/83df/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_7  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/83df/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_7  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/83df/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_16  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/6c82/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_28  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/1bb8/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_15  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/751a/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_27  -93 \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/7b0b/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../bd/memthing/ip/memthing_axi_dma_0_0/sim/memthing_axi_dma_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_0  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_25  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/5390/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_27  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/3fa0/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/memthing/ip/memthing_xbar_0/sim/memthing_xbar_0.v" \

vlog -work axi_protocol_converter_v2_1_26  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/90c8/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_clock_converter_v2_1_25  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/e893/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_5  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/25a8/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_26  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/b3c7/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/memthing/ip/memthing_auto_ds_0/sim/memthing_auto_ds_0.v" \
"../../../bd/memthing/ip/memthing_auto_pc_0/sim/memthing_auto_pc_0.v" \
"../../../bd/memthing/ip/memthing_auto_ds_1/sim/memthing_auto_ds_1.v" \
"../../../bd/memthing/ip/memthing_auto_pc_1/sim/memthing_auto_pc_1.v" \

vlog -work axis_infrastructure_v1_1_0  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_8  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/0bd2/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/ec67/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8cdf/hdl" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/f0b6/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/66be/hdl/verilog" "+incdir+../../../../memory_thing.gen/sources_1/bd/memthing/ipshared/8713/hdl" "+incdir+N:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/memthing/ip/memthing_axis_data_fifo_0_0/sim/memthing_axis_data_fifo_0_0.v" \

vcom -work xil_defaultlib  -93 \
"../../../bd/memthing/ip/memthing_axis_incrementer_0_0/sim/memthing_axis_incrementer_0_0.vhd" \
"../../../bd/memthing/sim/memthing.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

