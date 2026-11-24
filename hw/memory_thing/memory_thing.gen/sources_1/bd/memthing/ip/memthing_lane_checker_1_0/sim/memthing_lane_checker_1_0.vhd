-- (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:lane_checker:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memthing_lane_checker_1_0 IS
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_w0_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_w0_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_w0_tlast : IN STD_LOGIC;
    s_w0_tvalid : IN STD_LOGIC;
    s_w0_tready : OUT STD_LOGIC;
    s_w1_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_w1_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_w1_tlast : IN STD_LOGIC;
    s_w1_tvalid : IN STD_LOGIC;
    s_w1_tready : OUT STD_LOGIC;
    s_w2_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_w2_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_w2_tlast : IN STD_LOGIC;
    s_w2_tvalid : IN STD_LOGIC;
    s_w2_tready : OUT STD_LOGIC;
    s_w3_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_w3_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_w3_tlast : IN STD_LOGIC;
    s_w3_tvalid : IN STD_LOGIC;
    s_w3_tready : OUT STD_LOGIC;
    s_act_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_act_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_act_tlast : IN STD_LOGIC;
    s_act_tvalid : IN STD_LOGIC;
    s_act_tready : OUT STD_LOGIC;
    m_res_tdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_res_tkeep : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_res_tlast : OUT STD_LOGIC;
    m_res_tvalid : OUT STD_LOGIC;
    m_res_tready : IN STD_LOGIC
  );
END memthing_lane_checker_1_0;

ARCHITECTURE memthing_lane_checker_1_0_arch OF memthing_lane_checker_1_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF memthing_lane_checker_1_0_arch: ARCHITECTURE IS "yes";
  COMPONENT lane_checker IS
    PORT (
      aclk : IN STD_LOGIC;
      aresetn : IN STD_LOGIC;
      s_w0_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      s_w0_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_w0_tlast : IN STD_LOGIC;
      s_w0_tvalid : IN STD_LOGIC;
      s_w0_tready : OUT STD_LOGIC;
      s_w1_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      s_w1_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_w1_tlast : IN STD_LOGIC;
      s_w1_tvalid : IN STD_LOGIC;
      s_w1_tready : OUT STD_LOGIC;
      s_w2_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      s_w2_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_w2_tlast : IN STD_LOGIC;
      s_w2_tvalid : IN STD_LOGIC;
      s_w2_tready : OUT STD_LOGIC;
      s_w3_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      s_w3_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_w3_tlast : IN STD_LOGIC;
      s_w3_tvalid : IN STD_LOGIC;
      s_w3_tready : OUT STD_LOGIC;
      s_act_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      s_act_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_act_tlast : IN STD_LOGIC;
      s_act_tvalid : IN STD_LOGIC;
      s_act_tready : OUT STD_LOGIC;
      m_res_tdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      m_res_tkeep : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m_res_tlast : OUT STD_LOGIC;
      m_res_tvalid : OUT STD_LOGIC;
      m_res_tready : IN STD_LOGIC
    );
  END COMPONENT lane_checker;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF aclk: SIGNAL IS "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF s_w0:s_w1:s_w2:s_w3:s_act:m_res, ASSOCIATED_RESET aresetn, FREQ_HZ 249997498, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN memthing_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 aclk CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF aresetn: SIGNAL IS "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 aresetn RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF m_res_tdata: SIGNAL IS "XIL_INTERFACENAME m_res, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 249997498, PHASE 0.0, CLK_DOMAIN memthing_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF m_res_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 m_res TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_res_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 m_res TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF m_res_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 m_res TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_res_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 m_res TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_res_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 m_res TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_act_tdata: SIGNAL IS "XIL_INTERFACENAME s_act, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 249997498, PHASE 0.0, CLK_DOMAIN memthing_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s_act_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_act TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_act_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_act TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_act_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_act TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_act_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_act TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_act_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_act TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_w0_tdata: SIGNAL IS "XIL_INTERFACENAME s_w0, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 249997498, PHASE 0.0, CLK_DOMAIN memthing_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s_w0_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w0 TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_w0_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w0 TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_w0_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w0 TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_w0_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w0 TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_w0_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w0 TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_w1_tdata: SIGNAL IS "XIL_INTERFACENAME s_w1, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 249997498, PHASE 0.0, CLK_DOMAIN memthing_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s_w1_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w1 TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_w1_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w1 TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_w1_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w1 TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_w1_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w1 TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_w1_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w1 TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_w2_tdata: SIGNAL IS "XIL_INTERFACENAME s_w2, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 249997498, PHASE 0.0, CLK_DOMAIN memthing_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s_w2_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w2 TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_w2_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w2 TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_w2_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w2 TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_w2_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w2 TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_w2_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w2 TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_w3_tdata: SIGNAL IS "XIL_INTERFACENAME s_w3, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 249997498, PHASE 0.0, CLK_DOMAIN memthing_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s_w3_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w3 TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_w3_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w3 TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_w3_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w3 TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_w3_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w3 TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_w3_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_w3 TVALID";
BEGIN
  U0 : lane_checker
    PORT MAP (
      aclk => aclk,
      aresetn => aresetn,
      s_w0_tdata => s_w0_tdata,
      s_w0_tkeep => s_w0_tkeep,
      s_w0_tlast => s_w0_tlast,
      s_w0_tvalid => s_w0_tvalid,
      s_w0_tready => s_w0_tready,
      s_w1_tdata => s_w1_tdata,
      s_w1_tkeep => s_w1_tkeep,
      s_w1_tlast => s_w1_tlast,
      s_w1_tvalid => s_w1_tvalid,
      s_w1_tready => s_w1_tready,
      s_w2_tdata => s_w2_tdata,
      s_w2_tkeep => s_w2_tkeep,
      s_w2_tlast => s_w2_tlast,
      s_w2_tvalid => s_w2_tvalid,
      s_w2_tready => s_w2_tready,
      s_w3_tdata => s_w3_tdata,
      s_w3_tkeep => s_w3_tkeep,
      s_w3_tlast => s_w3_tlast,
      s_w3_tvalid => s_w3_tvalid,
      s_w3_tready => s_w3_tready,
      s_act_tdata => s_act_tdata,
      s_act_tkeep => s_act_tkeep,
      s_act_tlast => s_act_tlast,
      s_act_tvalid => s_act_tvalid,
      s_act_tready => s_act_tready,
      m_res_tdata => m_res_tdata,
      m_res_tkeep => m_res_tkeep,
      m_res_tlast => m_res_tlast,
      m_res_tvalid => m_res_tvalid,
      m_res_tready => m_res_tready
    );
END memthing_lane_checker_1_0_arch;
