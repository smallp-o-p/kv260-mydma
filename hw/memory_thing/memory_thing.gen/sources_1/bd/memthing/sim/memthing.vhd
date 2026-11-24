--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
--Date        : Mon Nov 23 19:09:08 2026
--Host        : 1850-B302S103 running 64-bit major release  (build 9200)
--Command     : generate_target memthing.bd
--Design      : memthing
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m00_couplers_imp_1WV5K1H is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end m00_couplers_imp_1WV5K1H;

architecture STRUCTURE of m00_couplers_imp_1WV5K1H is
  signal m00_couplers_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m00_couplers_to_m00_couplers_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m00_couplers_to_m00_couplers_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_m00_couplers_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_m00_couplers_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_m00_couplers_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  M_AXI_araddr(39 downto 0) <= m00_couplers_to_m00_couplers_ARADDR(39 downto 0);
  M_AXI_arvalid(0) <= m00_couplers_to_m00_couplers_ARVALID(0);
  M_AXI_awaddr(39 downto 0) <= m00_couplers_to_m00_couplers_AWADDR(39 downto 0);
  M_AXI_awvalid(0) <= m00_couplers_to_m00_couplers_AWVALID(0);
  M_AXI_bready(0) <= m00_couplers_to_m00_couplers_BREADY(0);
  M_AXI_rready(0) <= m00_couplers_to_m00_couplers_RREADY(0);
  M_AXI_wdata(31 downto 0) <= m00_couplers_to_m00_couplers_WDATA(31 downto 0);
  M_AXI_wvalid(0) <= m00_couplers_to_m00_couplers_WVALID(0);
  S_AXI_arready(0) <= m00_couplers_to_m00_couplers_ARREADY(0);
  S_AXI_awready(0) <= m00_couplers_to_m00_couplers_AWREADY(0);
  S_AXI_bresp(1 downto 0) <= m00_couplers_to_m00_couplers_BRESP(1 downto 0);
  S_AXI_bvalid(0) <= m00_couplers_to_m00_couplers_BVALID(0);
  S_AXI_rdata(31 downto 0) <= m00_couplers_to_m00_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m00_couplers_to_m00_couplers_RRESP(1 downto 0);
  S_AXI_rvalid(0) <= m00_couplers_to_m00_couplers_RVALID(0);
  S_AXI_wready(0) <= m00_couplers_to_m00_couplers_WREADY(0);
  m00_couplers_to_m00_couplers_ARADDR(39 downto 0) <= S_AXI_araddr(39 downto 0);
  m00_couplers_to_m00_couplers_ARREADY(0) <= M_AXI_arready(0);
  m00_couplers_to_m00_couplers_ARVALID(0) <= S_AXI_arvalid(0);
  m00_couplers_to_m00_couplers_AWADDR(39 downto 0) <= S_AXI_awaddr(39 downto 0);
  m00_couplers_to_m00_couplers_AWREADY(0) <= M_AXI_awready(0);
  m00_couplers_to_m00_couplers_AWVALID(0) <= S_AXI_awvalid(0);
  m00_couplers_to_m00_couplers_BREADY(0) <= S_AXI_bready(0);
  m00_couplers_to_m00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m00_couplers_to_m00_couplers_BVALID(0) <= M_AXI_bvalid(0);
  m00_couplers_to_m00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m00_couplers_to_m00_couplers_RREADY(0) <= S_AXI_rready(0);
  m00_couplers_to_m00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m00_couplers_to_m00_couplers_RVALID(0) <= M_AXI_rvalid(0);
  m00_couplers_to_m00_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m00_couplers_to_m00_couplers_WREADY(0) <= M_AXI_wready(0);
  m00_couplers_to_m00_couplers_WVALID(0) <= S_AXI_wvalid(0);
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m01_couplers_imp_6HII50 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wvalid : in STD_LOGIC
  );
end m01_couplers_imp_6HII50;

architecture STRUCTURE of m01_couplers_imp_6HII50 is
  signal m01_couplers_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m01_couplers_to_m01_couplers_ARREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_ARVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m01_couplers_to_m01_couplers_AWREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_AWVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_BREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_m01_couplers_BVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_m01_couplers_RREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_m01_couplers_RVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_m01_couplers_WREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(39 downto 0) <= m01_couplers_to_m01_couplers_ARADDR(39 downto 0);
  M_AXI_arvalid <= m01_couplers_to_m01_couplers_ARVALID;
  M_AXI_awaddr(39 downto 0) <= m01_couplers_to_m01_couplers_AWADDR(39 downto 0);
  M_AXI_awvalid <= m01_couplers_to_m01_couplers_AWVALID;
  M_AXI_bready <= m01_couplers_to_m01_couplers_BREADY;
  M_AXI_rready <= m01_couplers_to_m01_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m01_couplers_to_m01_couplers_WDATA(31 downto 0);
  M_AXI_wvalid <= m01_couplers_to_m01_couplers_WVALID;
  S_AXI_arready <= m01_couplers_to_m01_couplers_ARREADY;
  S_AXI_awready <= m01_couplers_to_m01_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m01_couplers_to_m01_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m01_couplers_to_m01_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m01_couplers_to_m01_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m01_couplers_to_m01_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m01_couplers_to_m01_couplers_RVALID;
  S_AXI_wready <= m01_couplers_to_m01_couplers_WREADY;
  m01_couplers_to_m01_couplers_ARADDR(39 downto 0) <= S_AXI_araddr(39 downto 0);
  m01_couplers_to_m01_couplers_ARREADY <= M_AXI_arready;
  m01_couplers_to_m01_couplers_ARVALID <= S_AXI_arvalid;
  m01_couplers_to_m01_couplers_AWADDR(39 downto 0) <= S_AXI_awaddr(39 downto 0);
  m01_couplers_to_m01_couplers_AWREADY <= M_AXI_awready;
  m01_couplers_to_m01_couplers_AWVALID <= S_AXI_awvalid;
  m01_couplers_to_m01_couplers_BREADY <= S_AXI_bready;
  m01_couplers_to_m01_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m01_couplers_to_m01_couplers_BVALID <= M_AXI_bvalid;
  m01_couplers_to_m01_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m01_couplers_to_m01_couplers_RREADY <= S_AXI_rready;
  m01_couplers_to_m01_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m01_couplers_to_m01_couplers_RVALID <= M_AXI_rvalid;
  m01_couplers_to_m01_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m01_couplers_to_m01_couplers_WREADY <= M_AXI_wready;
  m01_couplers_to_m01_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m02_couplers_imp_1YG4X12 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wvalid : in STD_LOGIC
  );
end m02_couplers_imp_1YG4X12;

architecture STRUCTURE of m02_couplers_imp_1YG4X12 is
  signal m02_couplers_to_m02_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m02_couplers_to_m02_couplers_ARREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_ARVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m02_couplers_to_m02_couplers_AWREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_AWVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_BREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_m02_couplers_BVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_m02_couplers_RREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_m02_couplers_RVALID : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_m02_couplers_WREADY : STD_LOGIC;
  signal m02_couplers_to_m02_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(39 downto 0) <= m02_couplers_to_m02_couplers_ARADDR(39 downto 0);
  M_AXI_arvalid <= m02_couplers_to_m02_couplers_ARVALID;
  M_AXI_awaddr(39 downto 0) <= m02_couplers_to_m02_couplers_AWADDR(39 downto 0);
  M_AXI_awvalid <= m02_couplers_to_m02_couplers_AWVALID;
  M_AXI_bready <= m02_couplers_to_m02_couplers_BREADY;
  M_AXI_rready <= m02_couplers_to_m02_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m02_couplers_to_m02_couplers_WDATA(31 downto 0);
  M_AXI_wvalid <= m02_couplers_to_m02_couplers_WVALID;
  S_AXI_arready <= m02_couplers_to_m02_couplers_ARREADY;
  S_AXI_awready <= m02_couplers_to_m02_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m02_couplers_to_m02_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m02_couplers_to_m02_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m02_couplers_to_m02_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m02_couplers_to_m02_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m02_couplers_to_m02_couplers_RVALID;
  S_AXI_wready <= m02_couplers_to_m02_couplers_WREADY;
  m02_couplers_to_m02_couplers_ARADDR(39 downto 0) <= S_AXI_araddr(39 downto 0);
  m02_couplers_to_m02_couplers_ARREADY <= M_AXI_arready;
  m02_couplers_to_m02_couplers_ARVALID <= S_AXI_arvalid;
  m02_couplers_to_m02_couplers_AWADDR(39 downto 0) <= S_AXI_awaddr(39 downto 0);
  m02_couplers_to_m02_couplers_AWREADY <= M_AXI_awready;
  m02_couplers_to_m02_couplers_AWVALID <= S_AXI_awvalid;
  m02_couplers_to_m02_couplers_BREADY <= S_AXI_bready;
  m02_couplers_to_m02_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m02_couplers_to_m02_couplers_BVALID <= M_AXI_bvalid;
  m02_couplers_to_m02_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m02_couplers_to_m02_couplers_RREADY <= S_AXI_rready;
  m02_couplers_to_m02_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m02_couplers_to_m02_couplers_RVALID <= M_AXI_rvalid;
  m02_couplers_to_m02_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m02_couplers_to_m02_couplers_WREADY <= M_AXI_wready;
  m02_couplers_to_m02_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m03_couplers_imp_56UR4N is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wvalid : in STD_LOGIC
  );
end m03_couplers_imp_56UR4N;

architecture STRUCTURE of m03_couplers_imp_56UR4N is
  signal m03_couplers_to_m03_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m03_couplers_to_m03_couplers_ARREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_ARVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m03_couplers_to_m03_couplers_AWREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_AWVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_BREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_m03_couplers_BVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_RREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_m03_couplers_RVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_WREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(39 downto 0) <= m03_couplers_to_m03_couplers_ARADDR(39 downto 0);
  M_AXI_arvalid <= m03_couplers_to_m03_couplers_ARVALID;
  M_AXI_awaddr(39 downto 0) <= m03_couplers_to_m03_couplers_AWADDR(39 downto 0);
  M_AXI_awvalid <= m03_couplers_to_m03_couplers_AWVALID;
  M_AXI_bready <= m03_couplers_to_m03_couplers_BREADY;
  M_AXI_rready <= m03_couplers_to_m03_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m03_couplers_to_m03_couplers_WDATA(31 downto 0);
  M_AXI_wvalid <= m03_couplers_to_m03_couplers_WVALID;
  S_AXI_arready <= m03_couplers_to_m03_couplers_ARREADY;
  S_AXI_awready <= m03_couplers_to_m03_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m03_couplers_to_m03_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m03_couplers_to_m03_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m03_couplers_to_m03_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m03_couplers_to_m03_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m03_couplers_to_m03_couplers_RVALID;
  S_AXI_wready <= m03_couplers_to_m03_couplers_WREADY;
  m03_couplers_to_m03_couplers_ARADDR(39 downto 0) <= S_AXI_araddr(39 downto 0);
  m03_couplers_to_m03_couplers_ARREADY <= M_AXI_arready;
  m03_couplers_to_m03_couplers_ARVALID <= S_AXI_arvalid;
  m03_couplers_to_m03_couplers_AWADDR(39 downto 0) <= S_AXI_awaddr(39 downto 0);
  m03_couplers_to_m03_couplers_AWREADY <= M_AXI_awready;
  m03_couplers_to_m03_couplers_AWVALID <= S_AXI_awvalid;
  m03_couplers_to_m03_couplers_BREADY <= S_AXI_bready;
  m03_couplers_to_m03_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m03_couplers_to_m03_couplers_BVALID <= M_AXI_bvalid;
  m03_couplers_to_m03_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m03_couplers_to_m03_couplers_RREADY <= S_AXI_rready;
  m03_couplers_to_m03_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m03_couplers_to_m03_couplers_RVALID <= M_AXI_rvalid;
  m03_couplers_to_m03_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m03_couplers_to_m03_couplers_WREADY <= M_AXI_wready;
  m03_couplers_to_m03_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m04_couplers_imp_1VLATGZ is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wvalid : in STD_LOGIC
  );
end m04_couplers_imp_1VLATGZ;

architecture STRUCTURE of m04_couplers_imp_1VLATGZ is
  signal m04_couplers_to_m04_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m04_couplers_to_m04_couplers_ARREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_ARVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m04_couplers_to_m04_couplers_AWREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_AWVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_BREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_m04_couplers_BVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_RREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_m04_couplers_RVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_WREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(39 downto 0) <= m04_couplers_to_m04_couplers_ARADDR(39 downto 0);
  M_AXI_arvalid <= m04_couplers_to_m04_couplers_ARVALID;
  M_AXI_awaddr(39 downto 0) <= m04_couplers_to_m04_couplers_AWADDR(39 downto 0);
  M_AXI_awvalid <= m04_couplers_to_m04_couplers_AWVALID;
  M_AXI_bready <= m04_couplers_to_m04_couplers_BREADY;
  M_AXI_rready <= m04_couplers_to_m04_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m04_couplers_to_m04_couplers_WDATA(31 downto 0);
  M_AXI_wvalid <= m04_couplers_to_m04_couplers_WVALID;
  S_AXI_arready <= m04_couplers_to_m04_couplers_ARREADY;
  S_AXI_awready <= m04_couplers_to_m04_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m04_couplers_to_m04_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m04_couplers_to_m04_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m04_couplers_to_m04_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m04_couplers_to_m04_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m04_couplers_to_m04_couplers_RVALID;
  S_AXI_wready <= m04_couplers_to_m04_couplers_WREADY;
  m04_couplers_to_m04_couplers_ARADDR(39 downto 0) <= S_AXI_araddr(39 downto 0);
  m04_couplers_to_m04_couplers_ARREADY <= M_AXI_arready;
  m04_couplers_to_m04_couplers_ARVALID <= S_AXI_arvalid;
  m04_couplers_to_m04_couplers_AWADDR(39 downto 0) <= S_AXI_awaddr(39 downto 0);
  m04_couplers_to_m04_couplers_AWREADY <= M_AXI_awready;
  m04_couplers_to_m04_couplers_AWVALID <= S_AXI_awvalid;
  m04_couplers_to_m04_couplers_BREADY <= S_AXI_bready;
  m04_couplers_to_m04_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m04_couplers_to_m04_couplers_BVALID <= M_AXI_bvalid;
  m04_couplers_to_m04_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m04_couplers_to_m04_couplers_RREADY <= S_AXI_rready;
  m04_couplers_to_m04_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m04_couplers_to_m04_couplers_RVALID <= M_AXI_rvalid;
  m04_couplers_to_m04_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m04_couplers_to_m04_couplers_WREADY <= M_AXI_wready;
  m04_couplers_to_m04_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s00_couplers_imp_AHP87 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_AHP87;

architecture STRUCTURE of s00_couplers_imp_AHP87 is
  component memthing_auto_ds_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component memthing_auto_ds_0;
  component memthing_auto_pc_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component memthing_auto_pc_0;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC;
  signal auto_ds_to_auto_pc_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_ds_to_auto_pc_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal auto_ds_to_auto_pc_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_ds_to_auto_pc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_ARREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_ARREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_ARVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_ds_to_auto_pc_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal auto_ds_to_auto_pc_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_ds_to_auto_pc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_AWREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_AWREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_AWVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_BREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_BVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_ds_to_auto_pc_RLAST : STD_LOGIC;
  signal auto_ds_to_auto_pc_RREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_RVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_ds_to_auto_pc_WLAST : STD_LOGIC;
  signal auto_ds_to_auto_pc_WREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_WVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_pc_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s00_couplers_ARREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_ARVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_pc_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s00_couplers_AWREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_AWVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_BREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s00_couplers_BVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s00_couplers_RREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s00_couplers_RVALID : STD_LOGIC;
  signal auto_pc_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s00_couplers_WREADY : STD_LOGIC;
  signal auto_pc_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s00_couplers_WVALID : STD_LOGIC;
  signal s00_couplers_to_auto_ds_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s00_couplers_to_auto_ds_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_ds_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_ds_ARID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s00_couplers_to_auto_ds_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_auto_ds_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_auto_ds_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_ds_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_ds_ARREADY : STD_LOGIC;
  signal s00_couplers_to_auto_ds_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_ds_ARVALID : STD_LOGIC;
  signal s00_couplers_to_auto_ds_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s00_couplers_to_auto_ds_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_ds_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_ds_AWID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s00_couplers_to_auto_ds_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_auto_ds_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_auto_ds_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_ds_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_auto_ds_AWREADY : STD_LOGIC;
  signal s00_couplers_to_auto_ds_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_auto_ds_AWVALID : STD_LOGIC;
  signal s00_couplers_to_auto_ds_BID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s00_couplers_to_auto_ds_BREADY : STD_LOGIC;
  signal s00_couplers_to_auto_ds_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_ds_BVALID : STD_LOGIC;
  signal s00_couplers_to_auto_ds_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s00_couplers_to_auto_ds_RID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s00_couplers_to_auto_ds_RLAST : STD_LOGIC;
  signal s00_couplers_to_auto_ds_RREADY : STD_LOGIC;
  signal s00_couplers_to_auto_ds_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_auto_ds_RVALID : STD_LOGIC;
  signal s00_couplers_to_auto_ds_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s00_couplers_to_auto_ds_WLAST : STD_LOGIC;
  signal s00_couplers_to_auto_ds_WREADY : STD_LOGIC;
  signal s00_couplers_to_auto_ds_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s00_couplers_to_auto_ds_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(39 downto 0) <= auto_pc_to_s00_couplers_ARADDR(39 downto 0);
  M_AXI_arprot(2 downto 0) <= auto_pc_to_s00_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= auto_pc_to_s00_couplers_ARVALID;
  M_AXI_awaddr(39 downto 0) <= auto_pc_to_s00_couplers_AWADDR(39 downto 0);
  M_AXI_awprot(2 downto 0) <= auto_pc_to_s00_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= auto_pc_to_s00_couplers_AWVALID;
  M_AXI_bready <= auto_pc_to_s00_couplers_BREADY;
  M_AXI_rready <= auto_pc_to_s00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_pc_to_s00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= auto_pc_to_s00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_pc_to_s00_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1 <= S_ARESETN;
  S_AXI_arready <= s00_couplers_to_auto_ds_ARREADY;
  S_AXI_awready <= s00_couplers_to_auto_ds_AWREADY;
  S_AXI_bid(15 downto 0) <= s00_couplers_to_auto_ds_BID(15 downto 0);
  S_AXI_bresp(1 downto 0) <= s00_couplers_to_auto_ds_BRESP(1 downto 0);
  S_AXI_bvalid <= s00_couplers_to_auto_ds_BVALID;
  S_AXI_rdata(127 downto 0) <= s00_couplers_to_auto_ds_RDATA(127 downto 0);
  S_AXI_rid(15 downto 0) <= s00_couplers_to_auto_ds_RID(15 downto 0);
  S_AXI_rlast <= s00_couplers_to_auto_ds_RLAST;
  S_AXI_rresp(1 downto 0) <= s00_couplers_to_auto_ds_RRESP(1 downto 0);
  S_AXI_rvalid <= s00_couplers_to_auto_ds_RVALID;
  S_AXI_wready <= s00_couplers_to_auto_ds_WREADY;
  auto_pc_to_s00_couplers_ARREADY <= M_AXI_arready;
  auto_pc_to_s00_couplers_AWREADY <= M_AXI_awready;
  auto_pc_to_s00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_pc_to_s00_couplers_BVALID <= M_AXI_bvalid;
  auto_pc_to_s00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_pc_to_s00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_pc_to_s00_couplers_RVALID <= M_AXI_rvalid;
  auto_pc_to_s00_couplers_WREADY <= M_AXI_wready;
  s00_couplers_to_auto_ds_ARADDR(39 downto 0) <= S_AXI_araddr(39 downto 0);
  s00_couplers_to_auto_ds_ARBURST(1 downto 0) <= S_AXI_arburst(1 downto 0);
  s00_couplers_to_auto_ds_ARCACHE(3 downto 0) <= S_AXI_arcache(3 downto 0);
  s00_couplers_to_auto_ds_ARID(15 downto 0) <= S_AXI_arid(15 downto 0);
  s00_couplers_to_auto_ds_ARLEN(7 downto 0) <= S_AXI_arlen(7 downto 0);
  s00_couplers_to_auto_ds_ARLOCK(0) <= S_AXI_arlock(0);
  s00_couplers_to_auto_ds_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s00_couplers_to_auto_ds_ARQOS(3 downto 0) <= S_AXI_arqos(3 downto 0);
  s00_couplers_to_auto_ds_ARSIZE(2 downto 0) <= S_AXI_arsize(2 downto 0);
  s00_couplers_to_auto_ds_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_auto_ds_AWADDR(39 downto 0) <= S_AXI_awaddr(39 downto 0);
  s00_couplers_to_auto_ds_AWBURST(1 downto 0) <= S_AXI_awburst(1 downto 0);
  s00_couplers_to_auto_ds_AWCACHE(3 downto 0) <= S_AXI_awcache(3 downto 0);
  s00_couplers_to_auto_ds_AWID(15 downto 0) <= S_AXI_awid(15 downto 0);
  s00_couplers_to_auto_ds_AWLEN(7 downto 0) <= S_AXI_awlen(7 downto 0);
  s00_couplers_to_auto_ds_AWLOCK(0) <= S_AXI_awlock(0);
  s00_couplers_to_auto_ds_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s00_couplers_to_auto_ds_AWQOS(3 downto 0) <= S_AXI_awqos(3 downto 0);
  s00_couplers_to_auto_ds_AWSIZE(2 downto 0) <= S_AXI_awsize(2 downto 0);
  s00_couplers_to_auto_ds_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_auto_ds_BREADY <= S_AXI_bready;
  s00_couplers_to_auto_ds_RREADY <= S_AXI_rready;
  s00_couplers_to_auto_ds_WDATA(127 downto 0) <= S_AXI_wdata(127 downto 0);
  s00_couplers_to_auto_ds_WLAST <= S_AXI_wlast;
  s00_couplers_to_auto_ds_WSTRB(15 downto 0) <= S_AXI_wstrb(15 downto 0);
  s00_couplers_to_auto_ds_WVALID <= S_AXI_wvalid;
auto_ds: component memthing_auto_ds_0
     port map (
      m_axi_araddr(39 downto 0) => auto_ds_to_auto_pc_ARADDR(39 downto 0),
      m_axi_arburst(1 downto 0) => auto_ds_to_auto_pc_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => auto_ds_to_auto_pc_ARCACHE(3 downto 0),
      m_axi_arlen(7 downto 0) => auto_ds_to_auto_pc_ARLEN(7 downto 0),
      m_axi_arlock(0) => auto_ds_to_auto_pc_ARLOCK(0),
      m_axi_arprot(2 downto 0) => auto_ds_to_auto_pc_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => auto_ds_to_auto_pc_ARQOS(3 downto 0),
      m_axi_arready => auto_ds_to_auto_pc_ARREADY,
      m_axi_arregion(3 downto 0) => auto_ds_to_auto_pc_ARREGION(3 downto 0),
      m_axi_arsize(2 downto 0) => auto_ds_to_auto_pc_ARSIZE(2 downto 0),
      m_axi_arvalid => auto_ds_to_auto_pc_ARVALID,
      m_axi_awaddr(39 downto 0) => auto_ds_to_auto_pc_AWADDR(39 downto 0),
      m_axi_awburst(1 downto 0) => auto_ds_to_auto_pc_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => auto_ds_to_auto_pc_AWCACHE(3 downto 0),
      m_axi_awlen(7 downto 0) => auto_ds_to_auto_pc_AWLEN(7 downto 0),
      m_axi_awlock(0) => auto_ds_to_auto_pc_AWLOCK(0),
      m_axi_awprot(2 downto 0) => auto_ds_to_auto_pc_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => auto_ds_to_auto_pc_AWQOS(3 downto 0),
      m_axi_awready => auto_ds_to_auto_pc_AWREADY,
      m_axi_awregion(3 downto 0) => auto_ds_to_auto_pc_AWREGION(3 downto 0),
      m_axi_awsize(2 downto 0) => auto_ds_to_auto_pc_AWSIZE(2 downto 0),
      m_axi_awvalid => auto_ds_to_auto_pc_AWVALID,
      m_axi_bready => auto_ds_to_auto_pc_BREADY,
      m_axi_bresp(1 downto 0) => auto_ds_to_auto_pc_BRESP(1 downto 0),
      m_axi_bvalid => auto_ds_to_auto_pc_BVALID,
      m_axi_rdata(31 downto 0) => auto_ds_to_auto_pc_RDATA(31 downto 0),
      m_axi_rlast => auto_ds_to_auto_pc_RLAST,
      m_axi_rready => auto_ds_to_auto_pc_RREADY,
      m_axi_rresp(1 downto 0) => auto_ds_to_auto_pc_RRESP(1 downto 0),
      m_axi_rvalid => auto_ds_to_auto_pc_RVALID,
      m_axi_wdata(31 downto 0) => auto_ds_to_auto_pc_WDATA(31 downto 0),
      m_axi_wlast => auto_ds_to_auto_pc_WLAST,
      m_axi_wready => auto_ds_to_auto_pc_WREADY,
      m_axi_wstrb(3 downto 0) => auto_ds_to_auto_pc_WSTRB(3 downto 0),
      m_axi_wvalid => auto_ds_to_auto_pc_WVALID,
      s_axi_aclk => S_ACLK_1,
      s_axi_araddr(39 downto 0) => s00_couplers_to_auto_ds_ARADDR(39 downto 0),
      s_axi_arburst(1 downto 0) => s00_couplers_to_auto_ds_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => s00_couplers_to_auto_ds_ARCACHE(3 downto 0),
      s_axi_aresetn => S_ARESETN_1,
      s_axi_arid(15 downto 0) => s00_couplers_to_auto_ds_ARID(15 downto 0),
      s_axi_arlen(7 downto 0) => s00_couplers_to_auto_ds_ARLEN(7 downto 0),
      s_axi_arlock(0) => s00_couplers_to_auto_ds_ARLOCK(0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_auto_ds_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => s00_couplers_to_auto_ds_ARQOS(3 downto 0),
      s_axi_arready => s00_couplers_to_auto_ds_ARREADY,
      s_axi_arregion(3 downto 0) => B"0000",
      s_axi_arsize(2 downto 0) => s00_couplers_to_auto_ds_ARSIZE(2 downto 0),
      s_axi_arvalid => s00_couplers_to_auto_ds_ARVALID,
      s_axi_awaddr(39 downto 0) => s00_couplers_to_auto_ds_AWADDR(39 downto 0),
      s_axi_awburst(1 downto 0) => s00_couplers_to_auto_ds_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => s00_couplers_to_auto_ds_AWCACHE(3 downto 0),
      s_axi_awid(15 downto 0) => s00_couplers_to_auto_ds_AWID(15 downto 0),
      s_axi_awlen(7 downto 0) => s00_couplers_to_auto_ds_AWLEN(7 downto 0),
      s_axi_awlock(0) => s00_couplers_to_auto_ds_AWLOCK(0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_auto_ds_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => s00_couplers_to_auto_ds_AWQOS(3 downto 0),
      s_axi_awready => s00_couplers_to_auto_ds_AWREADY,
      s_axi_awregion(3 downto 0) => B"0000",
      s_axi_awsize(2 downto 0) => s00_couplers_to_auto_ds_AWSIZE(2 downto 0),
      s_axi_awvalid => s00_couplers_to_auto_ds_AWVALID,
      s_axi_bid(15 downto 0) => s00_couplers_to_auto_ds_BID(15 downto 0),
      s_axi_bready => s00_couplers_to_auto_ds_BREADY,
      s_axi_bresp(1 downto 0) => s00_couplers_to_auto_ds_BRESP(1 downto 0),
      s_axi_bvalid => s00_couplers_to_auto_ds_BVALID,
      s_axi_rdata(127 downto 0) => s00_couplers_to_auto_ds_RDATA(127 downto 0),
      s_axi_rid(15 downto 0) => s00_couplers_to_auto_ds_RID(15 downto 0),
      s_axi_rlast => s00_couplers_to_auto_ds_RLAST,
      s_axi_rready => s00_couplers_to_auto_ds_RREADY,
      s_axi_rresp(1 downto 0) => s00_couplers_to_auto_ds_RRESP(1 downto 0),
      s_axi_rvalid => s00_couplers_to_auto_ds_RVALID,
      s_axi_wdata(127 downto 0) => s00_couplers_to_auto_ds_WDATA(127 downto 0),
      s_axi_wlast => s00_couplers_to_auto_ds_WLAST,
      s_axi_wready => s00_couplers_to_auto_ds_WREADY,
      s_axi_wstrb(15 downto 0) => s00_couplers_to_auto_ds_WSTRB(15 downto 0),
      s_axi_wvalid => s00_couplers_to_auto_ds_WVALID
    );
auto_pc: component memthing_auto_pc_0
     port map (
      aclk => S_ACLK_1,
      aresetn => S_ARESETN_1,
      m_axi_araddr(39 downto 0) => auto_pc_to_s00_couplers_ARADDR(39 downto 0),
      m_axi_arprot(2 downto 0) => auto_pc_to_s00_couplers_ARPROT(2 downto 0),
      m_axi_arready => auto_pc_to_s00_couplers_ARREADY,
      m_axi_arvalid => auto_pc_to_s00_couplers_ARVALID,
      m_axi_awaddr(39 downto 0) => auto_pc_to_s00_couplers_AWADDR(39 downto 0),
      m_axi_awprot(2 downto 0) => auto_pc_to_s00_couplers_AWPROT(2 downto 0),
      m_axi_awready => auto_pc_to_s00_couplers_AWREADY,
      m_axi_awvalid => auto_pc_to_s00_couplers_AWVALID,
      m_axi_bready => auto_pc_to_s00_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_pc_to_s00_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_pc_to_s00_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_pc_to_s00_couplers_RDATA(31 downto 0),
      m_axi_rready => auto_pc_to_s00_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_pc_to_s00_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_pc_to_s00_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_pc_to_s00_couplers_WDATA(31 downto 0),
      m_axi_wready => auto_pc_to_s00_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_pc_to_s00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_pc_to_s00_couplers_WVALID,
      s_axi_araddr(39 downto 0) => auto_ds_to_auto_pc_ARADDR(39 downto 0),
      s_axi_arburst(1 downto 0) => auto_ds_to_auto_pc_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => auto_ds_to_auto_pc_ARCACHE(3 downto 0),
      s_axi_arlen(7 downto 0) => auto_ds_to_auto_pc_ARLEN(7 downto 0),
      s_axi_arlock(0) => auto_ds_to_auto_pc_ARLOCK(0),
      s_axi_arprot(2 downto 0) => auto_ds_to_auto_pc_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => auto_ds_to_auto_pc_ARQOS(3 downto 0),
      s_axi_arready => auto_ds_to_auto_pc_ARREADY,
      s_axi_arregion(3 downto 0) => auto_ds_to_auto_pc_ARREGION(3 downto 0),
      s_axi_arsize(2 downto 0) => auto_ds_to_auto_pc_ARSIZE(2 downto 0),
      s_axi_arvalid => auto_ds_to_auto_pc_ARVALID,
      s_axi_awaddr(39 downto 0) => auto_ds_to_auto_pc_AWADDR(39 downto 0),
      s_axi_awburst(1 downto 0) => auto_ds_to_auto_pc_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => auto_ds_to_auto_pc_AWCACHE(3 downto 0),
      s_axi_awlen(7 downto 0) => auto_ds_to_auto_pc_AWLEN(7 downto 0),
      s_axi_awlock(0) => auto_ds_to_auto_pc_AWLOCK(0),
      s_axi_awprot(2 downto 0) => auto_ds_to_auto_pc_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => auto_ds_to_auto_pc_AWQOS(3 downto 0),
      s_axi_awready => auto_ds_to_auto_pc_AWREADY,
      s_axi_awregion(3 downto 0) => auto_ds_to_auto_pc_AWREGION(3 downto 0),
      s_axi_awsize(2 downto 0) => auto_ds_to_auto_pc_AWSIZE(2 downto 0),
      s_axi_awvalid => auto_ds_to_auto_pc_AWVALID,
      s_axi_bready => auto_ds_to_auto_pc_BREADY,
      s_axi_bresp(1 downto 0) => auto_ds_to_auto_pc_BRESP(1 downto 0),
      s_axi_bvalid => auto_ds_to_auto_pc_BVALID,
      s_axi_rdata(31 downto 0) => auto_ds_to_auto_pc_RDATA(31 downto 0),
      s_axi_rlast => auto_ds_to_auto_pc_RLAST,
      s_axi_rready => auto_ds_to_auto_pc_RREADY,
      s_axi_rresp(1 downto 0) => auto_ds_to_auto_pc_RRESP(1 downto 0),
      s_axi_rvalid => auto_ds_to_auto_pc_RVALID,
      s_axi_wdata(31 downto 0) => auto_ds_to_auto_pc_WDATA(31 downto 0),
      s_axi_wlast => auto_ds_to_auto_pc_WLAST,
      s_axi_wready => auto_ds_to_auto_pc_WREADY,
      s_axi_wstrb(3 downto 0) => auto_ds_to_auto_pc_WSTRB(3 downto 0),
      s_axi_wvalid => auto_ds_to_auto_pc_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s01_couplers_imp_1U4ZV9Y is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s01_couplers_imp_1U4ZV9Y;

architecture STRUCTURE of s01_couplers_imp_1U4ZV9Y is
  component memthing_auto_ds_1 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component memthing_auto_ds_1;
  component memthing_auto_pc_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component memthing_auto_pc_1;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC;
  signal auto_ds_to_auto_pc_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_ds_to_auto_pc_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal auto_ds_to_auto_pc_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_ds_to_auto_pc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_ARREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_ARREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_ARVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_ds_to_auto_pc_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal auto_ds_to_auto_pc_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_ds_to_auto_pc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_AWREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_AWREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_ds_to_auto_pc_AWVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_BREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_BVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_ds_to_auto_pc_RLAST : STD_LOGIC;
  signal auto_ds_to_auto_pc_RREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_ds_to_auto_pc_RVALID : STD_LOGIC;
  signal auto_ds_to_auto_pc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_ds_to_auto_pc_WLAST : STD_LOGIC;
  signal auto_ds_to_auto_pc_WREADY : STD_LOGIC;
  signal auto_ds_to_auto_pc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_ds_to_auto_pc_WVALID : STD_LOGIC;
  signal auto_pc_to_s01_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_pc_to_s01_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s01_couplers_ARREADY : STD_LOGIC;
  signal auto_pc_to_s01_couplers_ARVALID : STD_LOGIC;
  signal auto_pc_to_s01_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal auto_pc_to_s01_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s01_couplers_AWREADY : STD_LOGIC;
  signal auto_pc_to_s01_couplers_AWVALID : STD_LOGIC;
  signal auto_pc_to_s01_couplers_BREADY : STD_LOGIC;
  signal auto_pc_to_s01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s01_couplers_BVALID : STD_LOGIC;
  signal auto_pc_to_s01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s01_couplers_RREADY : STD_LOGIC;
  signal auto_pc_to_s01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s01_couplers_RVALID : STD_LOGIC;
  signal auto_pc_to_s01_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s01_couplers_WREADY : STD_LOGIC;
  signal auto_pc_to_s01_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s01_couplers_WVALID : STD_LOGIC;
  signal s01_couplers_to_auto_ds_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s01_couplers_to_auto_ds_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_auto_ds_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_auto_ds_ARID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s01_couplers_to_auto_ds_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s01_couplers_to_auto_ds_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_auto_ds_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_auto_ds_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_auto_ds_ARREADY : STD_LOGIC;
  signal s01_couplers_to_auto_ds_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_auto_ds_ARVALID : STD_LOGIC;
  signal s01_couplers_to_auto_ds_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s01_couplers_to_auto_ds_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_auto_ds_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_auto_ds_AWID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s01_couplers_to_auto_ds_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s01_couplers_to_auto_ds_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_auto_ds_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_auto_ds_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_auto_ds_AWREADY : STD_LOGIC;
  signal s01_couplers_to_auto_ds_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_auto_ds_AWVALID : STD_LOGIC;
  signal s01_couplers_to_auto_ds_BID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s01_couplers_to_auto_ds_BREADY : STD_LOGIC;
  signal s01_couplers_to_auto_ds_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_auto_ds_BVALID : STD_LOGIC;
  signal s01_couplers_to_auto_ds_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s01_couplers_to_auto_ds_RID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s01_couplers_to_auto_ds_RLAST : STD_LOGIC;
  signal s01_couplers_to_auto_ds_RREADY : STD_LOGIC;
  signal s01_couplers_to_auto_ds_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_auto_ds_RVALID : STD_LOGIC;
  signal s01_couplers_to_auto_ds_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s01_couplers_to_auto_ds_WLAST : STD_LOGIC;
  signal s01_couplers_to_auto_ds_WREADY : STD_LOGIC;
  signal s01_couplers_to_auto_ds_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s01_couplers_to_auto_ds_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(39 downto 0) <= auto_pc_to_s01_couplers_ARADDR(39 downto 0);
  M_AXI_arprot(2 downto 0) <= auto_pc_to_s01_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= auto_pc_to_s01_couplers_ARVALID;
  M_AXI_awaddr(39 downto 0) <= auto_pc_to_s01_couplers_AWADDR(39 downto 0);
  M_AXI_awprot(2 downto 0) <= auto_pc_to_s01_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= auto_pc_to_s01_couplers_AWVALID;
  M_AXI_bready <= auto_pc_to_s01_couplers_BREADY;
  M_AXI_rready <= auto_pc_to_s01_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_pc_to_s01_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= auto_pc_to_s01_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_pc_to_s01_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1 <= S_ARESETN;
  S_AXI_arready <= s01_couplers_to_auto_ds_ARREADY;
  S_AXI_awready <= s01_couplers_to_auto_ds_AWREADY;
  S_AXI_bid(15 downto 0) <= s01_couplers_to_auto_ds_BID(15 downto 0);
  S_AXI_bresp(1 downto 0) <= s01_couplers_to_auto_ds_BRESP(1 downto 0);
  S_AXI_bvalid <= s01_couplers_to_auto_ds_BVALID;
  S_AXI_rdata(127 downto 0) <= s01_couplers_to_auto_ds_RDATA(127 downto 0);
  S_AXI_rid(15 downto 0) <= s01_couplers_to_auto_ds_RID(15 downto 0);
  S_AXI_rlast <= s01_couplers_to_auto_ds_RLAST;
  S_AXI_rresp(1 downto 0) <= s01_couplers_to_auto_ds_RRESP(1 downto 0);
  S_AXI_rvalid <= s01_couplers_to_auto_ds_RVALID;
  S_AXI_wready <= s01_couplers_to_auto_ds_WREADY;
  auto_pc_to_s01_couplers_ARREADY <= M_AXI_arready;
  auto_pc_to_s01_couplers_AWREADY <= M_AXI_awready;
  auto_pc_to_s01_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_pc_to_s01_couplers_BVALID <= M_AXI_bvalid;
  auto_pc_to_s01_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_pc_to_s01_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_pc_to_s01_couplers_RVALID <= M_AXI_rvalid;
  auto_pc_to_s01_couplers_WREADY <= M_AXI_wready;
  s01_couplers_to_auto_ds_ARADDR(39 downto 0) <= S_AXI_araddr(39 downto 0);
  s01_couplers_to_auto_ds_ARBURST(1 downto 0) <= S_AXI_arburst(1 downto 0);
  s01_couplers_to_auto_ds_ARCACHE(3 downto 0) <= S_AXI_arcache(3 downto 0);
  s01_couplers_to_auto_ds_ARID(15 downto 0) <= S_AXI_arid(15 downto 0);
  s01_couplers_to_auto_ds_ARLEN(7 downto 0) <= S_AXI_arlen(7 downto 0);
  s01_couplers_to_auto_ds_ARLOCK(0) <= S_AXI_arlock(0);
  s01_couplers_to_auto_ds_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s01_couplers_to_auto_ds_ARQOS(3 downto 0) <= S_AXI_arqos(3 downto 0);
  s01_couplers_to_auto_ds_ARSIZE(2 downto 0) <= S_AXI_arsize(2 downto 0);
  s01_couplers_to_auto_ds_ARVALID <= S_AXI_arvalid;
  s01_couplers_to_auto_ds_AWADDR(39 downto 0) <= S_AXI_awaddr(39 downto 0);
  s01_couplers_to_auto_ds_AWBURST(1 downto 0) <= S_AXI_awburst(1 downto 0);
  s01_couplers_to_auto_ds_AWCACHE(3 downto 0) <= S_AXI_awcache(3 downto 0);
  s01_couplers_to_auto_ds_AWID(15 downto 0) <= S_AXI_awid(15 downto 0);
  s01_couplers_to_auto_ds_AWLEN(7 downto 0) <= S_AXI_awlen(7 downto 0);
  s01_couplers_to_auto_ds_AWLOCK(0) <= S_AXI_awlock(0);
  s01_couplers_to_auto_ds_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s01_couplers_to_auto_ds_AWQOS(3 downto 0) <= S_AXI_awqos(3 downto 0);
  s01_couplers_to_auto_ds_AWSIZE(2 downto 0) <= S_AXI_awsize(2 downto 0);
  s01_couplers_to_auto_ds_AWVALID <= S_AXI_awvalid;
  s01_couplers_to_auto_ds_BREADY <= S_AXI_bready;
  s01_couplers_to_auto_ds_RREADY <= S_AXI_rready;
  s01_couplers_to_auto_ds_WDATA(127 downto 0) <= S_AXI_wdata(127 downto 0);
  s01_couplers_to_auto_ds_WLAST <= S_AXI_wlast;
  s01_couplers_to_auto_ds_WSTRB(15 downto 0) <= S_AXI_wstrb(15 downto 0);
  s01_couplers_to_auto_ds_WVALID <= S_AXI_wvalid;
auto_ds: component memthing_auto_ds_1
     port map (
      m_axi_araddr(39 downto 0) => auto_ds_to_auto_pc_ARADDR(39 downto 0),
      m_axi_arburst(1 downto 0) => auto_ds_to_auto_pc_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => auto_ds_to_auto_pc_ARCACHE(3 downto 0),
      m_axi_arlen(7 downto 0) => auto_ds_to_auto_pc_ARLEN(7 downto 0),
      m_axi_arlock(0) => auto_ds_to_auto_pc_ARLOCK(0),
      m_axi_arprot(2 downto 0) => auto_ds_to_auto_pc_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => auto_ds_to_auto_pc_ARQOS(3 downto 0),
      m_axi_arready => auto_ds_to_auto_pc_ARREADY,
      m_axi_arregion(3 downto 0) => auto_ds_to_auto_pc_ARREGION(3 downto 0),
      m_axi_arsize(2 downto 0) => auto_ds_to_auto_pc_ARSIZE(2 downto 0),
      m_axi_arvalid => auto_ds_to_auto_pc_ARVALID,
      m_axi_awaddr(39 downto 0) => auto_ds_to_auto_pc_AWADDR(39 downto 0),
      m_axi_awburst(1 downto 0) => auto_ds_to_auto_pc_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => auto_ds_to_auto_pc_AWCACHE(3 downto 0),
      m_axi_awlen(7 downto 0) => auto_ds_to_auto_pc_AWLEN(7 downto 0),
      m_axi_awlock(0) => auto_ds_to_auto_pc_AWLOCK(0),
      m_axi_awprot(2 downto 0) => auto_ds_to_auto_pc_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => auto_ds_to_auto_pc_AWQOS(3 downto 0),
      m_axi_awready => auto_ds_to_auto_pc_AWREADY,
      m_axi_awregion(3 downto 0) => auto_ds_to_auto_pc_AWREGION(3 downto 0),
      m_axi_awsize(2 downto 0) => auto_ds_to_auto_pc_AWSIZE(2 downto 0),
      m_axi_awvalid => auto_ds_to_auto_pc_AWVALID,
      m_axi_bready => auto_ds_to_auto_pc_BREADY,
      m_axi_bresp(1 downto 0) => auto_ds_to_auto_pc_BRESP(1 downto 0),
      m_axi_bvalid => auto_ds_to_auto_pc_BVALID,
      m_axi_rdata(31 downto 0) => auto_ds_to_auto_pc_RDATA(31 downto 0),
      m_axi_rlast => auto_ds_to_auto_pc_RLAST,
      m_axi_rready => auto_ds_to_auto_pc_RREADY,
      m_axi_rresp(1 downto 0) => auto_ds_to_auto_pc_RRESP(1 downto 0),
      m_axi_rvalid => auto_ds_to_auto_pc_RVALID,
      m_axi_wdata(31 downto 0) => auto_ds_to_auto_pc_WDATA(31 downto 0),
      m_axi_wlast => auto_ds_to_auto_pc_WLAST,
      m_axi_wready => auto_ds_to_auto_pc_WREADY,
      m_axi_wstrb(3 downto 0) => auto_ds_to_auto_pc_WSTRB(3 downto 0),
      m_axi_wvalid => auto_ds_to_auto_pc_WVALID,
      s_axi_aclk => S_ACLK_1,
      s_axi_araddr(39 downto 0) => s01_couplers_to_auto_ds_ARADDR(39 downto 0),
      s_axi_arburst(1 downto 0) => s01_couplers_to_auto_ds_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => s01_couplers_to_auto_ds_ARCACHE(3 downto 0),
      s_axi_aresetn => S_ARESETN_1,
      s_axi_arid(15 downto 0) => s01_couplers_to_auto_ds_ARID(15 downto 0),
      s_axi_arlen(7 downto 0) => s01_couplers_to_auto_ds_ARLEN(7 downto 0),
      s_axi_arlock(0) => s01_couplers_to_auto_ds_ARLOCK(0),
      s_axi_arprot(2 downto 0) => s01_couplers_to_auto_ds_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => s01_couplers_to_auto_ds_ARQOS(3 downto 0),
      s_axi_arready => s01_couplers_to_auto_ds_ARREADY,
      s_axi_arregion(3 downto 0) => B"0000",
      s_axi_arsize(2 downto 0) => s01_couplers_to_auto_ds_ARSIZE(2 downto 0),
      s_axi_arvalid => s01_couplers_to_auto_ds_ARVALID,
      s_axi_awaddr(39 downto 0) => s01_couplers_to_auto_ds_AWADDR(39 downto 0),
      s_axi_awburst(1 downto 0) => s01_couplers_to_auto_ds_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => s01_couplers_to_auto_ds_AWCACHE(3 downto 0),
      s_axi_awid(15 downto 0) => s01_couplers_to_auto_ds_AWID(15 downto 0),
      s_axi_awlen(7 downto 0) => s01_couplers_to_auto_ds_AWLEN(7 downto 0),
      s_axi_awlock(0) => s01_couplers_to_auto_ds_AWLOCK(0),
      s_axi_awprot(2 downto 0) => s01_couplers_to_auto_ds_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => s01_couplers_to_auto_ds_AWQOS(3 downto 0),
      s_axi_awready => s01_couplers_to_auto_ds_AWREADY,
      s_axi_awregion(3 downto 0) => B"0000",
      s_axi_awsize(2 downto 0) => s01_couplers_to_auto_ds_AWSIZE(2 downto 0),
      s_axi_awvalid => s01_couplers_to_auto_ds_AWVALID,
      s_axi_bid(15 downto 0) => s01_couplers_to_auto_ds_BID(15 downto 0),
      s_axi_bready => s01_couplers_to_auto_ds_BREADY,
      s_axi_bresp(1 downto 0) => s01_couplers_to_auto_ds_BRESP(1 downto 0),
      s_axi_bvalid => s01_couplers_to_auto_ds_BVALID,
      s_axi_rdata(127 downto 0) => s01_couplers_to_auto_ds_RDATA(127 downto 0),
      s_axi_rid(15 downto 0) => s01_couplers_to_auto_ds_RID(15 downto 0),
      s_axi_rlast => s01_couplers_to_auto_ds_RLAST,
      s_axi_rready => s01_couplers_to_auto_ds_RREADY,
      s_axi_rresp(1 downto 0) => s01_couplers_to_auto_ds_RRESP(1 downto 0),
      s_axi_rvalid => s01_couplers_to_auto_ds_RVALID,
      s_axi_wdata(127 downto 0) => s01_couplers_to_auto_ds_WDATA(127 downto 0),
      s_axi_wlast => s01_couplers_to_auto_ds_WLAST,
      s_axi_wready => s01_couplers_to_auto_ds_WREADY,
      s_axi_wstrb(15 downto 0) => s01_couplers_to_auto_ds_WSTRB(15 downto 0),
      s_axi_wvalid => s01_couplers_to_auto_ds_WVALID
    );
auto_pc: component memthing_auto_pc_1
     port map (
      aclk => S_ACLK_1,
      aresetn => S_ARESETN_1,
      m_axi_araddr(39 downto 0) => auto_pc_to_s01_couplers_ARADDR(39 downto 0),
      m_axi_arprot(2 downto 0) => auto_pc_to_s01_couplers_ARPROT(2 downto 0),
      m_axi_arready => auto_pc_to_s01_couplers_ARREADY,
      m_axi_arvalid => auto_pc_to_s01_couplers_ARVALID,
      m_axi_awaddr(39 downto 0) => auto_pc_to_s01_couplers_AWADDR(39 downto 0),
      m_axi_awprot(2 downto 0) => auto_pc_to_s01_couplers_AWPROT(2 downto 0),
      m_axi_awready => auto_pc_to_s01_couplers_AWREADY,
      m_axi_awvalid => auto_pc_to_s01_couplers_AWVALID,
      m_axi_bready => auto_pc_to_s01_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_pc_to_s01_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_pc_to_s01_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_pc_to_s01_couplers_RDATA(31 downto 0),
      m_axi_rready => auto_pc_to_s01_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_pc_to_s01_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_pc_to_s01_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_pc_to_s01_couplers_WDATA(31 downto 0),
      m_axi_wready => auto_pc_to_s01_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_pc_to_s01_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_pc_to_s01_couplers_WVALID,
      s_axi_araddr(39 downto 0) => auto_ds_to_auto_pc_ARADDR(39 downto 0),
      s_axi_arburst(1 downto 0) => auto_ds_to_auto_pc_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => auto_ds_to_auto_pc_ARCACHE(3 downto 0),
      s_axi_arlen(7 downto 0) => auto_ds_to_auto_pc_ARLEN(7 downto 0),
      s_axi_arlock(0) => auto_ds_to_auto_pc_ARLOCK(0),
      s_axi_arprot(2 downto 0) => auto_ds_to_auto_pc_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => auto_ds_to_auto_pc_ARQOS(3 downto 0),
      s_axi_arready => auto_ds_to_auto_pc_ARREADY,
      s_axi_arregion(3 downto 0) => auto_ds_to_auto_pc_ARREGION(3 downto 0),
      s_axi_arsize(2 downto 0) => auto_ds_to_auto_pc_ARSIZE(2 downto 0),
      s_axi_arvalid => auto_ds_to_auto_pc_ARVALID,
      s_axi_awaddr(39 downto 0) => auto_ds_to_auto_pc_AWADDR(39 downto 0),
      s_axi_awburst(1 downto 0) => auto_ds_to_auto_pc_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => auto_ds_to_auto_pc_AWCACHE(3 downto 0),
      s_axi_awlen(7 downto 0) => auto_ds_to_auto_pc_AWLEN(7 downto 0),
      s_axi_awlock(0) => auto_ds_to_auto_pc_AWLOCK(0),
      s_axi_awprot(2 downto 0) => auto_ds_to_auto_pc_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => auto_ds_to_auto_pc_AWQOS(3 downto 0),
      s_axi_awready => auto_ds_to_auto_pc_AWREADY,
      s_axi_awregion(3 downto 0) => auto_ds_to_auto_pc_AWREGION(3 downto 0),
      s_axi_awsize(2 downto 0) => auto_ds_to_auto_pc_AWSIZE(2 downto 0),
      s_axi_awvalid => auto_ds_to_auto_pc_AWVALID,
      s_axi_bready => auto_ds_to_auto_pc_BREADY,
      s_axi_bresp(1 downto 0) => auto_ds_to_auto_pc_BRESP(1 downto 0),
      s_axi_bvalid => auto_ds_to_auto_pc_BVALID,
      s_axi_rdata(31 downto 0) => auto_ds_to_auto_pc_RDATA(31 downto 0),
      s_axi_rlast => auto_ds_to_auto_pc_RLAST,
      s_axi_rready => auto_ds_to_auto_pc_RREADY,
      s_axi_rresp(1 downto 0) => auto_ds_to_auto_pc_RRESP(1 downto 0),
      s_axi_rvalid => auto_ds_to_auto_pc_RVALID,
      s_axi_wdata(31 downto 0) => auto_ds_to_auto_pc_WDATA(31 downto 0),
      s_axi_wlast => auto_ds_to_auto_pc_WLAST,
      s_axi_wready => auto_ds_to_auto_pc_WREADY,
      s_axi_wstrb(3 downto 0) => auto_ds_to_auto_pc_WSTRB(3 downto 0),
      s_axi_wvalid => auto_ds_to_auto_pc_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity memthing_ps8_0_axi_periph_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M00_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M00_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M01_ACLK : in STD_LOGIC;
    M01_ARESETN : in STD_LOGIC;
    M01_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M01_AXI_arready : in STD_LOGIC;
    M01_AXI_arvalid : out STD_LOGIC;
    M01_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M01_AXI_awready : in STD_LOGIC;
    M01_AXI_awvalid : out STD_LOGIC;
    M01_AXI_bready : out STD_LOGIC;
    M01_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_bvalid : in STD_LOGIC;
    M01_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_rready : out STD_LOGIC;
    M01_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_rvalid : in STD_LOGIC;
    M01_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_wready : in STD_LOGIC;
    M01_AXI_wvalid : out STD_LOGIC;
    M02_ACLK : in STD_LOGIC;
    M02_ARESETN : in STD_LOGIC;
    M02_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M02_AXI_arready : in STD_LOGIC;
    M02_AXI_arvalid : out STD_LOGIC;
    M02_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M02_AXI_awready : in STD_LOGIC;
    M02_AXI_awvalid : out STD_LOGIC;
    M02_AXI_bready : out STD_LOGIC;
    M02_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_bvalid : in STD_LOGIC;
    M02_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_rready : out STD_LOGIC;
    M02_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_rvalid : in STD_LOGIC;
    M02_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_wready : in STD_LOGIC;
    M02_AXI_wvalid : out STD_LOGIC;
    M03_ACLK : in STD_LOGIC;
    M03_ARESETN : in STD_LOGIC;
    M03_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M03_AXI_arready : in STD_LOGIC;
    M03_AXI_arvalid : out STD_LOGIC;
    M03_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M03_AXI_awready : in STD_LOGIC;
    M03_AXI_awvalid : out STD_LOGIC;
    M03_AXI_bready : out STD_LOGIC;
    M03_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_bvalid : in STD_LOGIC;
    M03_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_rready : out STD_LOGIC;
    M03_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_rvalid : in STD_LOGIC;
    M03_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_wready : in STD_LOGIC;
    M03_AXI_wvalid : out STD_LOGIC;
    M04_ACLK : in STD_LOGIC;
    M04_ARESETN : in STD_LOGIC;
    M04_AXI_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M04_AXI_arready : in STD_LOGIC;
    M04_AXI_arvalid : out STD_LOGIC;
    M04_AXI_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    M04_AXI_awready : in STD_LOGIC;
    M04_AXI_awvalid : out STD_LOGIC;
    M04_AXI_bready : out STD_LOGIC;
    M04_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_bvalid : in STD_LOGIC;
    M04_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_rready : out STD_LOGIC;
    M04_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_rvalid : in STD_LOGIC;
    M04_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_wready : in STD_LOGIC;
    M04_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S00_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S00_AXI_rid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S00_AXI_wlast : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC;
    S01_ACLK : in STD_LOGIC;
    S01_ARESETN : in STD_LOGIC;
    S01_AXI_araddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S01_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S01_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arready : out STD_LOGIC;
    S01_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arvalid : in STD_LOGIC;
    S01_AXI_awaddr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    S01_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S01_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awready : out STD_LOGIC;
    S01_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awvalid : in STD_LOGIC;
    S01_AXI_bid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S01_AXI_bready : in STD_LOGIC;
    S01_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_bvalid : out STD_LOGIC;
    S01_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S01_AXI_rid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S01_AXI_rlast : out STD_LOGIC;
    S01_AXI_rready : in STD_LOGIC;
    S01_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_rvalid : out STD_LOGIC;
    S01_AXI_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S01_AXI_wlast : in STD_LOGIC;
    S01_AXI_wready : out STD_LOGIC;
    S01_AXI_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S01_AXI_wvalid : in STD_LOGIC
  );
end memthing_ps8_0_axi_periph_0;

architecture STRUCTURE of memthing_ps8_0_axi_periph_0 is
  component memthing_xbar_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 79 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 79 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 199 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 14 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 159 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 19 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 199 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 14 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 159 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component memthing_xbar_0;
  signal m00_couplers_to_ps8_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m00_couplers_to_ps8_0_axi_periph_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m00_couplers_to_ps8_0_axi_periph_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_ps8_0_axi_periph_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_ps8_0_axi_periph_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_ps8_0_axi_periph_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_ps8_0_axi_periph_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_ps8_0_axi_periph_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m01_couplers_to_ps8_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m01_couplers_to_ps8_0_axi_periph_ARREADY : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_ARVALID : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m01_couplers_to_ps8_0_axi_periph_AWREADY : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_AWVALID : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_BREADY : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_ps8_0_axi_periph_BVALID : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_ps8_0_axi_periph_RREADY : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_ps8_0_axi_periph_RVALID : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_ps8_0_axi_periph_WREADY : STD_LOGIC;
  signal m01_couplers_to_ps8_0_axi_periph_WVALID : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m02_couplers_to_ps8_0_axi_periph_ARREADY : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_ARVALID : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m02_couplers_to_ps8_0_axi_periph_AWREADY : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_AWVALID : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_BREADY : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_ps8_0_axi_periph_BVALID : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_ps8_0_axi_periph_RREADY : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_ps8_0_axi_periph_RVALID : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_ps8_0_axi_periph_WREADY : STD_LOGIC;
  signal m02_couplers_to_ps8_0_axi_periph_WVALID : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m03_couplers_to_ps8_0_axi_periph_ARREADY : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_ARVALID : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m03_couplers_to_ps8_0_axi_periph_AWREADY : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_AWVALID : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_BREADY : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_ps8_0_axi_periph_BVALID : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_ps8_0_axi_periph_RREADY : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_ps8_0_axi_periph_RVALID : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_ps8_0_axi_periph_WREADY : STD_LOGIC;
  signal m03_couplers_to_ps8_0_axi_periph_WVALID : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m04_couplers_to_ps8_0_axi_periph_ARREADY : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_ARVALID : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal m04_couplers_to_ps8_0_axi_periph_AWREADY : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_AWVALID : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_BREADY : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_ps8_0_axi_periph_BVALID : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_ps8_0_axi_periph_RREADY : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_ps8_0_axi_periph_RVALID : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_ps8_0_axi_periph_WREADY : STD_LOGIC;
  signal m04_couplers_to_ps8_0_axi_periph_WVALID : STD_LOGIC;
  signal ps8_0_axi_periph_ACLK_net : STD_LOGIC;
  signal ps8_0_axi_periph_ARESETN_net : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_ARVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_AWVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_BID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_BREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_BVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_RID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_RLAST : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_RREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_RVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_WLAST : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_WREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s00_couplers_WVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_ARVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_AWVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_BID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_BREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_BVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_RID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_RLAST : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_RREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_RVALID : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_WLAST : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_WREADY : STD_LOGIC;
  signal ps8_0_axi_periph_to_s01_couplers_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ps8_0_axi_periph_to_s01_couplers_WVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s00_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s00_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_WVALID : STD_LOGIC;
  signal s01_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s01_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s01_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal s01_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s01_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s01_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal s01_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal s01_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s01_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal s01_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_xbar_WVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal xbar_to_m00_couplers_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal xbar_to_m00_couplers_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 79 downto 40 );
  signal xbar_to_m01_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_ARVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 79 downto 40 );
  signal xbar_to_m01_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_AWVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m01_couplers_RREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_WVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m02_couplers_ARADDR : STD_LOGIC_VECTOR ( 119 downto 80 );
  signal xbar_to_m02_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_ARVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_AWADDR : STD_LOGIC_VECTOR ( 119 downto 80 );
  signal xbar_to_m02_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_AWVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_BREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m02_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m02_couplers_RREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m02_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m02_couplers_WDATA : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal xbar_to_m02_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_WVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m03_couplers_ARADDR : STD_LOGIC_VECTOR ( 159 downto 120 );
  signal xbar_to_m03_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_ARVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_AWADDR : STD_LOGIC_VECTOR ( 159 downto 120 );
  signal xbar_to_m03_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_AWVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_BREADY : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m03_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m03_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m03_couplers_RREADY : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m03_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m03_couplers_WDATA : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal xbar_to_m03_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_WVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m04_couplers_ARADDR : STD_LOGIC_VECTOR ( 199 downto 160 );
  signal xbar_to_m04_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_ARVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_AWADDR : STD_LOGIC_VECTOR ( 199 downto 160 );
  signal xbar_to_m04_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_AWVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_BREADY : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m04_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m04_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m04_couplers_RREADY : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m04_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m04_couplers_WDATA : STD_LOGIC_VECTOR ( 159 downto 128 );
  signal xbar_to_m04_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_WVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal NLW_xbar_m_axi_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal NLW_xbar_m_axi_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal NLW_xbar_m_axi_wstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 19 downto 0 );
begin
  M00_AXI_araddr(39 downto 0) <= m00_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0);
  M00_AXI_arvalid(0) <= m00_couplers_to_ps8_0_axi_periph_ARVALID(0);
  M00_AXI_awaddr(39 downto 0) <= m00_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0);
  M00_AXI_awvalid(0) <= m00_couplers_to_ps8_0_axi_periph_AWVALID(0);
  M00_AXI_bready(0) <= m00_couplers_to_ps8_0_axi_periph_BREADY(0);
  M00_AXI_rready(0) <= m00_couplers_to_ps8_0_axi_periph_RREADY(0);
  M00_AXI_wdata(31 downto 0) <= m00_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0);
  M00_AXI_wvalid(0) <= m00_couplers_to_ps8_0_axi_periph_WVALID(0);
  M01_AXI_araddr(39 downto 0) <= m01_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0);
  M01_AXI_arvalid <= m01_couplers_to_ps8_0_axi_periph_ARVALID;
  M01_AXI_awaddr(39 downto 0) <= m01_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0);
  M01_AXI_awvalid <= m01_couplers_to_ps8_0_axi_periph_AWVALID;
  M01_AXI_bready <= m01_couplers_to_ps8_0_axi_periph_BREADY;
  M01_AXI_rready <= m01_couplers_to_ps8_0_axi_periph_RREADY;
  M01_AXI_wdata(31 downto 0) <= m01_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0);
  M01_AXI_wvalid <= m01_couplers_to_ps8_0_axi_periph_WVALID;
  M02_AXI_araddr(39 downto 0) <= m02_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0);
  M02_AXI_arvalid <= m02_couplers_to_ps8_0_axi_periph_ARVALID;
  M02_AXI_awaddr(39 downto 0) <= m02_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0);
  M02_AXI_awvalid <= m02_couplers_to_ps8_0_axi_periph_AWVALID;
  M02_AXI_bready <= m02_couplers_to_ps8_0_axi_periph_BREADY;
  M02_AXI_rready <= m02_couplers_to_ps8_0_axi_periph_RREADY;
  M02_AXI_wdata(31 downto 0) <= m02_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0);
  M02_AXI_wvalid <= m02_couplers_to_ps8_0_axi_periph_WVALID;
  M03_AXI_araddr(39 downto 0) <= m03_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0);
  M03_AXI_arvalid <= m03_couplers_to_ps8_0_axi_periph_ARVALID;
  M03_AXI_awaddr(39 downto 0) <= m03_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0);
  M03_AXI_awvalid <= m03_couplers_to_ps8_0_axi_periph_AWVALID;
  M03_AXI_bready <= m03_couplers_to_ps8_0_axi_periph_BREADY;
  M03_AXI_rready <= m03_couplers_to_ps8_0_axi_periph_RREADY;
  M03_AXI_wdata(31 downto 0) <= m03_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0);
  M03_AXI_wvalid <= m03_couplers_to_ps8_0_axi_periph_WVALID;
  M04_AXI_araddr(39 downto 0) <= m04_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0);
  M04_AXI_arvalid <= m04_couplers_to_ps8_0_axi_periph_ARVALID;
  M04_AXI_awaddr(39 downto 0) <= m04_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0);
  M04_AXI_awvalid <= m04_couplers_to_ps8_0_axi_periph_AWVALID;
  M04_AXI_bready <= m04_couplers_to_ps8_0_axi_periph_BREADY;
  M04_AXI_rready <= m04_couplers_to_ps8_0_axi_periph_RREADY;
  M04_AXI_wdata(31 downto 0) <= m04_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0);
  M04_AXI_wvalid <= m04_couplers_to_ps8_0_axi_periph_WVALID;
  S00_AXI_arready <= ps8_0_axi_periph_to_s00_couplers_ARREADY;
  S00_AXI_awready <= ps8_0_axi_periph_to_s00_couplers_AWREADY;
  S00_AXI_bid(15 downto 0) <= ps8_0_axi_periph_to_s00_couplers_BID(15 downto 0);
  S00_AXI_bresp(1 downto 0) <= ps8_0_axi_periph_to_s00_couplers_BRESP(1 downto 0);
  S00_AXI_bvalid <= ps8_0_axi_periph_to_s00_couplers_BVALID;
  S00_AXI_rdata(127 downto 0) <= ps8_0_axi_periph_to_s00_couplers_RDATA(127 downto 0);
  S00_AXI_rid(15 downto 0) <= ps8_0_axi_periph_to_s00_couplers_RID(15 downto 0);
  S00_AXI_rlast <= ps8_0_axi_periph_to_s00_couplers_RLAST;
  S00_AXI_rresp(1 downto 0) <= ps8_0_axi_periph_to_s00_couplers_RRESP(1 downto 0);
  S00_AXI_rvalid <= ps8_0_axi_periph_to_s00_couplers_RVALID;
  S00_AXI_wready <= ps8_0_axi_periph_to_s00_couplers_WREADY;
  S01_AXI_arready <= ps8_0_axi_periph_to_s01_couplers_ARREADY;
  S01_AXI_awready <= ps8_0_axi_periph_to_s01_couplers_AWREADY;
  S01_AXI_bid(15 downto 0) <= ps8_0_axi_periph_to_s01_couplers_BID(15 downto 0);
  S01_AXI_bresp(1 downto 0) <= ps8_0_axi_periph_to_s01_couplers_BRESP(1 downto 0);
  S01_AXI_bvalid <= ps8_0_axi_periph_to_s01_couplers_BVALID;
  S01_AXI_rdata(127 downto 0) <= ps8_0_axi_periph_to_s01_couplers_RDATA(127 downto 0);
  S01_AXI_rid(15 downto 0) <= ps8_0_axi_periph_to_s01_couplers_RID(15 downto 0);
  S01_AXI_rlast <= ps8_0_axi_periph_to_s01_couplers_RLAST;
  S01_AXI_rresp(1 downto 0) <= ps8_0_axi_periph_to_s01_couplers_RRESP(1 downto 0);
  S01_AXI_rvalid <= ps8_0_axi_periph_to_s01_couplers_RVALID;
  S01_AXI_wready <= ps8_0_axi_periph_to_s01_couplers_WREADY;
  m00_couplers_to_ps8_0_axi_periph_ARREADY(0) <= M00_AXI_arready(0);
  m00_couplers_to_ps8_0_axi_periph_AWREADY(0) <= M00_AXI_awready(0);
  m00_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0) <= M00_AXI_bresp(1 downto 0);
  m00_couplers_to_ps8_0_axi_periph_BVALID(0) <= M00_AXI_bvalid(0);
  m00_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0) <= M00_AXI_rdata(31 downto 0);
  m00_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0) <= M00_AXI_rresp(1 downto 0);
  m00_couplers_to_ps8_0_axi_periph_RVALID(0) <= M00_AXI_rvalid(0);
  m00_couplers_to_ps8_0_axi_periph_WREADY(0) <= M00_AXI_wready(0);
  m01_couplers_to_ps8_0_axi_periph_ARREADY <= M01_AXI_arready;
  m01_couplers_to_ps8_0_axi_periph_AWREADY <= M01_AXI_awready;
  m01_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0) <= M01_AXI_bresp(1 downto 0);
  m01_couplers_to_ps8_0_axi_periph_BVALID <= M01_AXI_bvalid;
  m01_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0) <= M01_AXI_rdata(31 downto 0);
  m01_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0) <= M01_AXI_rresp(1 downto 0);
  m01_couplers_to_ps8_0_axi_periph_RVALID <= M01_AXI_rvalid;
  m01_couplers_to_ps8_0_axi_periph_WREADY <= M01_AXI_wready;
  m02_couplers_to_ps8_0_axi_periph_ARREADY <= M02_AXI_arready;
  m02_couplers_to_ps8_0_axi_periph_AWREADY <= M02_AXI_awready;
  m02_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0) <= M02_AXI_bresp(1 downto 0);
  m02_couplers_to_ps8_0_axi_periph_BVALID <= M02_AXI_bvalid;
  m02_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0) <= M02_AXI_rdata(31 downto 0);
  m02_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0) <= M02_AXI_rresp(1 downto 0);
  m02_couplers_to_ps8_0_axi_periph_RVALID <= M02_AXI_rvalid;
  m02_couplers_to_ps8_0_axi_periph_WREADY <= M02_AXI_wready;
  m03_couplers_to_ps8_0_axi_periph_ARREADY <= M03_AXI_arready;
  m03_couplers_to_ps8_0_axi_periph_AWREADY <= M03_AXI_awready;
  m03_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0) <= M03_AXI_bresp(1 downto 0);
  m03_couplers_to_ps8_0_axi_periph_BVALID <= M03_AXI_bvalid;
  m03_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0) <= M03_AXI_rdata(31 downto 0);
  m03_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0) <= M03_AXI_rresp(1 downto 0);
  m03_couplers_to_ps8_0_axi_periph_RVALID <= M03_AXI_rvalid;
  m03_couplers_to_ps8_0_axi_periph_WREADY <= M03_AXI_wready;
  m04_couplers_to_ps8_0_axi_periph_ARREADY <= M04_AXI_arready;
  m04_couplers_to_ps8_0_axi_periph_AWREADY <= M04_AXI_awready;
  m04_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0) <= M04_AXI_bresp(1 downto 0);
  m04_couplers_to_ps8_0_axi_periph_BVALID <= M04_AXI_bvalid;
  m04_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0) <= M04_AXI_rdata(31 downto 0);
  m04_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0) <= M04_AXI_rresp(1 downto 0);
  m04_couplers_to_ps8_0_axi_periph_RVALID <= M04_AXI_rvalid;
  m04_couplers_to_ps8_0_axi_periph_WREADY <= M04_AXI_wready;
  ps8_0_axi_periph_ACLK_net <= ACLK;
  ps8_0_axi_periph_ARESETN_net <= ARESETN;
  ps8_0_axi_periph_to_s00_couplers_ARADDR(39 downto 0) <= S00_AXI_araddr(39 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARBURST(1 downto 0) <= S00_AXI_arburst(1 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARCACHE(3 downto 0) <= S00_AXI_arcache(3 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARID(15 downto 0) <= S00_AXI_arid(15 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARLEN(7 downto 0) <= S00_AXI_arlen(7 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARLOCK(0) <= S00_AXI_arlock(0);
  ps8_0_axi_periph_to_s00_couplers_ARPROT(2 downto 0) <= S00_AXI_arprot(2 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARQOS(3 downto 0) <= S00_AXI_arqos(3 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARSIZE(2 downto 0) <= S00_AXI_arsize(2 downto 0);
  ps8_0_axi_periph_to_s00_couplers_ARVALID <= S00_AXI_arvalid;
  ps8_0_axi_periph_to_s00_couplers_AWADDR(39 downto 0) <= S00_AXI_awaddr(39 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWBURST(1 downto 0) <= S00_AXI_awburst(1 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWCACHE(3 downto 0) <= S00_AXI_awcache(3 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWID(15 downto 0) <= S00_AXI_awid(15 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWLEN(7 downto 0) <= S00_AXI_awlen(7 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWLOCK(0) <= S00_AXI_awlock(0);
  ps8_0_axi_periph_to_s00_couplers_AWPROT(2 downto 0) <= S00_AXI_awprot(2 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWQOS(3 downto 0) <= S00_AXI_awqos(3 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWSIZE(2 downto 0) <= S00_AXI_awsize(2 downto 0);
  ps8_0_axi_periph_to_s00_couplers_AWVALID <= S00_AXI_awvalid;
  ps8_0_axi_periph_to_s00_couplers_BREADY <= S00_AXI_bready;
  ps8_0_axi_periph_to_s00_couplers_RREADY <= S00_AXI_rready;
  ps8_0_axi_periph_to_s00_couplers_WDATA(127 downto 0) <= S00_AXI_wdata(127 downto 0);
  ps8_0_axi_periph_to_s00_couplers_WLAST <= S00_AXI_wlast;
  ps8_0_axi_periph_to_s00_couplers_WSTRB(15 downto 0) <= S00_AXI_wstrb(15 downto 0);
  ps8_0_axi_periph_to_s00_couplers_WVALID <= S00_AXI_wvalid;
  ps8_0_axi_periph_to_s01_couplers_ARADDR(39 downto 0) <= S01_AXI_araddr(39 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARBURST(1 downto 0) <= S01_AXI_arburst(1 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARCACHE(3 downto 0) <= S01_AXI_arcache(3 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARID(15 downto 0) <= S01_AXI_arid(15 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARLEN(7 downto 0) <= S01_AXI_arlen(7 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARLOCK(0) <= S01_AXI_arlock(0);
  ps8_0_axi_periph_to_s01_couplers_ARPROT(2 downto 0) <= S01_AXI_arprot(2 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARQOS(3 downto 0) <= S01_AXI_arqos(3 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARSIZE(2 downto 0) <= S01_AXI_arsize(2 downto 0);
  ps8_0_axi_periph_to_s01_couplers_ARVALID <= S01_AXI_arvalid;
  ps8_0_axi_periph_to_s01_couplers_AWADDR(39 downto 0) <= S01_AXI_awaddr(39 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWBURST(1 downto 0) <= S01_AXI_awburst(1 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWCACHE(3 downto 0) <= S01_AXI_awcache(3 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWID(15 downto 0) <= S01_AXI_awid(15 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWLEN(7 downto 0) <= S01_AXI_awlen(7 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWLOCK(0) <= S01_AXI_awlock(0);
  ps8_0_axi_periph_to_s01_couplers_AWPROT(2 downto 0) <= S01_AXI_awprot(2 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWQOS(3 downto 0) <= S01_AXI_awqos(3 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWSIZE(2 downto 0) <= S01_AXI_awsize(2 downto 0);
  ps8_0_axi_periph_to_s01_couplers_AWVALID <= S01_AXI_awvalid;
  ps8_0_axi_periph_to_s01_couplers_BREADY <= S01_AXI_bready;
  ps8_0_axi_periph_to_s01_couplers_RREADY <= S01_AXI_rready;
  ps8_0_axi_periph_to_s01_couplers_WDATA(127 downto 0) <= S01_AXI_wdata(127 downto 0);
  ps8_0_axi_periph_to_s01_couplers_WLAST <= S01_AXI_wlast;
  ps8_0_axi_periph_to_s01_couplers_WSTRB(15 downto 0) <= S01_AXI_wstrb(15 downto 0);
  ps8_0_axi_periph_to_s01_couplers_WVALID <= S01_AXI_wvalid;
m00_couplers: entity work.m00_couplers_imp_1WV5K1H
     port map (
      M_ACLK => ps8_0_axi_periph_ACLK_net,
      M_ARESETN => ps8_0_axi_periph_ARESETN_net,
      M_AXI_araddr(39 downto 0) => m00_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0),
      M_AXI_arready(0) => m00_couplers_to_ps8_0_axi_periph_ARREADY(0),
      M_AXI_arvalid(0) => m00_couplers_to_ps8_0_axi_periph_ARVALID(0),
      M_AXI_awaddr(39 downto 0) => m00_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0),
      M_AXI_awready(0) => m00_couplers_to_ps8_0_axi_periph_AWREADY(0),
      M_AXI_awvalid(0) => m00_couplers_to_ps8_0_axi_periph_AWVALID(0),
      M_AXI_bready(0) => m00_couplers_to_ps8_0_axi_periph_BREADY(0),
      M_AXI_bresp(1 downto 0) => m00_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid(0) => m00_couplers_to_ps8_0_axi_periph_BVALID(0),
      M_AXI_rdata(31 downto 0) => m00_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready(0) => m00_couplers_to_ps8_0_axi_periph_RREADY(0),
      M_AXI_rresp(1 downto 0) => m00_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid(0) => m00_couplers_to_ps8_0_axi_periph_RVALID(0),
      M_AXI_wdata(31 downto 0) => m00_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready(0) => m00_couplers_to_ps8_0_axi_periph_WREADY(0),
      M_AXI_wvalid(0) => m00_couplers_to_ps8_0_axi_periph_WVALID(0),
      S_ACLK => ps8_0_axi_periph_ACLK_net,
      S_ARESETN => ps8_0_axi_periph_ARESETN_net,
      S_AXI_araddr(39 downto 0) => xbar_to_m00_couplers_ARADDR(39 downto 0),
      S_AXI_arready(0) => xbar_to_m00_couplers_ARREADY(0),
      S_AXI_arvalid(0) => xbar_to_m00_couplers_ARVALID(0),
      S_AXI_awaddr(39 downto 0) => xbar_to_m00_couplers_AWADDR(39 downto 0),
      S_AXI_awready(0) => xbar_to_m00_couplers_AWREADY(0),
      S_AXI_awvalid(0) => xbar_to_m00_couplers_AWVALID(0),
      S_AXI_bready(0) => xbar_to_m00_couplers_BREADY(0),
      S_AXI_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid(0) => xbar_to_m00_couplers_BVALID(0),
      S_AXI_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      S_AXI_rready(0) => xbar_to_m00_couplers_RREADY(0),
      S_AXI_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid(0) => xbar_to_m00_couplers_RVALID(0),
      S_AXI_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      S_AXI_wready(0) => xbar_to_m00_couplers_WREADY(0),
      S_AXI_wvalid(0) => xbar_to_m00_couplers_WVALID(0)
    );
m01_couplers: entity work.m01_couplers_imp_6HII50
     port map (
      M_ACLK => ps8_0_axi_periph_ACLK_net,
      M_ARESETN => ps8_0_axi_periph_ARESETN_net,
      M_AXI_araddr(39 downto 0) => m01_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0),
      M_AXI_arready => m01_couplers_to_ps8_0_axi_periph_ARREADY,
      M_AXI_arvalid => m01_couplers_to_ps8_0_axi_periph_ARVALID,
      M_AXI_awaddr(39 downto 0) => m01_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0),
      M_AXI_awready => m01_couplers_to_ps8_0_axi_periph_AWREADY,
      M_AXI_awvalid => m01_couplers_to_ps8_0_axi_periph_AWVALID,
      M_AXI_bready => m01_couplers_to_ps8_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m01_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m01_couplers_to_ps8_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m01_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m01_couplers_to_ps8_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m01_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m01_couplers_to_ps8_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m01_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m01_couplers_to_ps8_0_axi_periph_WREADY,
      M_AXI_wvalid => m01_couplers_to_ps8_0_axi_periph_WVALID,
      S_ACLK => ps8_0_axi_periph_ACLK_net,
      S_ARESETN => ps8_0_axi_periph_ARESETN_net,
      S_AXI_araddr(39 downto 0) => xbar_to_m01_couplers_ARADDR(79 downto 40),
      S_AXI_arready => xbar_to_m01_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m01_couplers_ARVALID(1),
      S_AXI_awaddr(39 downto 0) => xbar_to_m01_couplers_AWADDR(79 downto 40),
      S_AXI_awready => xbar_to_m01_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m01_couplers_AWVALID(1),
      S_AXI_bready => xbar_to_m01_couplers_BREADY(1),
      S_AXI_bresp(1 downto 0) => xbar_to_m01_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m01_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m01_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m01_couplers_RREADY(1),
      S_AXI_rresp(1 downto 0) => xbar_to_m01_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m01_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m01_couplers_WDATA(63 downto 32),
      S_AXI_wready => xbar_to_m01_couplers_WREADY,
      S_AXI_wvalid => xbar_to_m01_couplers_WVALID(1)
    );
m02_couplers: entity work.m02_couplers_imp_1YG4X12
     port map (
      M_ACLK => ps8_0_axi_periph_ACLK_net,
      M_ARESETN => ps8_0_axi_periph_ARESETN_net,
      M_AXI_araddr(39 downto 0) => m02_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0),
      M_AXI_arready => m02_couplers_to_ps8_0_axi_periph_ARREADY,
      M_AXI_arvalid => m02_couplers_to_ps8_0_axi_periph_ARVALID,
      M_AXI_awaddr(39 downto 0) => m02_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0),
      M_AXI_awready => m02_couplers_to_ps8_0_axi_periph_AWREADY,
      M_AXI_awvalid => m02_couplers_to_ps8_0_axi_periph_AWVALID,
      M_AXI_bready => m02_couplers_to_ps8_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m02_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m02_couplers_to_ps8_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m02_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m02_couplers_to_ps8_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m02_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m02_couplers_to_ps8_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m02_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m02_couplers_to_ps8_0_axi_periph_WREADY,
      M_AXI_wvalid => m02_couplers_to_ps8_0_axi_periph_WVALID,
      S_ACLK => ps8_0_axi_periph_ACLK_net,
      S_ARESETN => ps8_0_axi_periph_ARESETN_net,
      S_AXI_araddr(39 downto 0) => xbar_to_m02_couplers_ARADDR(119 downto 80),
      S_AXI_arready => xbar_to_m02_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m02_couplers_ARVALID(2),
      S_AXI_awaddr(39 downto 0) => xbar_to_m02_couplers_AWADDR(119 downto 80),
      S_AXI_awready => xbar_to_m02_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m02_couplers_AWVALID(2),
      S_AXI_bready => xbar_to_m02_couplers_BREADY(2),
      S_AXI_bresp(1 downto 0) => xbar_to_m02_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m02_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m02_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m02_couplers_RREADY(2),
      S_AXI_rresp(1 downto 0) => xbar_to_m02_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m02_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m02_couplers_WDATA(95 downto 64),
      S_AXI_wready => xbar_to_m02_couplers_WREADY,
      S_AXI_wvalid => xbar_to_m02_couplers_WVALID(2)
    );
m03_couplers: entity work.m03_couplers_imp_56UR4N
     port map (
      M_ACLK => ps8_0_axi_periph_ACLK_net,
      M_ARESETN => ps8_0_axi_periph_ARESETN_net,
      M_AXI_araddr(39 downto 0) => m03_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0),
      M_AXI_arready => m03_couplers_to_ps8_0_axi_periph_ARREADY,
      M_AXI_arvalid => m03_couplers_to_ps8_0_axi_periph_ARVALID,
      M_AXI_awaddr(39 downto 0) => m03_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0),
      M_AXI_awready => m03_couplers_to_ps8_0_axi_periph_AWREADY,
      M_AXI_awvalid => m03_couplers_to_ps8_0_axi_periph_AWVALID,
      M_AXI_bready => m03_couplers_to_ps8_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m03_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m03_couplers_to_ps8_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m03_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m03_couplers_to_ps8_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m03_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m03_couplers_to_ps8_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m03_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m03_couplers_to_ps8_0_axi_periph_WREADY,
      M_AXI_wvalid => m03_couplers_to_ps8_0_axi_periph_WVALID,
      S_ACLK => ps8_0_axi_periph_ACLK_net,
      S_ARESETN => ps8_0_axi_periph_ARESETN_net,
      S_AXI_araddr(39 downto 0) => xbar_to_m03_couplers_ARADDR(159 downto 120),
      S_AXI_arready => xbar_to_m03_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m03_couplers_ARVALID(3),
      S_AXI_awaddr(39 downto 0) => xbar_to_m03_couplers_AWADDR(159 downto 120),
      S_AXI_awready => xbar_to_m03_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m03_couplers_AWVALID(3),
      S_AXI_bready => xbar_to_m03_couplers_BREADY(3),
      S_AXI_bresp(1 downto 0) => xbar_to_m03_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m03_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m03_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m03_couplers_RREADY(3),
      S_AXI_rresp(1 downto 0) => xbar_to_m03_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m03_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m03_couplers_WDATA(127 downto 96),
      S_AXI_wready => xbar_to_m03_couplers_WREADY,
      S_AXI_wvalid => xbar_to_m03_couplers_WVALID(3)
    );
m04_couplers: entity work.m04_couplers_imp_1VLATGZ
     port map (
      M_ACLK => ps8_0_axi_periph_ACLK_net,
      M_ARESETN => ps8_0_axi_periph_ARESETN_net,
      M_AXI_araddr(39 downto 0) => m04_couplers_to_ps8_0_axi_periph_ARADDR(39 downto 0),
      M_AXI_arready => m04_couplers_to_ps8_0_axi_periph_ARREADY,
      M_AXI_arvalid => m04_couplers_to_ps8_0_axi_periph_ARVALID,
      M_AXI_awaddr(39 downto 0) => m04_couplers_to_ps8_0_axi_periph_AWADDR(39 downto 0),
      M_AXI_awready => m04_couplers_to_ps8_0_axi_periph_AWREADY,
      M_AXI_awvalid => m04_couplers_to_ps8_0_axi_periph_AWVALID,
      M_AXI_bready => m04_couplers_to_ps8_0_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => m04_couplers_to_ps8_0_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => m04_couplers_to_ps8_0_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => m04_couplers_to_ps8_0_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => m04_couplers_to_ps8_0_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => m04_couplers_to_ps8_0_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => m04_couplers_to_ps8_0_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => m04_couplers_to_ps8_0_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => m04_couplers_to_ps8_0_axi_periph_WREADY,
      M_AXI_wvalid => m04_couplers_to_ps8_0_axi_periph_WVALID,
      S_ACLK => ps8_0_axi_periph_ACLK_net,
      S_ARESETN => ps8_0_axi_periph_ARESETN_net,
      S_AXI_araddr(39 downto 0) => xbar_to_m04_couplers_ARADDR(199 downto 160),
      S_AXI_arready => xbar_to_m04_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m04_couplers_ARVALID(4),
      S_AXI_awaddr(39 downto 0) => xbar_to_m04_couplers_AWADDR(199 downto 160),
      S_AXI_awready => xbar_to_m04_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m04_couplers_AWVALID(4),
      S_AXI_bready => xbar_to_m04_couplers_BREADY(4),
      S_AXI_bresp(1 downto 0) => xbar_to_m04_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m04_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m04_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m04_couplers_RREADY(4),
      S_AXI_rresp(1 downto 0) => xbar_to_m04_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m04_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m04_couplers_WDATA(159 downto 128),
      S_AXI_wready => xbar_to_m04_couplers_WREADY,
      S_AXI_wvalid => xbar_to_m04_couplers_WVALID(4)
    );
s00_couplers: entity work.s00_couplers_imp_AHP87
     port map (
      M_ACLK => ps8_0_axi_periph_ACLK_net,
      M_ARESETN => ps8_0_axi_periph_ARESETN_net,
      M_AXI_araddr(39 downto 0) => s00_couplers_to_xbar_ARADDR(39 downto 0),
      M_AXI_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arready => s00_couplers_to_xbar_ARREADY(0),
      M_AXI_arvalid => s00_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(39 downto 0) => s00_couplers_to_xbar_AWADDR(39 downto 0),
      M_AXI_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awready => s00_couplers_to_xbar_AWREADY(0),
      M_AXI_awvalid => s00_couplers_to_xbar_AWVALID,
      M_AXI_bready => s00_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      M_AXI_bvalid => s00_couplers_to_xbar_BVALID(0),
      M_AXI_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      M_AXI_rready => s00_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      M_AXI_rvalid => s00_couplers_to_xbar_RVALID(0),
      M_AXI_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wready => s00_couplers_to_xbar_WREADY(0),
      M_AXI_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s00_couplers_to_xbar_WVALID,
      S_ACLK => ps8_0_axi_periph_ACLK_net,
      S_ARESETN => ps8_0_axi_periph_ARESETN_net,
      S_AXI_araddr(39 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARADDR(39 downto 0),
      S_AXI_arburst(1 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARBURST(1 downto 0),
      S_AXI_arcache(3 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARCACHE(3 downto 0),
      S_AXI_arid(15 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARID(15 downto 0),
      S_AXI_arlen(7 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARLEN(7 downto 0),
      S_AXI_arlock(0) => ps8_0_axi_periph_to_s00_couplers_ARLOCK(0),
      S_AXI_arprot(2 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARPROT(2 downto 0),
      S_AXI_arqos(3 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARQOS(3 downto 0),
      S_AXI_arready => ps8_0_axi_periph_to_s00_couplers_ARREADY,
      S_AXI_arsize(2 downto 0) => ps8_0_axi_periph_to_s00_couplers_ARSIZE(2 downto 0),
      S_AXI_arvalid => ps8_0_axi_periph_to_s00_couplers_ARVALID,
      S_AXI_awaddr(39 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWADDR(39 downto 0),
      S_AXI_awburst(1 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWBURST(1 downto 0),
      S_AXI_awcache(3 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWCACHE(3 downto 0),
      S_AXI_awid(15 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWID(15 downto 0),
      S_AXI_awlen(7 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWLEN(7 downto 0),
      S_AXI_awlock(0) => ps8_0_axi_periph_to_s00_couplers_AWLOCK(0),
      S_AXI_awprot(2 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWPROT(2 downto 0),
      S_AXI_awqos(3 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWQOS(3 downto 0),
      S_AXI_awready => ps8_0_axi_periph_to_s00_couplers_AWREADY,
      S_AXI_awsize(2 downto 0) => ps8_0_axi_periph_to_s00_couplers_AWSIZE(2 downto 0),
      S_AXI_awvalid => ps8_0_axi_periph_to_s00_couplers_AWVALID,
      S_AXI_bid(15 downto 0) => ps8_0_axi_periph_to_s00_couplers_BID(15 downto 0),
      S_AXI_bready => ps8_0_axi_periph_to_s00_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => ps8_0_axi_periph_to_s00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => ps8_0_axi_periph_to_s00_couplers_BVALID,
      S_AXI_rdata(127 downto 0) => ps8_0_axi_periph_to_s00_couplers_RDATA(127 downto 0),
      S_AXI_rid(15 downto 0) => ps8_0_axi_periph_to_s00_couplers_RID(15 downto 0),
      S_AXI_rlast => ps8_0_axi_periph_to_s00_couplers_RLAST,
      S_AXI_rready => ps8_0_axi_periph_to_s00_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => ps8_0_axi_periph_to_s00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => ps8_0_axi_periph_to_s00_couplers_RVALID,
      S_AXI_wdata(127 downto 0) => ps8_0_axi_periph_to_s00_couplers_WDATA(127 downto 0),
      S_AXI_wlast => ps8_0_axi_periph_to_s00_couplers_WLAST,
      S_AXI_wready => ps8_0_axi_periph_to_s00_couplers_WREADY,
      S_AXI_wstrb(15 downto 0) => ps8_0_axi_periph_to_s00_couplers_WSTRB(15 downto 0),
      S_AXI_wvalid => ps8_0_axi_periph_to_s00_couplers_WVALID
    );
s01_couplers: entity work.s01_couplers_imp_1U4ZV9Y
     port map (
      M_ACLK => ps8_0_axi_periph_ACLK_net,
      M_ARESETN => ps8_0_axi_periph_ARESETN_net,
      M_AXI_araddr(39 downto 0) => s01_couplers_to_xbar_ARADDR(39 downto 0),
      M_AXI_arprot(2 downto 0) => s01_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arready => s01_couplers_to_xbar_ARREADY(1),
      M_AXI_arvalid => s01_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(39 downto 0) => s01_couplers_to_xbar_AWADDR(39 downto 0),
      M_AXI_awprot(2 downto 0) => s01_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awready => s01_couplers_to_xbar_AWREADY(1),
      M_AXI_awvalid => s01_couplers_to_xbar_AWVALID,
      M_AXI_bready => s01_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s01_couplers_to_xbar_BRESP(3 downto 2),
      M_AXI_bvalid => s01_couplers_to_xbar_BVALID(1),
      M_AXI_rdata(31 downto 0) => s01_couplers_to_xbar_RDATA(63 downto 32),
      M_AXI_rready => s01_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s01_couplers_to_xbar_RRESP(3 downto 2),
      M_AXI_rvalid => s01_couplers_to_xbar_RVALID(1),
      M_AXI_wdata(31 downto 0) => s01_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wready => s01_couplers_to_xbar_WREADY(1),
      M_AXI_wstrb(3 downto 0) => s01_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s01_couplers_to_xbar_WVALID,
      S_ACLK => ps8_0_axi_periph_ACLK_net,
      S_ARESETN => ps8_0_axi_periph_ARESETN_net,
      S_AXI_araddr(39 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARADDR(39 downto 0),
      S_AXI_arburst(1 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARBURST(1 downto 0),
      S_AXI_arcache(3 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARCACHE(3 downto 0),
      S_AXI_arid(15 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARID(15 downto 0),
      S_AXI_arlen(7 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARLEN(7 downto 0),
      S_AXI_arlock(0) => ps8_0_axi_periph_to_s01_couplers_ARLOCK(0),
      S_AXI_arprot(2 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARPROT(2 downto 0),
      S_AXI_arqos(3 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARQOS(3 downto 0),
      S_AXI_arready => ps8_0_axi_periph_to_s01_couplers_ARREADY,
      S_AXI_arsize(2 downto 0) => ps8_0_axi_periph_to_s01_couplers_ARSIZE(2 downto 0),
      S_AXI_arvalid => ps8_0_axi_periph_to_s01_couplers_ARVALID,
      S_AXI_awaddr(39 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWADDR(39 downto 0),
      S_AXI_awburst(1 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWBURST(1 downto 0),
      S_AXI_awcache(3 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWCACHE(3 downto 0),
      S_AXI_awid(15 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWID(15 downto 0),
      S_AXI_awlen(7 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWLEN(7 downto 0),
      S_AXI_awlock(0) => ps8_0_axi_periph_to_s01_couplers_AWLOCK(0),
      S_AXI_awprot(2 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWPROT(2 downto 0),
      S_AXI_awqos(3 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWQOS(3 downto 0),
      S_AXI_awready => ps8_0_axi_periph_to_s01_couplers_AWREADY,
      S_AXI_awsize(2 downto 0) => ps8_0_axi_periph_to_s01_couplers_AWSIZE(2 downto 0),
      S_AXI_awvalid => ps8_0_axi_periph_to_s01_couplers_AWVALID,
      S_AXI_bid(15 downto 0) => ps8_0_axi_periph_to_s01_couplers_BID(15 downto 0),
      S_AXI_bready => ps8_0_axi_periph_to_s01_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => ps8_0_axi_periph_to_s01_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => ps8_0_axi_periph_to_s01_couplers_BVALID,
      S_AXI_rdata(127 downto 0) => ps8_0_axi_periph_to_s01_couplers_RDATA(127 downto 0),
      S_AXI_rid(15 downto 0) => ps8_0_axi_periph_to_s01_couplers_RID(15 downto 0),
      S_AXI_rlast => ps8_0_axi_periph_to_s01_couplers_RLAST,
      S_AXI_rready => ps8_0_axi_periph_to_s01_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => ps8_0_axi_periph_to_s01_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => ps8_0_axi_periph_to_s01_couplers_RVALID,
      S_AXI_wdata(127 downto 0) => ps8_0_axi_periph_to_s01_couplers_WDATA(127 downto 0),
      S_AXI_wlast => ps8_0_axi_periph_to_s01_couplers_WLAST,
      S_AXI_wready => ps8_0_axi_periph_to_s01_couplers_WREADY,
      S_AXI_wstrb(15 downto 0) => ps8_0_axi_periph_to_s01_couplers_WSTRB(15 downto 0),
      S_AXI_wvalid => ps8_0_axi_periph_to_s01_couplers_WVALID
    );
xbar: component memthing_xbar_0
     port map (
      aclk => ps8_0_axi_periph_ACLK_net,
      aresetn => ps8_0_axi_periph_ARESETN_net,
      m_axi_araddr(199 downto 160) => xbar_to_m04_couplers_ARADDR(199 downto 160),
      m_axi_araddr(159 downto 120) => xbar_to_m03_couplers_ARADDR(159 downto 120),
      m_axi_araddr(119 downto 80) => xbar_to_m02_couplers_ARADDR(119 downto 80),
      m_axi_araddr(79 downto 40) => xbar_to_m01_couplers_ARADDR(79 downto 40),
      m_axi_araddr(39 downto 0) => xbar_to_m00_couplers_ARADDR(39 downto 0),
      m_axi_arprot(14 downto 0) => NLW_xbar_m_axi_arprot_UNCONNECTED(14 downto 0),
      m_axi_arready(4) => xbar_to_m04_couplers_ARREADY,
      m_axi_arready(3) => xbar_to_m03_couplers_ARREADY,
      m_axi_arready(2) => xbar_to_m02_couplers_ARREADY,
      m_axi_arready(1) => xbar_to_m01_couplers_ARREADY,
      m_axi_arready(0) => xbar_to_m00_couplers_ARREADY(0),
      m_axi_arvalid(4) => xbar_to_m04_couplers_ARVALID(4),
      m_axi_arvalid(3) => xbar_to_m03_couplers_ARVALID(3),
      m_axi_arvalid(2) => xbar_to_m02_couplers_ARVALID(2),
      m_axi_arvalid(1) => xbar_to_m01_couplers_ARVALID(1),
      m_axi_arvalid(0) => xbar_to_m00_couplers_ARVALID(0),
      m_axi_awaddr(199 downto 160) => xbar_to_m04_couplers_AWADDR(199 downto 160),
      m_axi_awaddr(159 downto 120) => xbar_to_m03_couplers_AWADDR(159 downto 120),
      m_axi_awaddr(119 downto 80) => xbar_to_m02_couplers_AWADDR(119 downto 80),
      m_axi_awaddr(79 downto 40) => xbar_to_m01_couplers_AWADDR(79 downto 40),
      m_axi_awaddr(39 downto 0) => xbar_to_m00_couplers_AWADDR(39 downto 0),
      m_axi_awprot(14 downto 0) => NLW_xbar_m_axi_awprot_UNCONNECTED(14 downto 0),
      m_axi_awready(4) => xbar_to_m04_couplers_AWREADY,
      m_axi_awready(3) => xbar_to_m03_couplers_AWREADY,
      m_axi_awready(2) => xbar_to_m02_couplers_AWREADY,
      m_axi_awready(1) => xbar_to_m01_couplers_AWREADY,
      m_axi_awready(0) => xbar_to_m00_couplers_AWREADY(0),
      m_axi_awvalid(4) => xbar_to_m04_couplers_AWVALID(4),
      m_axi_awvalid(3) => xbar_to_m03_couplers_AWVALID(3),
      m_axi_awvalid(2) => xbar_to_m02_couplers_AWVALID(2),
      m_axi_awvalid(1) => xbar_to_m01_couplers_AWVALID(1),
      m_axi_awvalid(0) => xbar_to_m00_couplers_AWVALID(0),
      m_axi_bready(4) => xbar_to_m04_couplers_BREADY(4),
      m_axi_bready(3) => xbar_to_m03_couplers_BREADY(3),
      m_axi_bready(2) => xbar_to_m02_couplers_BREADY(2),
      m_axi_bready(1) => xbar_to_m01_couplers_BREADY(1),
      m_axi_bready(0) => xbar_to_m00_couplers_BREADY(0),
      m_axi_bresp(9 downto 8) => xbar_to_m04_couplers_BRESP(1 downto 0),
      m_axi_bresp(7 downto 6) => xbar_to_m03_couplers_BRESP(1 downto 0),
      m_axi_bresp(5 downto 4) => xbar_to_m02_couplers_BRESP(1 downto 0),
      m_axi_bresp(3 downto 2) => xbar_to_m01_couplers_BRESP(1 downto 0),
      m_axi_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      m_axi_bvalid(4) => xbar_to_m04_couplers_BVALID,
      m_axi_bvalid(3) => xbar_to_m03_couplers_BVALID,
      m_axi_bvalid(2) => xbar_to_m02_couplers_BVALID,
      m_axi_bvalid(1) => xbar_to_m01_couplers_BVALID,
      m_axi_bvalid(0) => xbar_to_m00_couplers_BVALID(0),
      m_axi_rdata(159 downto 128) => xbar_to_m04_couplers_RDATA(31 downto 0),
      m_axi_rdata(127 downto 96) => xbar_to_m03_couplers_RDATA(31 downto 0),
      m_axi_rdata(95 downto 64) => xbar_to_m02_couplers_RDATA(31 downto 0),
      m_axi_rdata(63 downto 32) => xbar_to_m01_couplers_RDATA(31 downto 0),
      m_axi_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      m_axi_rready(4) => xbar_to_m04_couplers_RREADY(4),
      m_axi_rready(3) => xbar_to_m03_couplers_RREADY(3),
      m_axi_rready(2) => xbar_to_m02_couplers_RREADY(2),
      m_axi_rready(1) => xbar_to_m01_couplers_RREADY(1),
      m_axi_rready(0) => xbar_to_m00_couplers_RREADY(0),
      m_axi_rresp(9 downto 8) => xbar_to_m04_couplers_RRESP(1 downto 0),
      m_axi_rresp(7 downto 6) => xbar_to_m03_couplers_RRESP(1 downto 0),
      m_axi_rresp(5 downto 4) => xbar_to_m02_couplers_RRESP(1 downto 0),
      m_axi_rresp(3 downto 2) => xbar_to_m01_couplers_RRESP(1 downto 0),
      m_axi_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      m_axi_rvalid(4) => xbar_to_m04_couplers_RVALID,
      m_axi_rvalid(3) => xbar_to_m03_couplers_RVALID,
      m_axi_rvalid(2) => xbar_to_m02_couplers_RVALID,
      m_axi_rvalid(1) => xbar_to_m01_couplers_RVALID,
      m_axi_rvalid(0) => xbar_to_m00_couplers_RVALID(0),
      m_axi_wdata(159 downto 128) => xbar_to_m04_couplers_WDATA(159 downto 128),
      m_axi_wdata(127 downto 96) => xbar_to_m03_couplers_WDATA(127 downto 96),
      m_axi_wdata(95 downto 64) => xbar_to_m02_couplers_WDATA(95 downto 64),
      m_axi_wdata(63 downto 32) => xbar_to_m01_couplers_WDATA(63 downto 32),
      m_axi_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      m_axi_wready(4) => xbar_to_m04_couplers_WREADY,
      m_axi_wready(3) => xbar_to_m03_couplers_WREADY,
      m_axi_wready(2) => xbar_to_m02_couplers_WREADY,
      m_axi_wready(1) => xbar_to_m01_couplers_WREADY,
      m_axi_wready(0) => xbar_to_m00_couplers_WREADY(0),
      m_axi_wstrb(19 downto 0) => NLW_xbar_m_axi_wstrb_UNCONNECTED(19 downto 0),
      m_axi_wvalid(4) => xbar_to_m04_couplers_WVALID(4),
      m_axi_wvalid(3) => xbar_to_m03_couplers_WVALID(3),
      m_axi_wvalid(2) => xbar_to_m02_couplers_WVALID(2),
      m_axi_wvalid(1) => xbar_to_m01_couplers_WVALID(1),
      m_axi_wvalid(0) => xbar_to_m00_couplers_WVALID(0),
      s_axi_araddr(79 downto 40) => s01_couplers_to_xbar_ARADDR(39 downto 0),
      s_axi_araddr(39 downto 0) => s00_couplers_to_xbar_ARADDR(39 downto 0),
      s_axi_arprot(5 downto 3) => s01_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arready(1) => s01_couplers_to_xbar_ARREADY(1),
      s_axi_arready(0) => s00_couplers_to_xbar_ARREADY(0),
      s_axi_arvalid(1) => s01_couplers_to_xbar_ARVALID,
      s_axi_arvalid(0) => s00_couplers_to_xbar_ARVALID,
      s_axi_awaddr(79 downto 40) => s01_couplers_to_xbar_AWADDR(39 downto 0),
      s_axi_awaddr(39 downto 0) => s00_couplers_to_xbar_AWADDR(39 downto 0),
      s_axi_awprot(5 downto 3) => s01_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awready(1) => s01_couplers_to_xbar_AWREADY(1),
      s_axi_awready(0) => s00_couplers_to_xbar_AWREADY(0),
      s_axi_awvalid(1) => s01_couplers_to_xbar_AWVALID,
      s_axi_awvalid(0) => s00_couplers_to_xbar_AWVALID,
      s_axi_bready(1) => s01_couplers_to_xbar_BREADY,
      s_axi_bready(0) => s00_couplers_to_xbar_BREADY,
      s_axi_bresp(3 downto 2) => s01_couplers_to_xbar_BRESP(3 downto 2),
      s_axi_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      s_axi_bvalid(1) => s01_couplers_to_xbar_BVALID(1),
      s_axi_bvalid(0) => s00_couplers_to_xbar_BVALID(0),
      s_axi_rdata(63 downto 32) => s01_couplers_to_xbar_RDATA(63 downto 32),
      s_axi_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      s_axi_rready(1) => s01_couplers_to_xbar_RREADY,
      s_axi_rready(0) => s00_couplers_to_xbar_RREADY,
      s_axi_rresp(3 downto 2) => s01_couplers_to_xbar_RRESP(3 downto 2),
      s_axi_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      s_axi_rvalid(1) => s01_couplers_to_xbar_RVALID(1),
      s_axi_rvalid(0) => s00_couplers_to_xbar_RVALID(0),
      s_axi_wdata(63 downto 32) => s01_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wready(1) => s01_couplers_to_xbar_WREADY(1),
      s_axi_wready(0) => s00_couplers_to_xbar_WREADY(0),
      s_axi_wstrb(7 downto 4) => s01_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wvalid(1) => s01_couplers_to_xbar_WVALID,
      s_axi_wvalid(0) => s00_couplers_to_xbar_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity memthing is
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of memthing : entity is "memthing,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=memthing,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=28,numReposBlks=20,numNonXlnxBlks=0,numHierBlks=8,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=21,da_board_cnt=1,da_clkrst_cnt=4,da_zynq_ultra_ps_e_cnt=1,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of memthing : entity is "memthing.hwdef";
end memthing;

architecture STRUCTURE of memthing is
  component memthing_zynq_ultra_ps_e_0_0 is
  port (
    maxihpm0_fpd_aclk : in STD_LOGIC;
    maxigp0_awid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp0_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    maxigp0_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    maxigp0_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp0_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp0_awlock : out STD_LOGIC;
    maxigp0_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    maxigp0_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp0_awvalid : out STD_LOGIC;
    maxigp0_awuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp0_awready : in STD_LOGIC;
    maxigp0_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    maxigp0_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp0_wlast : out STD_LOGIC;
    maxigp0_wvalid : out STD_LOGIC;
    maxigp0_wready : in STD_LOGIC;
    maxigp0_bid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp0_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp0_bvalid : in STD_LOGIC;
    maxigp0_bready : out STD_LOGIC;
    maxigp0_arid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp0_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    maxigp0_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    maxigp0_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp0_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp0_arlock : out STD_LOGIC;
    maxigp0_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    maxigp0_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp0_arvalid : out STD_LOGIC;
    maxigp0_aruser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp0_arready : in STD_LOGIC;
    maxigp0_rid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp0_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    maxigp0_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp0_rlast : in STD_LOGIC;
    maxigp0_rvalid : in STD_LOGIC;
    maxigp0_rready : out STD_LOGIC;
    maxigp0_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    maxigp0_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    maxihpm1_fpd_aclk : in STD_LOGIC;
    maxigp1_awid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp1_awaddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    maxigp1_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    maxigp1_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp1_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp1_awlock : out STD_LOGIC;
    maxigp1_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    maxigp1_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp1_awvalid : out STD_LOGIC;
    maxigp1_awuser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp1_awready : in STD_LOGIC;
    maxigp1_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    maxigp1_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp1_wlast : out STD_LOGIC;
    maxigp1_wvalid : out STD_LOGIC;
    maxigp1_wready : in STD_LOGIC;
    maxigp1_bid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp1_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp1_bvalid : in STD_LOGIC;
    maxigp1_bready : out STD_LOGIC;
    maxigp1_arid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp1_araddr : out STD_LOGIC_VECTOR ( 39 downto 0 );
    maxigp1_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    maxigp1_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp1_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp1_arlock : out STD_LOGIC;
    maxigp1_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    maxigp1_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    maxigp1_arvalid : out STD_LOGIC;
    maxigp1_aruser : out STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp1_arready : in STD_LOGIC;
    maxigp1_rid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    maxigp1_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    maxigp1_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    maxigp1_rlast : in STD_LOGIC;
    maxigp1_rvalid : in STD_LOGIC;
    maxigp1_rready : out STD_LOGIC;
    maxigp1_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    maxigp1_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    saxihpc0_fpd_aclk : in STD_LOGIC;
    saxigp0_aruser : in STD_LOGIC;
    saxigp0_awuser : in STD_LOGIC;
    saxigp0_awid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp0_awaddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp0_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp0_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp0_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp0_awlock : in STD_LOGIC;
    saxigp0_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp0_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp0_awvalid : in STD_LOGIC;
    saxigp0_awready : out STD_LOGIC;
    saxigp0_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp0_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    saxigp0_wlast : in STD_LOGIC;
    saxigp0_wvalid : in STD_LOGIC;
    saxigp0_wready : out STD_LOGIC;
    saxigp0_bid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp0_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp0_bvalid : out STD_LOGIC;
    saxigp0_bready : in STD_LOGIC;
    saxigp0_arid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp0_araddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp0_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp0_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp0_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp0_arlock : in STD_LOGIC;
    saxigp0_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp0_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp0_arvalid : in STD_LOGIC;
    saxigp0_arready : out STD_LOGIC;
    saxigp0_rid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp0_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp0_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp0_rlast : out STD_LOGIC;
    saxigp0_rvalid : out STD_LOGIC;
    saxigp0_rready : in STD_LOGIC;
    saxigp0_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp0_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxihp0_fpd_aclk : in STD_LOGIC;
    saxigp2_aruser : in STD_LOGIC;
    saxigp2_awuser : in STD_LOGIC;
    saxigp2_awid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp2_awaddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp2_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp2_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp2_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp2_awlock : in STD_LOGIC;
    saxigp2_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp2_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp2_awvalid : in STD_LOGIC;
    saxigp2_awready : out STD_LOGIC;
    saxigp2_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp2_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    saxigp2_wlast : in STD_LOGIC;
    saxigp2_wvalid : in STD_LOGIC;
    saxigp2_wready : out STD_LOGIC;
    saxigp2_bid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp2_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp2_bvalid : out STD_LOGIC;
    saxigp2_bready : in STD_LOGIC;
    saxigp2_arid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp2_araddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp2_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp2_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp2_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp2_arlock : in STD_LOGIC;
    saxigp2_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp2_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp2_arvalid : in STD_LOGIC;
    saxigp2_arready : out STD_LOGIC;
    saxigp2_rid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp2_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp2_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp2_rlast : out STD_LOGIC;
    saxigp2_rvalid : out STD_LOGIC;
    saxigp2_rready : in STD_LOGIC;
    saxigp2_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp2_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxihp1_fpd_aclk : in STD_LOGIC;
    saxigp3_aruser : in STD_LOGIC;
    saxigp3_awuser : in STD_LOGIC;
    saxigp3_awid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp3_awaddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp3_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp3_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp3_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp3_awlock : in STD_LOGIC;
    saxigp3_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp3_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp3_awvalid : in STD_LOGIC;
    saxigp3_awready : out STD_LOGIC;
    saxigp3_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp3_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    saxigp3_wlast : in STD_LOGIC;
    saxigp3_wvalid : in STD_LOGIC;
    saxigp3_wready : out STD_LOGIC;
    saxigp3_bid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp3_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp3_bvalid : out STD_LOGIC;
    saxigp3_bready : in STD_LOGIC;
    saxigp3_arid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp3_araddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp3_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp3_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp3_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp3_arlock : in STD_LOGIC;
    saxigp3_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp3_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp3_arvalid : in STD_LOGIC;
    saxigp3_arready : out STD_LOGIC;
    saxigp3_rid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp3_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp3_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp3_rlast : out STD_LOGIC;
    saxigp3_rvalid : out STD_LOGIC;
    saxigp3_rready : in STD_LOGIC;
    saxigp3_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp3_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxihp2_fpd_aclk : in STD_LOGIC;
    saxigp4_aruser : in STD_LOGIC;
    saxigp4_awuser : in STD_LOGIC;
    saxigp4_awid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp4_awaddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp4_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp4_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp4_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp4_awlock : in STD_LOGIC;
    saxigp4_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp4_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp4_awvalid : in STD_LOGIC;
    saxigp4_awready : out STD_LOGIC;
    saxigp4_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp4_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    saxigp4_wlast : in STD_LOGIC;
    saxigp4_wvalid : in STD_LOGIC;
    saxigp4_wready : out STD_LOGIC;
    saxigp4_bid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp4_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp4_bvalid : out STD_LOGIC;
    saxigp4_bready : in STD_LOGIC;
    saxigp4_arid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp4_araddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp4_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp4_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp4_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp4_arlock : in STD_LOGIC;
    saxigp4_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp4_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp4_arvalid : in STD_LOGIC;
    saxigp4_arready : out STD_LOGIC;
    saxigp4_rid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp4_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp4_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp4_rlast : out STD_LOGIC;
    saxigp4_rvalid : out STD_LOGIC;
    saxigp4_rready : in STD_LOGIC;
    saxigp4_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp4_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxihp3_fpd_aclk : in STD_LOGIC;
    saxigp5_aruser : in STD_LOGIC;
    saxigp5_awuser : in STD_LOGIC;
    saxigp5_awid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp5_awaddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp5_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp5_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp5_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp5_awlock : in STD_LOGIC;
    saxigp5_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp5_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp5_awvalid : in STD_LOGIC;
    saxigp5_awready : out STD_LOGIC;
    saxigp5_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp5_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    saxigp5_wlast : in STD_LOGIC;
    saxigp5_wvalid : in STD_LOGIC;
    saxigp5_wready : out STD_LOGIC;
    saxigp5_bid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp5_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp5_bvalid : out STD_LOGIC;
    saxigp5_bready : in STD_LOGIC;
    saxigp5_arid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp5_araddr : in STD_LOGIC_VECTOR ( 48 downto 0 );
    saxigp5_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    saxigp5_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp5_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp5_arlock : in STD_LOGIC;
    saxigp5_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp5_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    saxigp5_arvalid : in STD_LOGIC;
    saxigp5_arready : out STD_LOGIC;
    saxigp5_rid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    saxigp5_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    saxigp5_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    saxigp5_rlast : out STD_LOGIC;
    saxigp5_rvalid : out STD_LOGIC;
    saxigp5_rready : in STD_LOGIC;
    saxigp5_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    saxigp5_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pl_ps_irq0 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    pl_resetn0 : out STD_LOGIC;
    pl_clk0 : out STD_LOGIC
  );
  end component memthing_zynq_ultra_ps_e_0_0;
  component memthing_smartconnect_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S01_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awvalid : in STD_LOGIC;
    S01_AXI_awready : out STD_LOGIC;
    S01_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_wlast : in STD_LOGIC;
    S01_AXI_wvalid : in STD_LOGIC;
    S01_AXI_wready : out STD_LOGIC;
    S01_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_bvalid : out STD_LOGIC;
    S01_AXI_bready : in STD_LOGIC;
    S01_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arvalid : in STD_LOGIC;
    S01_AXI_arready : out STD_LOGIC;
    S01_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_rlast : out STD_LOGIC;
    S01_AXI_rvalid : out STD_LOGIC;
    S01_AXI_rready : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M00_AXI_wlast : out STD_LOGIC;
    M00_AXI_wvalid : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rlast : in STD_LOGIC;
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC
  );
  end component memthing_smartconnect_0_0;
  component memthing_proc_sys_reset_0_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component memthing_proc_sys_reset_0_0;
  component memthing_axi_dma_0_0 is
  port (
    s_axi_lite_aclk : in STD_LOGIC;
    m_axi_sg_aclk : in STD_LOGIC;
    m_axi_mm2s_aclk : in STD_LOGIC;
    axi_resetn : in STD_LOGIC;
    s_axi_lite_awvalid : in STD_LOGIC;
    s_axi_lite_awready : out STD_LOGIC;
    s_axi_lite_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_wvalid : in STD_LOGIC;
    s_axi_lite_wready : out STD_LOGIC;
    s_axi_lite_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_lite_bvalid : out STD_LOGIC;
    s_axi_lite_bready : in STD_LOGIC;
    s_axi_lite_arvalid : in STD_LOGIC;
    s_axi_lite_arready : out STD_LOGIC;
    s_axi_lite_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_rvalid : out STD_LOGIC;
    s_axi_lite_rready : in STD_LOGIC;
    s_axi_lite_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_awvalid : out STD_LOGIC;
    m_axi_sg_awready : in STD_LOGIC;
    m_axi_sg_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_wlast : out STD_LOGIC;
    m_axi_sg_wvalid : out STD_LOGIC;
    m_axi_sg_wready : in STD_LOGIC;
    m_axi_sg_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_bvalid : in STD_LOGIC;
    m_axi_sg_bready : out STD_LOGIC;
    m_axi_sg_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_arvalid : out STD_LOGIC;
    m_axi_sg_arready : in STD_LOGIC;
    m_axi_sg_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_rlast : in STD_LOGIC;
    m_axi_sg_rvalid : in STD_LOGIC;
    m_axi_sg_rready : out STD_LOGIC;
    m_axi_mm2s_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_mm2s_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_arvalid : out STD_LOGIC;
    m_axi_mm2s_arready : in STD_LOGIC;
    m_axi_mm2s_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_mm2s_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_rlast : in STD_LOGIC;
    m_axi_mm2s_rvalid : in STD_LOGIC;
    m_axi_mm2s_rready : out STD_LOGIC;
    mm2s_prmry_reset_out_n : out STD_LOGIC;
    m_axis_mm2s_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_mm2s_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_mm2s_tvalid : out STD_LOGIC;
    m_axis_mm2s_tready : in STD_LOGIC;
    m_axis_mm2s_tlast : out STD_LOGIC;
    mm2s_introut : out STD_LOGIC
  );
  end component memthing_axi_dma_0_0;
  component memthing_xlconstant_0_1 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component memthing_xlconstant_0_1;
  component memthing_xlconcat_0_0 is
  port (
    In0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    In1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    In2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    In3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    In4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    In5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    dout : out STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  end component memthing_xlconcat_0_0;
  component memthing_axi_dma_0_4 is
  port (
    s_axi_lite_aclk : in STD_LOGIC;
    m_axi_sg_aclk : in STD_LOGIC;
    m_axi_mm2s_aclk : in STD_LOGIC;
    axi_resetn : in STD_LOGIC;
    s_axi_lite_awvalid : in STD_LOGIC;
    s_axi_lite_awready : out STD_LOGIC;
    s_axi_lite_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_wvalid : in STD_LOGIC;
    s_axi_lite_wready : out STD_LOGIC;
    s_axi_lite_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_lite_bvalid : out STD_LOGIC;
    s_axi_lite_bready : in STD_LOGIC;
    s_axi_lite_arvalid : in STD_LOGIC;
    s_axi_lite_arready : out STD_LOGIC;
    s_axi_lite_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_rvalid : out STD_LOGIC;
    s_axi_lite_rready : in STD_LOGIC;
    s_axi_lite_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_awvalid : out STD_LOGIC;
    m_axi_sg_awready : in STD_LOGIC;
    m_axi_sg_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_wlast : out STD_LOGIC;
    m_axi_sg_wvalid : out STD_LOGIC;
    m_axi_sg_wready : in STD_LOGIC;
    m_axi_sg_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_bvalid : in STD_LOGIC;
    m_axi_sg_bready : out STD_LOGIC;
    m_axi_sg_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_arvalid : out STD_LOGIC;
    m_axi_sg_arready : in STD_LOGIC;
    m_axi_sg_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_rlast : in STD_LOGIC;
    m_axi_sg_rvalid : in STD_LOGIC;
    m_axi_sg_rready : out STD_LOGIC;
    m_axi_mm2s_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_mm2s_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_arvalid : out STD_LOGIC;
    m_axi_mm2s_arready : in STD_LOGIC;
    m_axi_mm2s_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_mm2s_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_rlast : in STD_LOGIC;
    m_axi_mm2s_rvalid : in STD_LOGIC;
    m_axi_mm2s_rready : out STD_LOGIC;
    mm2s_prmry_reset_out_n : out STD_LOGIC;
    m_axis_mm2s_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_mm2s_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_mm2s_tvalid : out STD_LOGIC;
    m_axis_mm2s_tready : in STD_LOGIC;
    m_axis_mm2s_tlast : out STD_LOGIC;
    mm2s_introut : out STD_LOGIC
  );
  end component memthing_axi_dma_0_4;
  component memthing_axi_dma_1_0 is
  port (
    s_axi_lite_aclk : in STD_LOGIC;
    m_axi_sg_aclk : in STD_LOGIC;
    m_axi_mm2s_aclk : in STD_LOGIC;
    axi_resetn : in STD_LOGIC;
    s_axi_lite_awvalid : in STD_LOGIC;
    s_axi_lite_awready : out STD_LOGIC;
    s_axi_lite_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_wvalid : in STD_LOGIC;
    s_axi_lite_wready : out STD_LOGIC;
    s_axi_lite_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_lite_bvalid : out STD_LOGIC;
    s_axi_lite_bready : in STD_LOGIC;
    s_axi_lite_arvalid : in STD_LOGIC;
    s_axi_lite_arready : out STD_LOGIC;
    s_axi_lite_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_rvalid : out STD_LOGIC;
    s_axi_lite_rready : in STD_LOGIC;
    s_axi_lite_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_awvalid : out STD_LOGIC;
    m_axi_sg_awready : in STD_LOGIC;
    m_axi_sg_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_wlast : out STD_LOGIC;
    m_axi_sg_wvalid : out STD_LOGIC;
    m_axi_sg_wready : in STD_LOGIC;
    m_axi_sg_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_bvalid : in STD_LOGIC;
    m_axi_sg_bready : out STD_LOGIC;
    m_axi_sg_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_arvalid : out STD_LOGIC;
    m_axi_sg_arready : in STD_LOGIC;
    m_axi_sg_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_rlast : in STD_LOGIC;
    m_axi_sg_rvalid : in STD_LOGIC;
    m_axi_sg_rready : out STD_LOGIC;
    m_axi_mm2s_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_mm2s_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_arvalid : out STD_LOGIC;
    m_axi_mm2s_arready : in STD_LOGIC;
    m_axi_mm2s_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_mm2s_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_rlast : in STD_LOGIC;
    m_axi_mm2s_rvalid : in STD_LOGIC;
    m_axi_mm2s_rready : out STD_LOGIC;
    mm2s_prmry_reset_out_n : out STD_LOGIC;
    m_axis_mm2s_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_mm2s_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_mm2s_tvalid : out STD_LOGIC;
    m_axis_mm2s_tready : in STD_LOGIC;
    m_axis_mm2s_tlast : out STD_LOGIC;
    mm2s_introut : out STD_LOGIC
  );
  end component memthing_axi_dma_1_0;
  component memthing_axi_dma_1_1 is
  port (
    s_axi_lite_aclk : in STD_LOGIC;
    m_axi_sg_aclk : in STD_LOGIC;
    m_axi_mm2s_aclk : in STD_LOGIC;
    axi_resetn : in STD_LOGIC;
    s_axi_lite_awvalid : in STD_LOGIC;
    s_axi_lite_awready : out STD_LOGIC;
    s_axi_lite_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_wvalid : in STD_LOGIC;
    s_axi_lite_wready : out STD_LOGIC;
    s_axi_lite_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_lite_bvalid : out STD_LOGIC;
    s_axi_lite_bready : in STD_LOGIC;
    s_axi_lite_arvalid : in STD_LOGIC;
    s_axi_lite_arready : out STD_LOGIC;
    s_axi_lite_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_rvalid : out STD_LOGIC;
    s_axi_lite_rready : in STD_LOGIC;
    s_axi_lite_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_awvalid : out STD_LOGIC;
    m_axi_sg_awready : in STD_LOGIC;
    m_axi_sg_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_wlast : out STD_LOGIC;
    m_axi_sg_wvalid : out STD_LOGIC;
    m_axi_sg_wready : in STD_LOGIC;
    m_axi_sg_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_bvalid : in STD_LOGIC;
    m_axi_sg_bready : out STD_LOGIC;
    m_axi_sg_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_arvalid : out STD_LOGIC;
    m_axi_sg_arready : in STD_LOGIC;
    m_axi_sg_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_rlast : in STD_LOGIC;
    m_axi_sg_rvalid : in STD_LOGIC;
    m_axi_sg_rready : out STD_LOGIC;
    m_axi_mm2s_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_mm2s_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_arvalid : out STD_LOGIC;
    m_axi_mm2s_arready : in STD_LOGIC;
    m_axi_mm2s_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_mm2s_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_rlast : in STD_LOGIC;
    m_axi_mm2s_rvalid : in STD_LOGIC;
    m_axi_mm2s_rready : out STD_LOGIC;
    mm2s_prmry_reset_out_n : out STD_LOGIC;
    m_axis_mm2s_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_mm2s_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_mm2s_tvalid : out STD_LOGIC;
    m_axis_mm2s_tready : in STD_LOGIC;
    m_axis_mm2s_tlast : out STD_LOGIC;
    mm2s_introut : out STD_LOGIC
  );
  end component memthing_axi_dma_1_1;
  component memthing_smartconnect_0_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S01_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awvalid : in STD_LOGIC;
    S01_AXI_awready : out STD_LOGIC;
    S01_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_wlast : in STD_LOGIC;
    S01_AXI_wvalid : in STD_LOGIC;
    S01_AXI_wready : out STD_LOGIC;
    S01_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_bvalid : out STD_LOGIC;
    S01_AXI_bready : in STD_LOGIC;
    S01_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arvalid : in STD_LOGIC;
    S01_AXI_arready : out STD_LOGIC;
    S01_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_rlast : out STD_LOGIC;
    S01_AXI_rvalid : out STD_LOGIC;
    S01_AXI_rready : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M00_AXI_wlast : out STD_LOGIC;
    M00_AXI_wvalid : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rlast : in STD_LOGIC;
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC
  );
  end component memthing_smartconnect_0_1;
  component memthing_smartconnect_0_2 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wlast : in STD_LOGIC;
    S00_AXI_wvalid : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S01_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arvalid : in STD_LOGIC;
    S01_AXI_arready : out STD_LOGIC;
    S01_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S01_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_rlast : out STD_LOGIC;
    S01_AXI_rvalid : out STD_LOGIC;
    S01_AXI_rready : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M00_AXI_wlast : out STD_LOGIC;
    M00_AXI_wvalid : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rlast : in STD_LOGIC;
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC
  );
  end component memthing_smartconnect_0_2;
  component memthing_smartconnect_2_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wlast : in STD_LOGIC;
    S00_AXI_wvalid : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S01_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arvalid : in STD_LOGIC;
    S01_AXI_arready : out STD_LOGIC;
    S01_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S01_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_rlast : out STD_LOGIC;
    S01_AXI_rvalid : out STD_LOGIC;
    S01_AXI_rready : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M00_AXI_wlast : out STD_LOGIC;
    M00_AXI_wvalid : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rlast : in STD_LOGIC;
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC
  );
  end component memthing_smartconnect_2_0;
  component memthing_axi_dma_4_1 is
  port (
    s_axi_lite_aclk : in STD_LOGIC;
    m_axi_sg_aclk : in STD_LOGIC;
    m_axi_mm2s_aclk : in STD_LOGIC;
    m_axi_s2mm_aclk : in STD_LOGIC;
    axi_resetn : in STD_LOGIC;
    s_axi_lite_awvalid : in STD_LOGIC;
    s_axi_lite_awready : out STD_LOGIC;
    s_axi_lite_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_wvalid : in STD_LOGIC;
    s_axi_lite_wready : out STD_LOGIC;
    s_axi_lite_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_lite_bvalid : out STD_LOGIC;
    s_axi_lite_bready : in STD_LOGIC;
    s_axi_lite_arvalid : in STD_LOGIC;
    s_axi_lite_arready : out STD_LOGIC;
    s_axi_lite_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_lite_rvalid : out STD_LOGIC;
    s_axi_lite_rready : in STD_LOGIC;
    s_axi_lite_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_awvalid : out STD_LOGIC;
    m_axi_sg_awready : in STD_LOGIC;
    m_axi_sg_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_wlast : out STD_LOGIC;
    m_axi_sg_wvalid : out STD_LOGIC;
    m_axi_sg_wready : in STD_LOGIC;
    m_axi_sg_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_bvalid : in STD_LOGIC;
    m_axi_sg_bready : out STD_LOGIC;
    m_axi_sg_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sg_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sg_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sg_arvalid : out STD_LOGIC;
    m_axi_sg_arready : in STD_LOGIC;
    m_axi_sg_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sg_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sg_rlast : in STD_LOGIC;
    m_axi_sg_rvalid : in STD_LOGIC;
    m_axi_sg_rready : out STD_LOGIC;
    m_axi_mm2s_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_mm2s_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_arvalid : out STD_LOGIC;
    m_axi_mm2s_arready : in STD_LOGIC;
    m_axi_mm2s_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_mm2s_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_rlast : in STD_LOGIC;
    m_axi_mm2s_rvalid : in STD_LOGIC;
    m_axi_mm2s_rready : out STD_LOGIC;
    mm2s_prmry_reset_out_n : out STD_LOGIC;
    m_axis_mm2s_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_mm2s_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_mm2s_tvalid : out STD_LOGIC;
    m_axis_mm2s_tready : in STD_LOGIC;
    m_axis_mm2s_tlast : out STD_LOGIC;
    mm2s_cntrl_reset_out_n : out STD_LOGIC;
    m_axis_mm2s_cntrl_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_mm2s_cntrl_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_mm2s_cntrl_tvalid : out STD_LOGIC;
    m_axis_mm2s_cntrl_tready : in STD_LOGIC;
    m_axis_mm2s_cntrl_tlast : out STD_LOGIC;
    m_axi_s2mm_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_s2mm_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_s2mm_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_s2mm_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_s2mm_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_s2mm_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_s2mm_awvalid : out STD_LOGIC;
    m_axi_s2mm_awready : in STD_LOGIC;
    m_axi_s2mm_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axi_s2mm_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axi_s2mm_wlast : out STD_LOGIC;
    m_axi_s2mm_wvalid : out STD_LOGIC;
    m_axi_s2mm_wready : in STD_LOGIC;
    m_axi_s2mm_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_s2mm_bvalid : in STD_LOGIC;
    m_axi_s2mm_bready : out STD_LOGIC;
    s2mm_prmry_reset_out_n : out STD_LOGIC;
    s_axis_s2mm_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_s2mm_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_s2mm_tvalid : in STD_LOGIC;
    s_axis_s2mm_tready : out STD_LOGIC;
    s_axis_s2mm_tlast : in STD_LOGIC;
    s2mm_sts_reset_out_n : out STD_LOGIC;
    s_axis_s2mm_sts_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_s2mm_sts_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_s2mm_sts_tvalid : in STD_LOGIC;
    s_axis_s2mm_sts_tready : out STD_LOGIC;
    s_axis_s2mm_sts_tlast : in STD_LOGIC;
    mm2s_introut : out STD_LOGIC;
    s2mm_introut : out STD_LOGIC
  );
  end component memthing_axi_dma_4_1;
  component memthing_smartconnect_0_3 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wlast : in STD_LOGIC;
    S00_AXI_wvalid : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S01_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arvalid : in STD_LOGIC;
    S01_AXI_arready : out STD_LOGIC;
    S01_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S01_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_rlast : out STD_LOGIC;
    S01_AXI_rvalid : out STD_LOGIC;
    S01_AXI_rready : in STD_LOGIC;
    S02_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S02_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S02_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S02_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S02_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S02_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S02_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S02_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S02_AXI_awvalid : in STD_LOGIC;
    S02_AXI_awready : out STD_LOGIC;
    S02_AXI_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S02_AXI_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S02_AXI_wlast : in STD_LOGIC;
    S02_AXI_wvalid : in STD_LOGIC;
    S02_AXI_wready : out STD_LOGIC;
    S02_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S02_AXI_bvalid : out STD_LOGIC;
    S02_AXI_bready : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M00_AXI_wlast : out STD_LOGIC;
    M00_AXI_wvalid : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 48 downto 0 );
    M00_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rlast : in STD_LOGIC;
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC
  );
  end component memthing_smartconnect_0_3;
  component memthing_lane_checker_1_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_w0_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_w0_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_w0_tlast : in STD_LOGIC;
    s_w0_tvalid : in STD_LOGIC;
    s_w0_tready : out STD_LOGIC;
    s_w1_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_w1_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_w1_tlast : in STD_LOGIC;
    s_w1_tvalid : in STD_LOGIC;
    s_w1_tready : out STD_LOGIC;
    s_w2_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_w2_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_w2_tlast : in STD_LOGIC;
    s_w2_tvalid : in STD_LOGIC;
    s_w2_tready : out STD_LOGIC;
    s_w3_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_w3_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_w3_tlast : in STD_LOGIC;
    s_w3_tvalid : in STD_LOGIC;
    s_w3_tready : out STD_LOGIC;
    s_act_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_act_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_act_tlast : in STD_LOGIC;
    s_act_tvalid : in STD_LOGIC;
    s_act_tready : out STD_LOGIC;
    m_res_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_res_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_res_tlast : out STD_LOGIC;
    m_res_tvalid : out STD_LOGIC;
    m_res_tready : in STD_LOGIC
  );
  end component memthing_lane_checker_1_0;
  signal axi_dma_0_M_AXIS_MM2S_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_0_M_AXIS_MM2S_TKEEP : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal axi_dma_0_M_AXIS_MM2S_TLAST : STD_LOGIC;
  signal axi_dma_0_M_AXIS_MM2S_TREADY : STD_LOGIC;
  signal axi_dma_0_M_AXIS_MM2S_TVALID : STD_LOGIC;
  signal axi_dma_0_M_AXI_MM2S_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_ARREADY : STD_LOGIC;
  signal axi_dma_0_M_AXI_MM2S_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_ARVALID : STD_LOGIC;
  signal axi_dma_0_M_AXI_MM2S_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_RLAST : STD_LOGIC;
  signal axi_dma_0_M_AXI_MM2S_RREADY : STD_LOGIC;
  signal axi_dma_0_M_AXI_MM2S_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_0_M_AXI_MM2S_RVALID : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_0_M_AXI_SG_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_0_M_AXI_SG_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_0_M_AXI_SG_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_0_M_AXI_SG_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_0_M_AXI_SG_ARREADY : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_0_M_AXI_SG_ARVALID : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_0_M_AXI_SG_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_0_M_AXI_SG_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_0_M_AXI_SG_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_0_M_AXI_SG_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_0_M_AXI_SG_AWREADY : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_0_M_AXI_SG_AWVALID : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_BREADY : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_0_M_AXI_SG_BVALID : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_0_M_AXI_SG_RLAST : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_RREADY : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_0_M_AXI_SG_RVALID : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_0_M_AXI_SG_WLAST : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_WREADY : STD_LOGIC;
  signal axi_dma_0_M_AXI_SG_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_0_M_AXI_SG_WVALID : STD_LOGIC;
  signal axi_dma_0_mm2s_introut : STD_LOGIC;
  signal axi_dma_1_M_AXIS_MM2S_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_1_M_AXIS_MM2S_TKEEP : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal axi_dma_1_M_AXIS_MM2S_TLAST : STD_LOGIC;
  signal axi_dma_1_M_AXIS_MM2S_TREADY : STD_LOGIC;
  signal axi_dma_1_M_AXIS_MM2S_TVALID : STD_LOGIC;
  signal axi_dma_1_M_AXI_MM2S_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_ARREADY : STD_LOGIC;
  signal axi_dma_1_M_AXI_MM2S_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_ARVALID : STD_LOGIC;
  signal axi_dma_1_M_AXI_MM2S_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_RLAST : STD_LOGIC;
  signal axi_dma_1_M_AXI_MM2S_RREADY : STD_LOGIC;
  signal axi_dma_1_M_AXI_MM2S_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_1_M_AXI_MM2S_RVALID : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_1_M_AXI_SG_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_1_M_AXI_SG_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_1_M_AXI_SG_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_1_M_AXI_SG_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_1_M_AXI_SG_ARREADY : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_1_M_AXI_SG_ARVALID : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_1_M_AXI_SG_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_1_M_AXI_SG_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_1_M_AXI_SG_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_1_M_AXI_SG_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_1_M_AXI_SG_AWREADY : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_1_M_AXI_SG_AWVALID : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_BREADY : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_1_M_AXI_SG_BVALID : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_1_M_AXI_SG_RLAST : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_RREADY : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_1_M_AXI_SG_RVALID : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_1_M_AXI_SG_WLAST : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_WREADY : STD_LOGIC;
  signal axi_dma_1_M_AXI_SG_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_1_M_AXI_SG_WVALID : STD_LOGIC;
  signal axi_dma_1_mm2s_introut : STD_LOGIC;
  signal axi_dma_2_M_AXIS_MM2S_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_2_M_AXIS_MM2S_TKEEP : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal axi_dma_2_M_AXIS_MM2S_TLAST : STD_LOGIC;
  signal axi_dma_2_M_AXIS_MM2S_TREADY : STD_LOGIC;
  signal axi_dma_2_M_AXIS_MM2S_TVALID : STD_LOGIC;
  signal axi_dma_2_M_AXI_MM2S_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_ARREADY : STD_LOGIC;
  signal axi_dma_2_M_AXI_MM2S_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_ARVALID : STD_LOGIC;
  signal axi_dma_2_M_AXI_MM2S_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_RLAST : STD_LOGIC;
  signal axi_dma_2_M_AXI_MM2S_RREADY : STD_LOGIC;
  signal axi_dma_2_M_AXI_MM2S_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_2_M_AXI_MM2S_RVALID : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_2_M_AXI_SG_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_2_M_AXI_SG_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_2_M_AXI_SG_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_2_M_AXI_SG_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_2_M_AXI_SG_ARREADY : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_2_M_AXI_SG_ARVALID : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_2_M_AXI_SG_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_2_M_AXI_SG_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_2_M_AXI_SG_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_2_M_AXI_SG_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_2_M_AXI_SG_AWREADY : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_2_M_AXI_SG_AWVALID : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_BREADY : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_2_M_AXI_SG_BVALID : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_2_M_AXI_SG_RLAST : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_RREADY : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_2_M_AXI_SG_RVALID : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_2_M_AXI_SG_WLAST : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_WREADY : STD_LOGIC;
  signal axi_dma_2_M_AXI_SG_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_2_M_AXI_SG_WVALID : STD_LOGIC;
  signal axi_dma_2_mm2s_introut : STD_LOGIC;
  signal axi_dma_3_M_AXIS_MM2S_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_3_M_AXIS_MM2S_TKEEP : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal axi_dma_3_M_AXIS_MM2S_TLAST : STD_LOGIC;
  signal axi_dma_3_M_AXIS_MM2S_TREADY : STD_LOGIC;
  signal axi_dma_3_M_AXIS_MM2S_TVALID : STD_LOGIC;
  signal axi_dma_3_M_AXI_MM2S_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_ARREADY : STD_LOGIC;
  signal axi_dma_3_M_AXI_MM2S_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_ARVALID : STD_LOGIC;
  signal axi_dma_3_M_AXI_MM2S_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_RLAST : STD_LOGIC;
  signal axi_dma_3_M_AXI_MM2S_RREADY : STD_LOGIC;
  signal axi_dma_3_M_AXI_MM2S_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_3_M_AXI_MM2S_RVALID : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_3_M_AXI_SG_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_3_M_AXI_SG_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_3_M_AXI_SG_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_3_M_AXI_SG_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_3_M_AXI_SG_ARREADY : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_3_M_AXI_SG_ARVALID : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_3_M_AXI_SG_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_3_M_AXI_SG_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_3_M_AXI_SG_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_3_M_AXI_SG_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_3_M_AXI_SG_AWREADY : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_3_M_AXI_SG_AWVALID : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_BREADY : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_3_M_AXI_SG_BVALID : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_3_M_AXI_SG_RLAST : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_RREADY : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_3_M_AXI_SG_RVALID : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_3_M_AXI_SG_WLAST : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_WREADY : STD_LOGIC;
  signal axi_dma_3_M_AXI_SG_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_3_M_AXI_SG_WVALID : STD_LOGIC;
  signal axi_dma_3_mm2s_introut : STD_LOGIC;
  signal axi_dma_4_M_AXIS_MM2S_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_4_M_AXIS_MM2S_TKEEP : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal axi_dma_4_M_AXIS_MM2S_TLAST : STD_LOGIC;
  signal axi_dma_4_M_AXIS_MM2S_TREADY : STD_LOGIC;
  signal axi_dma_4_M_AXIS_MM2S_TVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_MM2S_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_ARREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_MM2S_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_ARVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_MM2S_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_RLAST : STD_LOGIC;
  signal axi_dma_4_M_AXI_MM2S_RREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_MM2S_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_MM2S_RVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_S2MM_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_AWREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_S2MM_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_AWVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_S2MM_BREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_S2MM_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_BVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_S2MM_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_WLAST : STD_LOGIC;
  signal axi_dma_4_M_AXI_S2MM_WREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_S2MM_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal axi_dma_4_M_AXI_S2MM_WVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_4_M_AXI_SG_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_SG_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_4_M_AXI_SG_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_4_M_AXI_SG_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_SG_ARREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_SG_ARVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_4_M_AXI_SG_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_SG_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_4_M_AXI_SG_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_dma_4_M_AXI_SG_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_SG_AWREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_dma_4_M_AXI_SG_AWVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_BREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_SG_BVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_4_M_AXI_SG_RLAST : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_RREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_dma_4_M_AXI_SG_RVALID : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_dma_4_M_AXI_SG_WLAST : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_WREADY : STD_LOGIC;
  signal axi_dma_4_M_AXI_SG_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_dma_4_M_AXI_SG_WVALID : STD_LOGIC;
  signal axi_dma_4_mm2s_introut : STD_LOGIC;
  signal axi_dma_4_s2mm_introut : STD_LOGIC;
  signal lane_checker_1_m_res_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal lane_checker_1_m_res_TKEEP : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal lane_checker_1_m_res_TLAST : STD_LOGIC;
  signal lane_checker_1_m_res_TREADY : STD_LOGIC;
  signal lane_checker_1_m_res_TVALID : STD_LOGIC;
  signal proc_sys_reset_0_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M00_AXI_ARREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M00_AXI_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M00_AXI_AWREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M00_AXI_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_M00_AXI_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M00_AXI_BVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M00_AXI_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M00_AXI_RVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M00_AXI_WREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M00_AXI_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ps8_0_axi_periph_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M01_AXI_ARREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_ARVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M01_AXI_AWREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_AWVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_BREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M01_AXI_BVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M01_AXI_RREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M01_AXI_RVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M01_AXI_WREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M01_AXI_WVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M02_AXI_ARREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_ARVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M02_AXI_AWREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_AWVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_BREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M02_AXI_BVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M02_AXI_RREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M02_AXI_RVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M02_AXI_WREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M02_AXI_WVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M03_AXI_ARREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_ARVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M03_AXI_AWREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_AWVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_BREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M03_AXI_BVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M03_AXI_RREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M03_AXI_RVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M03_AXI_WREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M03_AXI_WVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M04_AXI_ARREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_ARVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal ps8_0_axi_periph_M04_AXI_AWREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_AWVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_BREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M04_AXI_BVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M04_AXI_RREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ps8_0_axi_periph_M04_AXI_RVALID : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ps8_0_axi_periph_M04_AXI_WREADY : STD_LOGIC;
  signal ps8_0_axi_periph_M04_AXI_WVALID : STD_LOGIC;
  signal smartconnect_0_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_0_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_0_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_0_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_0_M00_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_0_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_0_M00_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_0_M00_AXI_ARREADY : STD_LOGIC;
  signal smartconnect_0_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_0_M00_AXI_ARVALID : STD_LOGIC;
  signal smartconnect_0_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_0_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_0_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_0_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_0_M00_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_0_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_0_M00_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_0_M00_AXI_AWREADY : STD_LOGIC;
  signal smartconnect_0_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_0_M00_AXI_AWVALID : STD_LOGIC;
  signal smartconnect_0_M00_AXI_BREADY : STD_LOGIC;
  signal smartconnect_0_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_0_M00_AXI_BVALID : STD_LOGIC;
  signal smartconnect_0_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_0_M00_AXI_RLAST : STD_LOGIC;
  signal smartconnect_0_M00_AXI_RREADY : STD_LOGIC;
  signal smartconnect_0_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_0_M00_AXI_RVALID : STD_LOGIC;
  signal smartconnect_0_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_0_M00_AXI_WLAST : STD_LOGIC;
  signal smartconnect_0_M00_AXI_WREADY : STD_LOGIC;
  signal smartconnect_0_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal smartconnect_0_M00_AXI_WVALID : STD_LOGIC;
  signal smartconnect_1_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_1_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_1_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_1_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_1_M00_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_1_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_1_M00_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_1_M00_AXI_ARREADY : STD_LOGIC;
  signal smartconnect_1_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_1_M00_AXI_ARVALID : STD_LOGIC;
  signal smartconnect_1_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_1_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_1_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_1_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_1_M00_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_1_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_1_M00_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_1_M00_AXI_AWREADY : STD_LOGIC;
  signal smartconnect_1_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_1_M00_AXI_AWVALID : STD_LOGIC;
  signal smartconnect_1_M00_AXI_BREADY : STD_LOGIC;
  signal smartconnect_1_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_1_M00_AXI_BVALID : STD_LOGIC;
  signal smartconnect_1_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_1_M00_AXI_RLAST : STD_LOGIC;
  signal smartconnect_1_M00_AXI_RREADY : STD_LOGIC;
  signal smartconnect_1_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_1_M00_AXI_RVALID : STD_LOGIC;
  signal smartconnect_1_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_1_M00_AXI_WLAST : STD_LOGIC;
  signal smartconnect_1_M00_AXI_WREADY : STD_LOGIC;
  signal smartconnect_1_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal smartconnect_1_M00_AXI_WVALID : STD_LOGIC;
  signal smartconnect_2_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_2_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_2_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_2_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_2_M00_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_2_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_2_M00_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_2_M00_AXI_ARREADY : STD_LOGIC;
  signal smartconnect_2_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_2_M00_AXI_ARVALID : STD_LOGIC;
  signal smartconnect_2_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_2_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_2_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_2_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_2_M00_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_2_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_2_M00_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_2_M00_AXI_AWREADY : STD_LOGIC;
  signal smartconnect_2_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_2_M00_AXI_AWVALID : STD_LOGIC;
  signal smartconnect_2_M00_AXI_BREADY : STD_LOGIC;
  signal smartconnect_2_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_2_M00_AXI_BVALID : STD_LOGIC;
  signal smartconnect_2_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_2_M00_AXI_RLAST : STD_LOGIC;
  signal smartconnect_2_M00_AXI_RREADY : STD_LOGIC;
  signal smartconnect_2_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_2_M00_AXI_RVALID : STD_LOGIC;
  signal smartconnect_2_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_2_M00_AXI_WLAST : STD_LOGIC;
  signal smartconnect_2_M00_AXI_WREADY : STD_LOGIC;
  signal smartconnect_2_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal smartconnect_2_M00_AXI_WVALID : STD_LOGIC;
  signal smartconnect_3_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_3_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_3_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_3_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_3_M00_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_3_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_3_M00_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_3_M00_AXI_ARREADY : STD_LOGIC;
  signal smartconnect_3_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_3_M00_AXI_ARVALID : STD_LOGIC;
  signal smartconnect_3_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_3_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_3_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_3_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_3_M00_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_3_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_3_M00_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_3_M00_AXI_AWREADY : STD_LOGIC;
  signal smartconnect_3_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_3_M00_AXI_AWVALID : STD_LOGIC;
  signal smartconnect_3_M00_AXI_BREADY : STD_LOGIC;
  signal smartconnect_3_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_3_M00_AXI_BVALID : STD_LOGIC;
  signal smartconnect_3_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_3_M00_AXI_RLAST : STD_LOGIC;
  signal smartconnect_3_M00_AXI_RREADY : STD_LOGIC;
  signal smartconnect_3_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_3_M00_AXI_RVALID : STD_LOGIC;
  signal smartconnect_3_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_3_M00_AXI_WLAST : STD_LOGIC;
  signal smartconnect_3_M00_AXI_WREADY : STD_LOGIC;
  signal smartconnect_3_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal smartconnect_3_M00_AXI_WVALID : STD_LOGIC;
  signal smartconnect_4_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_4_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_4_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_4_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_4_M00_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_4_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_4_M00_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_4_M00_AXI_ARREADY : STD_LOGIC;
  signal smartconnect_4_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_4_M00_AXI_ARVALID : STD_LOGIC;
  signal smartconnect_4_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal smartconnect_4_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_4_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_4_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal smartconnect_4_M00_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal smartconnect_4_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_4_M00_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal smartconnect_4_M00_AXI_AWREADY : STD_LOGIC;
  signal smartconnect_4_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal smartconnect_4_M00_AXI_AWVALID : STD_LOGIC;
  signal smartconnect_4_M00_AXI_BREADY : STD_LOGIC;
  signal smartconnect_4_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_4_M00_AXI_BVALID : STD_LOGIC;
  signal smartconnect_4_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_4_M00_AXI_RLAST : STD_LOGIC;
  signal smartconnect_4_M00_AXI_RREADY : STD_LOGIC;
  signal smartconnect_4_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal smartconnect_4_M00_AXI_RVALID : STD_LOGIC;
  signal smartconnect_4_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal smartconnect_4_M00_AXI_WLAST : STD_LOGIC;
  signal smartconnect_4_M00_AXI_WREADY : STD_LOGIC;
  signal smartconnect_4_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal smartconnect_4_M00_AXI_WVALID : STD_LOGIC;
  signal xlconcat_0_dout : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal xlconstant_0_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLOCK : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLOCK : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RLAST : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WLAST : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARLOCK : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWADDR : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWLOCK : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RID : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RLAST : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WLAST : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WREADY : STD_LOGIC;
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WSTRB : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WVALID : STD_LOGIC;
  signal zynq_ultra_ps_e_0_pl_clk0 : STD_LOGIC;
  signal zynq_ultra_ps_e_0_pl_resetn0 : STD_LOGIC;
  signal NLW_axi_dma_0_mm2s_prmry_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_1_mm2s_prmry_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_2_mm2s_prmry_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_3_mm2s_prmry_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_m_axis_mm2s_cntrl_tlast_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_m_axis_mm2s_cntrl_tvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_mm2s_cntrl_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_mm2s_prmry_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_s2mm_prmry_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_s2mm_sts_reset_out_n_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_s_axis_s2mm_sts_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_dma_4_m_axis_mm2s_cntrl_tdata_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_axi_dma_4_m_axis_mm2s_cntrl_tkeep_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_proc_sys_reset_0_mb_reset_UNCONNECTED : STD_LOGIC;
  signal NLW_proc_sys_reset_0_bus_struct_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_proc_sys_reset_0_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_proc_sys_reset_0_peripheral_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_zynq_ultra_ps_e_0_maxigp0_aruser_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_maxigp0_awuser_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_maxigp1_aruser_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_maxigp1_awuser_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp0_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp0_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp2_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp2_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp3_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp3_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp4_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp4_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp5_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_saxigp5_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
begin
axi_dma_0: component memthing_axi_dma_0_0
     port map (
      axi_resetn => proc_sys_reset_0_peripheral_aresetn(0),
      m_axi_mm2s_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_mm2s_araddr(31 downto 0) => axi_dma_0_M_AXI_MM2S_ARADDR(31 downto 0),
      m_axi_mm2s_arburst(1 downto 0) => axi_dma_0_M_AXI_MM2S_ARBURST(1 downto 0),
      m_axi_mm2s_arcache(3 downto 0) => axi_dma_0_M_AXI_MM2S_ARCACHE(3 downto 0),
      m_axi_mm2s_arlen(7 downto 0) => axi_dma_0_M_AXI_MM2S_ARLEN(7 downto 0),
      m_axi_mm2s_arprot(2 downto 0) => axi_dma_0_M_AXI_MM2S_ARPROT(2 downto 0),
      m_axi_mm2s_arready => axi_dma_0_M_AXI_MM2S_ARREADY,
      m_axi_mm2s_arsize(2 downto 0) => axi_dma_0_M_AXI_MM2S_ARSIZE(2 downto 0),
      m_axi_mm2s_arvalid => axi_dma_0_M_AXI_MM2S_ARVALID,
      m_axi_mm2s_rdata(127 downto 0) => axi_dma_0_M_AXI_MM2S_RDATA(127 downto 0),
      m_axi_mm2s_rlast => axi_dma_0_M_AXI_MM2S_RLAST,
      m_axi_mm2s_rready => axi_dma_0_M_AXI_MM2S_RREADY,
      m_axi_mm2s_rresp(1 downto 0) => axi_dma_0_M_AXI_MM2S_RRESP(1 downto 0),
      m_axi_mm2s_rvalid => axi_dma_0_M_AXI_MM2S_RVALID,
      m_axi_sg_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_sg_araddr(31 downto 0) => axi_dma_0_M_AXI_SG_ARADDR(31 downto 0),
      m_axi_sg_arburst(1 downto 0) => axi_dma_0_M_AXI_SG_ARBURST(1 downto 0),
      m_axi_sg_arcache(3 downto 0) => axi_dma_0_M_AXI_SG_ARCACHE(3 downto 0),
      m_axi_sg_arlen(7 downto 0) => axi_dma_0_M_AXI_SG_ARLEN(7 downto 0),
      m_axi_sg_arprot(2 downto 0) => axi_dma_0_M_AXI_SG_ARPROT(2 downto 0),
      m_axi_sg_arready => axi_dma_0_M_AXI_SG_ARREADY,
      m_axi_sg_arsize(2 downto 0) => axi_dma_0_M_AXI_SG_ARSIZE(2 downto 0),
      m_axi_sg_arvalid => axi_dma_0_M_AXI_SG_ARVALID,
      m_axi_sg_awaddr(31 downto 0) => axi_dma_0_M_AXI_SG_AWADDR(31 downto 0),
      m_axi_sg_awburst(1 downto 0) => axi_dma_0_M_AXI_SG_AWBURST(1 downto 0),
      m_axi_sg_awcache(3 downto 0) => axi_dma_0_M_AXI_SG_AWCACHE(3 downto 0),
      m_axi_sg_awlen(7 downto 0) => axi_dma_0_M_AXI_SG_AWLEN(7 downto 0),
      m_axi_sg_awprot(2 downto 0) => axi_dma_0_M_AXI_SG_AWPROT(2 downto 0),
      m_axi_sg_awready => axi_dma_0_M_AXI_SG_AWREADY,
      m_axi_sg_awsize(2 downto 0) => axi_dma_0_M_AXI_SG_AWSIZE(2 downto 0),
      m_axi_sg_awvalid => axi_dma_0_M_AXI_SG_AWVALID,
      m_axi_sg_bready => axi_dma_0_M_AXI_SG_BREADY,
      m_axi_sg_bresp(1 downto 0) => axi_dma_0_M_AXI_SG_BRESP(1 downto 0),
      m_axi_sg_bvalid => axi_dma_0_M_AXI_SG_BVALID,
      m_axi_sg_rdata(31 downto 0) => axi_dma_0_M_AXI_SG_RDATA(31 downto 0),
      m_axi_sg_rlast => axi_dma_0_M_AXI_SG_RLAST,
      m_axi_sg_rready => axi_dma_0_M_AXI_SG_RREADY,
      m_axi_sg_rresp(1 downto 0) => axi_dma_0_M_AXI_SG_RRESP(1 downto 0),
      m_axi_sg_rvalid => axi_dma_0_M_AXI_SG_RVALID,
      m_axi_sg_wdata(31 downto 0) => axi_dma_0_M_AXI_SG_WDATA(31 downto 0),
      m_axi_sg_wlast => axi_dma_0_M_AXI_SG_WLAST,
      m_axi_sg_wready => axi_dma_0_M_AXI_SG_WREADY,
      m_axi_sg_wstrb(3 downto 0) => axi_dma_0_M_AXI_SG_WSTRB(3 downto 0),
      m_axi_sg_wvalid => axi_dma_0_M_AXI_SG_WVALID,
      m_axis_mm2s_tdata(127 downto 0) => axi_dma_0_M_AXIS_MM2S_TDATA(127 downto 0),
      m_axis_mm2s_tkeep(15 downto 0) => axi_dma_0_M_AXIS_MM2S_TKEEP(15 downto 0),
      m_axis_mm2s_tlast => axi_dma_0_M_AXIS_MM2S_TLAST,
      m_axis_mm2s_tready => axi_dma_0_M_AXIS_MM2S_TREADY,
      m_axis_mm2s_tvalid => axi_dma_0_M_AXIS_MM2S_TVALID,
      mm2s_introut => axi_dma_0_mm2s_introut,
      mm2s_prmry_reset_out_n => NLW_axi_dma_0_mm2s_prmry_reset_out_n_UNCONNECTED,
      s_axi_lite_aclk => zynq_ultra_ps_e_0_pl_clk0,
      s_axi_lite_araddr(9 downto 0) => ps8_0_axi_periph_M00_AXI_ARADDR(9 downto 0),
      s_axi_lite_arready => ps8_0_axi_periph_M00_AXI_ARREADY,
      s_axi_lite_arvalid => ps8_0_axi_periph_M00_AXI_ARVALID(0),
      s_axi_lite_awaddr(9 downto 0) => ps8_0_axi_periph_M00_AXI_AWADDR(9 downto 0),
      s_axi_lite_awready => ps8_0_axi_periph_M00_AXI_AWREADY,
      s_axi_lite_awvalid => ps8_0_axi_periph_M00_AXI_AWVALID(0),
      s_axi_lite_bready => ps8_0_axi_periph_M00_AXI_BREADY(0),
      s_axi_lite_bresp(1 downto 0) => ps8_0_axi_periph_M00_AXI_BRESP(1 downto 0),
      s_axi_lite_bvalid => ps8_0_axi_periph_M00_AXI_BVALID,
      s_axi_lite_rdata(31 downto 0) => ps8_0_axi_periph_M00_AXI_RDATA(31 downto 0),
      s_axi_lite_rready => ps8_0_axi_periph_M00_AXI_RREADY(0),
      s_axi_lite_rresp(1 downto 0) => ps8_0_axi_periph_M00_AXI_RRESP(1 downto 0),
      s_axi_lite_rvalid => ps8_0_axi_periph_M00_AXI_RVALID,
      s_axi_lite_wdata(31 downto 0) => ps8_0_axi_periph_M00_AXI_WDATA(31 downto 0),
      s_axi_lite_wready => ps8_0_axi_periph_M00_AXI_WREADY,
      s_axi_lite_wvalid => ps8_0_axi_periph_M00_AXI_WVALID(0)
    );
axi_dma_1: component memthing_axi_dma_0_4
     port map (
      axi_resetn => proc_sys_reset_0_peripheral_aresetn(0),
      m_axi_mm2s_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_mm2s_araddr(31 downto 0) => axi_dma_1_M_AXI_MM2S_ARADDR(31 downto 0),
      m_axi_mm2s_arburst(1 downto 0) => axi_dma_1_M_AXI_MM2S_ARBURST(1 downto 0),
      m_axi_mm2s_arcache(3 downto 0) => axi_dma_1_M_AXI_MM2S_ARCACHE(3 downto 0),
      m_axi_mm2s_arlen(7 downto 0) => axi_dma_1_M_AXI_MM2S_ARLEN(7 downto 0),
      m_axi_mm2s_arprot(2 downto 0) => axi_dma_1_M_AXI_MM2S_ARPROT(2 downto 0),
      m_axi_mm2s_arready => axi_dma_1_M_AXI_MM2S_ARREADY,
      m_axi_mm2s_arsize(2 downto 0) => axi_dma_1_M_AXI_MM2S_ARSIZE(2 downto 0),
      m_axi_mm2s_arvalid => axi_dma_1_M_AXI_MM2S_ARVALID,
      m_axi_mm2s_rdata(127 downto 0) => axi_dma_1_M_AXI_MM2S_RDATA(127 downto 0),
      m_axi_mm2s_rlast => axi_dma_1_M_AXI_MM2S_RLAST,
      m_axi_mm2s_rready => axi_dma_1_M_AXI_MM2S_RREADY,
      m_axi_mm2s_rresp(1 downto 0) => axi_dma_1_M_AXI_MM2S_RRESP(1 downto 0),
      m_axi_mm2s_rvalid => axi_dma_1_M_AXI_MM2S_RVALID,
      m_axi_sg_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_sg_araddr(31 downto 0) => axi_dma_1_M_AXI_SG_ARADDR(31 downto 0),
      m_axi_sg_arburst(1 downto 0) => axi_dma_1_M_AXI_SG_ARBURST(1 downto 0),
      m_axi_sg_arcache(3 downto 0) => axi_dma_1_M_AXI_SG_ARCACHE(3 downto 0),
      m_axi_sg_arlen(7 downto 0) => axi_dma_1_M_AXI_SG_ARLEN(7 downto 0),
      m_axi_sg_arprot(2 downto 0) => axi_dma_1_M_AXI_SG_ARPROT(2 downto 0),
      m_axi_sg_arready => axi_dma_1_M_AXI_SG_ARREADY,
      m_axi_sg_arsize(2 downto 0) => axi_dma_1_M_AXI_SG_ARSIZE(2 downto 0),
      m_axi_sg_arvalid => axi_dma_1_M_AXI_SG_ARVALID,
      m_axi_sg_awaddr(31 downto 0) => axi_dma_1_M_AXI_SG_AWADDR(31 downto 0),
      m_axi_sg_awburst(1 downto 0) => axi_dma_1_M_AXI_SG_AWBURST(1 downto 0),
      m_axi_sg_awcache(3 downto 0) => axi_dma_1_M_AXI_SG_AWCACHE(3 downto 0),
      m_axi_sg_awlen(7 downto 0) => axi_dma_1_M_AXI_SG_AWLEN(7 downto 0),
      m_axi_sg_awprot(2 downto 0) => axi_dma_1_M_AXI_SG_AWPROT(2 downto 0),
      m_axi_sg_awready => axi_dma_1_M_AXI_SG_AWREADY,
      m_axi_sg_awsize(2 downto 0) => axi_dma_1_M_AXI_SG_AWSIZE(2 downto 0),
      m_axi_sg_awvalid => axi_dma_1_M_AXI_SG_AWVALID,
      m_axi_sg_bready => axi_dma_1_M_AXI_SG_BREADY,
      m_axi_sg_bresp(1 downto 0) => axi_dma_1_M_AXI_SG_BRESP(1 downto 0),
      m_axi_sg_bvalid => axi_dma_1_M_AXI_SG_BVALID,
      m_axi_sg_rdata(31 downto 0) => axi_dma_1_M_AXI_SG_RDATA(31 downto 0),
      m_axi_sg_rlast => axi_dma_1_M_AXI_SG_RLAST,
      m_axi_sg_rready => axi_dma_1_M_AXI_SG_RREADY,
      m_axi_sg_rresp(1 downto 0) => axi_dma_1_M_AXI_SG_RRESP(1 downto 0),
      m_axi_sg_rvalid => axi_dma_1_M_AXI_SG_RVALID,
      m_axi_sg_wdata(31 downto 0) => axi_dma_1_M_AXI_SG_WDATA(31 downto 0),
      m_axi_sg_wlast => axi_dma_1_M_AXI_SG_WLAST,
      m_axi_sg_wready => axi_dma_1_M_AXI_SG_WREADY,
      m_axi_sg_wstrb(3 downto 0) => axi_dma_1_M_AXI_SG_WSTRB(3 downto 0),
      m_axi_sg_wvalid => axi_dma_1_M_AXI_SG_WVALID,
      m_axis_mm2s_tdata(127 downto 0) => axi_dma_1_M_AXIS_MM2S_TDATA(127 downto 0),
      m_axis_mm2s_tkeep(15 downto 0) => axi_dma_1_M_AXIS_MM2S_TKEEP(15 downto 0),
      m_axis_mm2s_tlast => axi_dma_1_M_AXIS_MM2S_TLAST,
      m_axis_mm2s_tready => axi_dma_1_M_AXIS_MM2S_TREADY,
      m_axis_mm2s_tvalid => axi_dma_1_M_AXIS_MM2S_TVALID,
      mm2s_introut => axi_dma_1_mm2s_introut,
      mm2s_prmry_reset_out_n => NLW_axi_dma_1_mm2s_prmry_reset_out_n_UNCONNECTED,
      s_axi_lite_aclk => zynq_ultra_ps_e_0_pl_clk0,
      s_axi_lite_araddr(9 downto 0) => ps8_0_axi_periph_M01_AXI_ARADDR(9 downto 0),
      s_axi_lite_arready => ps8_0_axi_periph_M01_AXI_ARREADY,
      s_axi_lite_arvalid => ps8_0_axi_periph_M01_AXI_ARVALID,
      s_axi_lite_awaddr(9 downto 0) => ps8_0_axi_periph_M01_AXI_AWADDR(9 downto 0),
      s_axi_lite_awready => ps8_0_axi_periph_M01_AXI_AWREADY,
      s_axi_lite_awvalid => ps8_0_axi_periph_M01_AXI_AWVALID,
      s_axi_lite_bready => ps8_0_axi_periph_M01_AXI_BREADY,
      s_axi_lite_bresp(1 downto 0) => ps8_0_axi_periph_M01_AXI_BRESP(1 downto 0),
      s_axi_lite_bvalid => ps8_0_axi_periph_M01_AXI_BVALID,
      s_axi_lite_rdata(31 downto 0) => ps8_0_axi_periph_M01_AXI_RDATA(31 downto 0),
      s_axi_lite_rready => ps8_0_axi_periph_M01_AXI_RREADY,
      s_axi_lite_rresp(1 downto 0) => ps8_0_axi_periph_M01_AXI_RRESP(1 downto 0),
      s_axi_lite_rvalid => ps8_0_axi_periph_M01_AXI_RVALID,
      s_axi_lite_wdata(31 downto 0) => ps8_0_axi_periph_M01_AXI_WDATA(31 downto 0),
      s_axi_lite_wready => ps8_0_axi_periph_M01_AXI_WREADY,
      s_axi_lite_wvalid => ps8_0_axi_periph_M01_AXI_WVALID
    );
axi_dma_2: component memthing_axi_dma_1_0
     port map (
      axi_resetn => proc_sys_reset_0_peripheral_aresetn(0),
      m_axi_mm2s_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_mm2s_araddr(31 downto 0) => axi_dma_2_M_AXI_MM2S_ARADDR(31 downto 0),
      m_axi_mm2s_arburst(1 downto 0) => axi_dma_2_M_AXI_MM2S_ARBURST(1 downto 0),
      m_axi_mm2s_arcache(3 downto 0) => axi_dma_2_M_AXI_MM2S_ARCACHE(3 downto 0),
      m_axi_mm2s_arlen(7 downto 0) => axi_dma_2_M_AXI_MM2S_ARLEN(7 downto 0),
      m_axi_mm2s_arprot(2 downto 0) => axi_dma_2_M_AXI_MM2S_ARPROT(2 downto 0),
      m_axi_mm2s_arready => axi_dma_2_M_AXI_MM2S_ARREADY,
      m_axi_mm2s_arsize(2 downto 0) => axi_dma_2_M_AXI_MM2S_ARSIZE(2 downto 0),
      m_axi_mm2s_arvalid => axi_dma_2_M_AXI_MM2S_ARVALID,
      m_axi_mm2s_rdata(127 downto 0) => axi_dma_2_M_AXI_MM2S_RDATA(127 downto 0),
      m_axi_mm2s_rlast => axi_dma_2_M_AXI_MM2S_RLAST,
      m_axi_mm2s_rready => axi_dma_2_M_AXI_MM2S_RREADY,
      m_axi_mm2s_rresp(1 downto 0) => axi_dma_2_M_AXI_MM2S_RRESP(1 downto 0),
      m_axi_mm2s_rvalid => axi_dma_2_M_AXI_MM2S_RVALID,
      m_axi_sg_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_sg_araddr(31 downto 0) => axi_dma_2_M_AXI_SG_ARADDR(31 downto 0),
      m_axi_sg_arburst(1 downto 0) => axi_dma_2_M_AXI_SG_ARBURST(1 downto 0),
      m_axi_sg_arcache(3 downto 0) => axi_dma_2_M_AXI_SG_ARCACHE(3 downto 0),
      m_axi_sg_arlen(7 downto 0) => axi_dma_2_M_AXI_SG_ARLEN(7 downto 0),
      m_axi_sg_arprot(2 downto 0) => axi_dma_2_M_AXI_SG_ARPROT(2 downto 0),
      m_axi_sg_arready => axi_dma_2_M_AXI_SG_ARREADY,
      m_axi_sg_arsize(2 downto 0) => axi_dma_2_M_AXI_SG_ARSIZE(2 downto 0),
      m_axi_sg_arvalid => axi_dma_2_M_AXI_SG_ARVALID,
      m_axi_sg_awaddr(31 downto 0) => axi_dma_2_M_AXI_SG_AWADDR(31 downto 0),
      m_axi_sg_awburst(1 downto 0) => axi_dma_2_M_AXI_SG_AWBURST(1 downto 0),
      m_axi_sg_awcache(3 downto 0) => axi_dma_2_M_AXI_SG_AWCACHE(3 downto 0),
      m_axi_sg_awlen(7 downto 0) => axi_dma_2_M_AXI_SG_AWLEN(7 downto 0),
      m_axi_sg_awprot(2 downto 0) => axi_dma_2_M_AXI_SG_AWPROT(2 downto 0),
      m_axi_sg_awready => axi_dma_2_M_AXI_SG_AWREADY,
      m_axi_sg_awsize(2 downto 0) => axi_dma_2_M_AXI_SG_AWSIZE(2 downto 0),
      m_axi_sg_awvalid => axi_dma_2_M_AXI_SG_AWVALID,
      m_axi_sg_bready => axi_dma_2_M_AXI_SG_BREADY,
      m_axi_sg_bresp(1 downto 0) => axi_dma_2_M_AXI_SG_BRESP(1 downto 0),
      m_axi_sg_bvalid => axi_dma_2_M_AXI_SG_BVALID,
      m_axi_sg_rdata(31 downto 0) => axi_dma_2_M_AXI_SG_RDATA(31 downto 0),
      m_axi_sg_rlast => axi_dma_2_M_AXI_SG_RLAST,
      m_axi_sg_rready => axi_dma_2_M_AXI_SG_RREADY,
      m_axi_sg_rresp(1 downto 0) => axi_dma_2_M_AXI_SG_RRESP(1 downto 0),
      m_axi_sg_rvalid => axi_dma_2_M_AXI_SG_RVALID,
      m_axi_sg_wdata(31 downto 0) => axi_dma_2_M_AXI_SG_WDATA(31 downto 0),
      m_axi_sg_wlast => axi_dma_2_M_AXI_SG_WLAST,
      m_axi_sg_wready => axi_dma_2_M_AXI_SG_WREADY,
      m_axi_sg_wstrb(3 downto 0) => axi_dma_2_M_AXI_SG_WSTRB(3 downto 0),
      m_axi_sg_wvalid => axi_dma_2_M_AXI_SG_WVALID,
      m_axis_mm2s_tdata(127 downto 0) => axi_dma_2_M_AXIS_MM2S_TDATA(127 downto 0),
      m_axis_mm2s_tkeep(15 downto 0) => axi_dma_2_M_AXIS_MM2S_TKEEP(15 downto 0),
      m_axis_mm2s_tlast => axi_dma_2_M_AXIS_MM2S_TLAST,
      m_axis_mm2s_tready => axi_dma_2_M_AXIS_MM2S_TREADY,
      m_axis_mm2s_tvalid => axi_dma_2_M_AXIS_MM2S_TVALID,
      mm2s_introut => axi_dma_2_mm2s_introut,
      mm2s_prmry_reset_out_n => NLW_axi_dma_2_mm2s_prmry_reset_out_n_UNCONNECTED,
      s_axi_lite_aclk => zynq_ultra_ps_e_0_pl_clk0,
      s_axi_lite_araddr(9 downto 0) => ps8_0_axi_periph_M02_AXI_ARADDR(9 downto 0),
      s_axi_lite_arready => ps8_0_axi_periph_M02_AXI_ARREADY,
      s_axi_lite_arvalid => ps8_0_axi_periph_M02_AXI_ARVALID,
      s_axi_lite_awaddr(9 downto 0) => ps8_0_axi_periph_M02_AXI_AWADDR(9 downto 0),
      s_axi_lite_awready => ps8_0_axi_periph_M02_AXI_AWREADY,
      s_axi_lite_awvalid => ps8_0_axi_periph_M02_AXI_AWVALID,
      s_axi_lite_bready => ps8_0_axi_periph_M02_AXI_BREADY,
      s_axi_lite_bresp(1 downto 0) => ps8_0_axi_periph_M02_AXI_BRESP(1 downto 0),
      s_axi_lite_bvalid => ps8_0_axi_periph_M02_AXI_BVALID,
      s_axi_lite_rdata(31 downto 0) => ps8_0_axi_periph_M02_AXI_RDATA(31 downto 0),
      s_axi_lite_rready => ps8_0_axi_periph_M02_AXI_RREADY,
      s_axi_lite_rresp(1 downto 0) => ps8_0_axi_periph_M02_AXI_RRESP(1 downto 0),
      s_axi_lite_rvalid => ps8_0_axi_periph_M02_AXI_RVALID,
      s_axi_lite_wdata(31 downto 0) => ps8_0_axi_periph_M02_AXI_WDATA(31 downto 0),
      s_axi_lite_wready => ps8_0_axi_periph_M02_AXI_WREADY,
      s_axi_lite_wvalid => ps8_0_axi_periph_M02_AXI_WVALID
    );
axi_dma_3: component memthing_axi_dma_1_1
     port map (
      axi_resetn => proc_sys_reset_0_peripheral_aresetn(0),
      m_axi_mm2s_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_mm2s_araddr(31 downto 0) => axi_dma_3_M_AXI_MM2S_ARADDR(31 downto 0),
      m_axi_mm2s_arburst(1 downto 0) => axi_dma_3_M_AXI_MM2S_ARBURST(1 downto 0),
      m_axi_mm2s_arcache(3 downto 0) => axi_dma_3_M_AXI_MM2S_ARCACHE(3 downto 0),
      m_axi_mm2s_arlen(7 downto 0) => axi_dma_3_M_AXI_MM2S_ARLEN(7 downto 0),
      m_axi_mm2s_arprot(2 downto 0) => axi_dma_3_M_AXI_MM2S_ARPROT(2 downto 0),
      m_axi_mm2s_arready => axi_dma_3_M_AXI_MM2S_ARREADY,
      m_axi_mm2s_arsize(2 downto 0) => axi_dma_3_M_AXI_MM2S_ARSIZE(2 downto 0),
      m_axi_mm2s_arvalid => axi_dma_3_M_AXI_MM2S_ARVALID,
      m_axi_mm2s_rdata(127 downto 0) => axi_dma_3_M_AXI_MM2S_RDATA(127 downto 0),
      m_axi_mm2s_rlast => axi_dma_3_M_AXI_MM2S_RLAST,
      m_axi_mm2s_rready => axi_dma_3_M_AXI_MM2S_RREADY,
      m_axi_mm2s_rresp(1 downto 0) => axi_dma_3_M_AXI_MM2S_RRESP(1 downto 0),
      m_axi_mm2s_rvalid => axi_dma_3_M_AXI_MM2S_RVALID,
      m_axi_sg_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_sg_araddr(31 downto 0) => axi_dma_3_M_AXI_SG_ARADDR(31 downto 0),
      m_axi_sg_arburst(1 downto 0) => axi_dma_3_M_AXI_SG_ARBURST(1 downto 0),
      m_axi_sg_arcache(3 downto 0) => axi_dma_3_M_AXI_SG_ARCACHE(3 downto 0),
      m_axi_sg_arlen(7 downto 0) => axi_dma_3_M_AXI_SG_ARLEN(7 downto 0),
      m_axi_sg_arprot(2 downto 0) => axi_dma_3_M_AXI_SG_ARPROT(2 downto 0),
      m_axi_sg_arready => axi_dma_3_M_AXI_SG_ARREADY,
      m_axi_sg_arsize(2 downto 0) => axi_dma_3_M_AXI_SG_ARSIZE(2 downto 0),
      m_axi_sg_arvalid => axi_dma_3_M_AXI_SG_ARVALID,
      m_axi_sg_awaddr(31 downto 0) => axi_dma_3_M_AXI_SG_AWADDR(31 downto 0),
      m_axi_sg_awburst(1 downto 0) => axi_dma_3_M_AXI_SG_AWBURST(1 downto 0),
      m_axi_sg_awcache(3 downto 0) => axi_dma_3_M_AXI_SG_AWCACHE(3 downto 0),
      m_axi_sg_awlen(7 downto 0) => axi_dma_3_M_AXI_SG_AWLEN(7 downto 0),
      m_axi_sg_awprot(2 downto 0) => axi_dma_3_M_AXI_SG_AWPROT(2 downto 0),
      m_axi_sg_awready => axi_dma_3_M_AXI_SG_AWREADY,
      m_axi_sg_awsize(2 downto 0) => axi_dma_3_M_AXI_SG_AWSIZE(2 downto 0),
      m_axi_sg_awvalid => axi_dma_3_M_AXI_SG_AWVALID,
      m_axi_sg_bready => axi_dma_3_M_AXI_SG_BREADY,
      m_axi_sg_bresp(1 downto 0) => axi_dma_3_M_AXI_SG_BRESP(1 downto 0),
      m_axi_sg_bvalid => axi_dma_3_M_AXI_SG_BVALID,
      m_axi_sg_rdata(31 downto 0) => axi_dma_3_M_AXI_SG_RDATA(31 downto 0),
      m_axi_sg_rlast => axi_dma_3_M_AXI_SG_RLAST,
      m_axi_sg_rready => axi_dma_3_M_AXI_SG_RREADY,
      m_axi_sg_rresp(1 downto 0) => axi_dma_3_M_AXI_SG_RRESP(1 downto 0),
      m_axi_sg_rvalid => axi_dma_3_M_AXI_SG_RVALID,
      m_axi_sg_wdata(31 downto 0) => axi_dma_3_M_AXI_SG_WDATA(31 downto 0),
      m_axi_sg_wlast => axi_dma_3_M_AXI_SG_WLAST,
      m_axi_sg_wready => axi_dma_3_M_AXI_SG_WREADY,
      m_axi_sg_wstrb(3 downto 0) => axi_dma_3_M_AXI_SG_WSTRB(3 downto 0),
      m_axi_sg_wvalid => axi_dma_3_M_AXI_SG_WVALID,
      m_axis_mm2s_tdata(127 downto 0) => axi_dma_3_M_AXIS_MM2S_TDATA(127 downto 0),
      m_axis_mm2s_tkeep(15 downto 0) => axi_dma_3_M_AXIS_MM2S_TKEEP(15 downto 0),
      m_axis_mm2s_tlast => axi_dma_3_M_AXIS_MM2S_TLAST,
      m_axis_mm2s_tready => axi_dma_3_M_AXIS_MM2S_TREADY,
      m_axis_mm2s_tvalid => axi_dma_3_M_AXIS_MM2S_TVALID,
      mm2s_introut => axi_dma_3_mm2s_introut,
      mm2s_prmry_reset_out_n => NLW_axi_dma_3_mm2s_prmry_reset_out_n_UNCONNECTED,
      s_axi_lite_aclk => zynq_ultra_ps_e_0_pl_clk0,
      s_axi_lite_araddr(9 downto 0) => ps8_0_axi_periph_M03_AXI_ARADDR(9 downto 0),
      s_axi_lite_arready => ps8_0_axi_periph_M03_AXI_ARREADY,
      s_axi_lite_arvalid => ps8_0_axi_periph_M03_AXI_ARVALID,
      s_axi_lite_awaddr(9 downto 0) => ps8_0_axi_periph_M03_AXI_AWADDR(9 downto 0),
      s_axi_lite_awready => ps8_0_axi_periph_M03_AXI_AWREADY,
      s_axi_lite_awvalid => ps8_0_axi_periph_M03_AXI_AWVALID,
      s_axi_lite_bready => ps8_0_axi_periph_M03_AXI_BREADY,
      s_axi_lite_bresp(1 downto 0) => ps8_0_axi_periph_M03_AXI_BRESP(1 downto 0),
      s_axi_lite_bvalid => ps8_0_axi_periph_M03_AXI_BVALID,
      s_axi_lite_rdata(31 downto 0) => ps8_0_axi_periph_M03_AXI_RDATA(31 downto 0),
      s_axi_lite_rready => ps8_0_axi_periph_M03_AXI_RREADY,
      s_axi_lite_rresp(1 downto 0) => ps8_0_axi_periph_M03_AXI_RRESP(1 downto 0),
      s_axi_lite_rvalid => ps8_0_axi_periph_M03_AXI_RVALID,
      s_axi_lite_wdata(31 downto 0) => ps8_0_axi_periph_M03_AXI_WDATA(31 downto 0),
      s_axi_lite_wready => ps8_0_axi_periph_M03_AXI_WREADY,
      s_axi_lite_wvalid => ps8_0_axi_periph_M03_AXI_WVALID
    );
axi_dma_4: component memthing_axi_dma_4_1
     port map (
      axi_resetn => proc_sys_reset_0_peripheral_aresetn(0),
      m_axi_mm2s_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_mm2s_araddr(31 downto 0) => axi_dma_4_M_AXI_MM2S_ARADDR(31 downto 0),
      m_axi_mm2s_arburst(1 downto 0) => axi_dma_4_M_AXI_MM2S_ARBURST(1 downto 0),
      m_axi_mm2s_arcache(3 downto 0) => axi_dma_4_M_AXI_MM2S_ARCACHE(3 downto 0),
      m_axi_mm2s_arlen(7 downto 0) => axi_dma_4_M_AXI_MM2S_ARLEN(7 downto 0),
      m_axi_mm2s_arprot(2 downto 0) => axi_dma_4_M_AXI_MM2S_ARPROT(2 downto 0),
      m_axi_mm2s_arready => axi_dma_4_M_AXI_MM2S_ARREADY,
      m_axi_mm2s_arsize(2 downto 0) => axi_dma_4_M_AXI_MM2S_ARSIZE(2 downto 0),
      m_axi_mm2s_arvalid => axi_dma_4_M_AXI_MM2S_ARVALID,
      m_axi_mm2s_rdata(127 downto 0) => axi_dma_4_M_AXI_MM2S_RDATA(127 downto 0),
      m_axi_mm2s_rlast => axi_dma_4_M_AXI_MM2S_RLAST,
      m_axi_mm2s_rready => axi_dma_4_M_AXI_MM2S_RREADY,
      m_axi_mm2s_rresp(1 downto 0) => axi_dma_4_M_AXI_MM2S_RRESP(1 downto 0),
      m_axi_mm2s_rvalid => axi_dma_4_M_AXI_MM2S_RVALID,
      m_axi_s2mm_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_s2mm_awaddr(31 downto 0) => axi_dma_4_M_AXI_S2MM_AWADDR(31 downto 0),
      m_axi_s2mm_awburst(1 downto 0) => axi_dma_4_M_AXI_S2MM_AWBURST(1 downto 0),
      m_axi_s2mm_awcache(3 downto 0) => axi_dma_4_M_AXI_S2MM_AWCACHE(3 downto 0),
      m_axi_s2mm_awlen(7 downto 0) => axi_dma_4_M_AXI_S2MM_AWLEN(7 downto 0),
      m_axi_s2mm_awprot(2 downto 0) => axi_dma_4_M_AXI_S2MM_AWPROT(2 downto 0),
      m_axi_s2mm_awready => axi_dma_4_M_AXI_S2MM_AWREADY,
      m_axi_s2mm_awsize(2 downto 0) => axi_dma_4_M_AXI_S2MM_AWSIZE(2 downto 0),
      m_axi_s2mm_awvalid => axi_dma_4_M_AXI_S2MM_AWVALID,
      m_axi_s2mm_bready => axi_dma_4_M_AXI_S2MM_BREADY,
      m_axi_s2mm_bresp(1 downto 0) => axi_dma_4_M_AXI_S2MM_BRESP(1 downto 0),
      m_axi_s2mm_bvalid => axi_dma_4_M_AXI_S2MM_BVALID,
      m_axi_s2mm_wdata(127 downto 0) => axi_dma_4_M_AXI_S2MM_WDATA(127 downto 0),
      m_axi_s2mm_wlast => axi_dma_4_M_AXI_S2MM_WLAST,
      m_axi_s2mm_wready => axi_dma_4_M_AXI_S2MM_WREADY,
      m_axi_s2mm_wstrb(15 downto 0) => axi_dma_4_M_AXI_S2MM_WSTRB(15 downto 0),
      m_axi_s2mm_wvalid => axi_dma_4_M_AXI_S2MM_WVALID,
      m_axi_sg_aclk => zynq_ultra_ps_e_0_pl_clk0,
      m_axi_sg_araddr(31 downto 0) => axi_dma_4_M_AXI_SG_ARADDR(31 downto 0),
      m_axi_sg_arburst(1 downto 0) => axi_dma_4_M_AXI_SG_ARBURST(1 downto 0),
      m_axi_sg_arcache(3 downto 0) => axi_dma_4_M_AXI_SG_ARCACHE(3 downto 0),
      m_axi_sg_arlen(7 downto 0) => axi_dma_4_M_AXI_SG_ARLEN(7 downto 0),
      m_axi_sg_arprot(2 downto 0) => axi_dma_4_M_AXI_SG_ARPROT(2 downto 0),
      m_axi_sg_arready => axi_dma_4_M_AXI_SG_ARREADY,
      m_axi_sg_arsize(2 downto 0) => axi_dma_4_M_AXI_SG_ARSIZE(2 downto 0),
      m_axi_sg_arvalid => axi_dma_4_M_AXI_SG_ARVALID,
      m_axi_sg_awaddr(31 downto 0) => axi_dma_4_M_AXI_SG_AWADDR(31 downto 0),
      m_axi_sg_awburst(1 downto 0) => axi_dma_4_M_AXI_SG_AWBURST(1 downto 0),
      m_axi_sg_awcache(3 downto 0) => axi_dma_4_M_AXI_SG_AWCACHE(3 downto 0),
      m_axi_sg_awlen(7 downto 0) => axi_dma_4_M_AXI_SG_AWLEN(7 downto 0),
      m_axi_sg_awprot(2 downto 0) => axi_dma_4_M_AXI_SG_AWPROT(2 downto 0),
      m_axi_sg_awready => axi_dma_4_M_AXI_SG_AWREADY,
      m_axi_sg_awsize(2 downto 0) => axi_dma_4_M_AXI_SG_AWSIZE(2 downto 0),
      m_axi_sg_awvalid => axi_dma_4_M_AXI_SG_AWVALID,
      m_axi_sg_bready => axi_dma_4_M_AXI_SG_BREADY,
      m_axi_sg_bresp(1 downto 0) => axi_dma_4_M_AXI_SG_BRESP(1 downto 0),
      m_axi_sg_bvalid => axi_dma_4_M_AXI_SG_BVALID,
      m_axi_sg_rdata(31 downto 0) => axi_dma_4_M_AXI_SG_RDATA(31 downto 0),
      m_axi_sg_rlast => axi_dma_4_M_AXI_SG_RLAST,
      m_axi_sg_rready => axi_dma_4_M_AXI_SG_RREADY,
      m_axi_sg_rresp(1 downto 0) => axi_dma_4_M_AXI_SG_RRESP(1 downto 0),
      m_axi_sg_rvalid => axi_dma_4_M_AXI_SG_RVALID,
      m_axi_sg_wdata(31 downto 0) => axi_dma_4_M_AXI_SG_WDATA(31 downto 0),
      m_axi_sg_wlast => axi_dma_4_M_AXI_SG_WLAST,
      m_axi_sg_wready => axi_dma_4_M_AXI_SG_WREADY,
      m_axi_sg_wstrb(3 downto 0) => axi_dma_4_M_AXI_SG_WSTRB(3 downto 0),
      m_axi_sg_wvalid => axi_dma_4_M_AXI_SG_WVALID,
      m_axis_mm2s_cntrl_tdata(31 downto 0) => NLW_axi_dma_4_m_axis_mm2s_cntrl_tdata_UNCONNECTED(31 downto 0),
      m_axis_mm2s_cntrl_tkeep(3 downto 0) => NLW_axi_dma_4_m_axis_mm2s_cntrl_tkeep_UNCONNECTED(3 downto 0),
      m_axis_mm2s_cntrl_tlast => NLW_axi_dma_4_m_axis_mm2s_cntrl_tlast_UNCONNECTED,
      m_axis_mm2s_cntrl_tready => '1',
      m_axis_mm2s_cntrl_tvalid => NLW_axi_dma_4_m_axis_mm2s_cntrl_tvalid_UNCONNECTED,
      m_axis_mm2s_tdata(127 downto 0) => axi_dma_4_M_AXIS_MM2S_TDATA(127 downto 0),
      m_axis_mm2s_tkeep(15 downto 0) => axi_dma_4_M_AXIS_MM2S_TKEEP(15 downto 0),
      m_axis_mm2s_tlast => axi_dma_4_M_AXIS_MM2S_TLAST,
      m_axis_mm2s_tready => axi_dma_4_M_AXIS_MM2S_TREADY,
      m_axis_mm2s_tvalid => axi_dma_4_M_AXIS_MM2S_TVALID,
      mm2s_cntrl_reset_out_n => NLW_axi_dma_4_mm2s_cntrl_reset_out_n_UNCONNECTED,
      mm2s_introut => axi_dma_4_mm2s_introut,
      mm2s_prmry_reset_out_n => NLW_axi_dma_4_mm2s_prmry_reset_out_n_UNCONNECTED,
      s2mm_introut => axi_dma_4_s2mm_introut,
      s2mm_prmry_reset_out_n => NLW_axi_dma_4_s2mm_prmry_reset_out_n_UNCONNECTED,
      s2mm_sts_reset_out_n => NLW_axi_dma_4_s2mm_sts_reset_out_n_UNCONNECTED,
      s_axi_lite_aclk => zynq_ultra_ps_e_0_pl_clk0,
      s_axi_lite_araddr(9 downto 0) => ps8_0_axi_periph_M04_AXI_ARADDR(9 downto 0),
      s_axi_lite_arready => ps8_0_axi_periph_M04_AXI_ARREADY,
      s_axi_lite_arvalid => ps8_0_axi_periph_M04_AXI_ARVALID,
      s_axi_lite_awaddr(9 downto 0) => ps8_0_axi_periph_M04_AXI_AWADDR(9 downto 0),
      s_axi_lite_awready => ps8_0_axi_periph_M04_AXI_AWREADY,
      s_axi_lite_awvalid => ps8_0_axi_periph_M04_AXI_AWVALID,
      s_axi_lite_bready => ps8_0_axi_periph_M04_AXI_BREADY,
      s_axi_lite_bresp(1 downto 0) => ps8_0_axi_periph_M04_AXI_BRESP(1 downto 0),
      s_axi_lite_bvalid => ps8_0_axi_periph_M04_AXI_BVALID,
      s_axi_lite_rdata(31 downto 0) => ps8_0_axi_periph_M04_AXI_RDATA(31 downto 0),
      s_axi_lite_rready => ps8_0_axi_periph_M04_AXI_RREADY,
      s_axi_lite_rresp(1 downto 0) => ps8_0_axi_periph_M04_AXI_RRESP(1 downto 0),
      s_axi_lite_rvalid => ps8_0_axi_periph_M04_AXI_RVALID,
      s_axi_lite_wdata(31 downto 0) => ps8_0_axi_periph_M04_AXI_WDATA(31 downto 0),
      s_axi_lite_wready => ps8_0_axi_periph_M04_AXI_WREADY,
      s_axi_lite_wvalid => ps8_0_axi_periph_M04_AXI_WVALID,
      s_axis_s2mm_sts_tdata(31 downto 0) => B"00000000000000000000000000000000",
      s_axis_s2mm_sts_tkeep(3 downto 0) => B"1111",
      s_axis_s2mm_sts_tlast => '0',
      s_axis_s2mm_sts_tready => NLW_axi_dma_4_s_axis_s2mm_sts_tready_UNCONNECTED,
      s_axis_s2mm_sts_tvalid => '0',
      s_axis_s2mm_tdata(127 downto 0) => lane_checker_1_m_res_TDATA(127 downto 0),
      s_axis_s2mm_tkeep(15 downto 0) => lane_checker_1_m_res_TKEEP(15 downto 0),
      s_axis_s2mm_tlast => lane_checker_1_m_res_TLAST,
      s_axis_s2mm_tready => lane_checker_1_m_res_TREADY,
      s_axis_s2mm_tvalid => lane_checker_1_m_res_TVALID
    );
lane_checker_1: component memthing_lane_checker_1_0
     port map (
      aclk => zynq_ultra_ps_e_0_pl_clk0,
      aresetn => proc_sys_reset_0_peripheral_aresetn(0),
      m_res_tdata(127 downto 0) => lane_checker_1_m_res_TDATA(127 downto 0),
      m_res_tkeep(15 downto 0) => lane_checker_1_m_res_TKEEP(15 downto 0),
      m_res_tlast => lane_checker_1_m_res_TLAST,
      m_res_tready => lane_checker_1_m_res_TREADY,
      m_res_tvalid => lane_checker_1_m_res_TVALID,
      s_act_tdata(127 downto 0) => axi_dma_4_M_AXIS_MM2S_TDATA(127 downto 0),
      s_act_tkeep(15 downto 0) => axi_dma_4_M_AXIS_MM2S_TKEEP(15 downto 0),
      s_act_tlast => axi_dma_4_M_AXIS_MM2S_TLAST,
      s_act_tready => axi_dma_4_M_AXIS_MM2S_TREADY,
      s_act_tvalid => axi_dma_4_M_AXIS_MM2S_TVALID,
      s_w0_tdata(127 downto 0) => axi_dma_0_M_AXIS_MM2S_TDATA(127 downto 0),
      s_w0_tkeep(15 downto 0) => axi_dma_0_M_AXIS_MM2S_TKEEP(15 downto 0),
      s_w0_tlast => axi_dma_0_M_AXIS_MM2S_TLAST,
      s_w0_tready => axi_dma_0_M_AXIS_MM2S_TREADY,
      s_w0_tvalid => axi_dma_0_M_AXIS_MM2S_TVALID,
      s_w1_tdata(127 downto 0) => axi_dma_1_M_AXIS_MM2S_TDATA(127 downto 0),
      s_w1_tkeep(15 downto 0) => axi_dma_1_M_AXIS_MM2S_TKEEP(15 downto 0),
      s_w1_tlast => axi_dma_1_M_AXIS_MM2S_TLAST,
      s_w1_tready => axi_dma_1_M_AXIS_MM2S_TREADY,
      s_w1_tvalid => axi_dma_1_M_AXIS_MM2S_TVALID,
      s_w2_tdata(127 downto 0) => axi_dma_2_M_AXIS_MM2S_TDATA(127 downto 0),
      s_w2_tkeep(15 downto 0) => axi_dma_2_M_AXIS_MM2S_TKEEP(15 downto 0),
      s_w2_tlast => axi_dma_2_M_AXIS_MM2S_TLAST,
      s_w2_tready => axi_dma_2_M_AXIS_MM2S_TREADY,
      s_w2_tvalid => axi_dma_2_M_AXIS_MM2S_TVALID,
      s_w3_tdata(127 downto 0) => axi_dma_3_M_AXIS_MM2S_TDATA(127 downto 0),
      s_w3_tkeep(15 downto 0) => axi_dma_3_M_AXIS_MM2S_TKEEP(15 downto 0),
      s_w3_tlast => axi_dma_3_M_AXIS_MM2S_TLAST,
      s_w3_tready => axi_dma_3_M_AXIS_MM2S_TREADY,
      s_w3_tvalid => axi_dma_3_M_AXIS_MM2S_TVALID
    );
proc_sys_reset_0: component memthing_proc_sys_reset_0_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => NLW_proc_sys_reset_0_bus_struct_reset_UNCONNECTED(0),
      dcm_locked => xlconstant_0_dout(0),
      ext_reset_in => zynq_ultra_ps_e_0_pl_resetn0,
      interconnect_aresetn(0) => NLW_proc_sys_reset_0_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => '0',
      mb_reset => NLW_proc_sys_reset_0_mb_reset_UNCONNECTED,
      peripheral_aresetn(0) => proc_sys_reset_0_peripheral_aresetn(0),
      peripheral_reset(0) => NLW_proc_sys_reset_0_peripheral_reset_UNCONNECTED(0),
      slowest_sync_clk => zynq_ultra_ps_e_0_pl_clk0
    );
ps8_0_axi_periph: entity work.memthing_ps8_0_axi_periph_0
     port map (
      ACLK => zynq_ultra_ps_e_0_pl_clk0,
      ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      M00_ACLK => zynq_ultra_ps_e_0_pl_clk0,
      M00_ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      M00_AXI_araddr(39 downto 0) => ps8_0_axi_periph_M00_AXI_ARADDR(39 downto 0),
      M00_AXI_arready(0) => ps8_0_axi_periph_M00_AXI_ARREADY,
      M00_AXI_arvalid(0) => ps8_0_axi_periph_M00_AXI_ARVALID(0),
      M00_AXI_awaddr(39 downto 0) => ps8_0_axi_periph_M00_AXI_AWADDR(39 downto 0),
      M00_AXI_awready(0) => ps8_0_axi_periph_M00_AXI_AWREADY,
      M00_AXI_awvalid(0) => ps8_0_axi_periph_M00_AXI_AWVALID(0),
      M00_AXI_bready(0) => ps8_0_axi_periph_M00_AXI_BREADY(0),
      M00_AXI_bresp(1 downto 0) => ps8_0_axi_periph_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid(0) => ps8_0_axi_periph_M00_AXI_BVALID,
      M00_AXI_rdata(31 downto 0) => ps8_0_axi_periph_M00_AXI_RDATA(31 downto 0),
      M00_AXI_rready(0) => ps8_0_axi_periph_M00_AXI_RREADY(0),
      M00_AXI_rresp(1 downto 0) => ps8_0_axi_periph_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid(0) => ps8_0_axi_periph_M00_AXI_RVALID,
      M00_AXI_wdata(31 downto 0) => ps8_0_axi_periph_M00_AXI_WDATA(31 downto 0),
      M00_AXI_wready(0) => ps8_0_axi_periph_M00_AXI_WREADY,
      M00_AXI_wvalid(0) => ps8_0_axi_periph_M00_AXI_WVALID(0),
      M01_ACLK => zynq_ultra_ps_e_0_pl_clk0,
      M01_ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      M01_AXI_araddr(39 downto 0) => ps8_0_axi_periph_M01_AXI_ARADDR(39 downto 0),
      M01_AXI_arready => ps8_0_axi_periph_M01_AXI_ARREADY,
      M01_AXI_arvalid => ps8_0_axi_periph_M01_AXI_ARVALID,
      M01_AXI_awaddr(39 downto 0) => ps8_0_axi_periph_M01_AXI_AWADDR(39 downto 0),
      M01_AXI_awready => ps8_0_axi_periph_M01_AXI_AWREADY,
      M01_AXI_awvalid => ps8_0_axi_periph_M01_AXI_AWVALID,
      M01_AXI_bready => ps8_0_axi_periph_M01_AXI_BREADY,
      M01_AXI_bresp(1 downto 0) => ps8_0_axi_periph_M01_AXI_BRESP(1 downto 0),
      M01_AXI_bvalid => ps8_0_axi_periph_M01_AXI_BVALID,
      M01_AXI_rdata(31 downto 0) => ps8_0_axi_periph_M01_AXI_RDATA(31 downto 0),
      M01_AXI_rready => ps8_0_axi_periph_M01_AXI_RREADY,
      M01_AXI_rresp(1 downto 0) => ps8_0_axi_periph_M01_AXI_RRESP(1 downto 0),
      M01_AXI_rvalid => ps8_0_axi_periph_M01_AXI_RVALID,
      M01_AXI_wdata(31 downto 0) => ps8_0_axi_periph_M01_AXI_WDATA(31 downto 0),
      M01_AXI_wready => ps8_0_axi_periph_M01_AXI_WREADY,
      M01_AXI_wvalid => ps8_0_axi_periph_M01_AXI_WVALID,
      M02_ACLK => zynq_ultra_ps_e_0_pl_clk0,
      M02_ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      M02_AXI_araddr(39 downto 0) => ps8_0_axi_periph_M02_AXI_ARADDR(39 downto 0),
      M02_AXI_arready => ps8_0_axi_periph_M02_AXI_ARREADY,
      M02_AXI_arvalid => ps8_0_axi_periph_M02_AXI_ARVALID,
      M02_AXI_awaddr(39 downto 0) => ps8_0_axi_periph_M02_AXI_AWADDR(39 downto 0),
      M02_AXI_awready => ps8_0_axi_periph_M02_AXI_AWREADY,
      M02_AXI_awvalid => ps8_0_axi_periph_M02_AXI_AWVALID,
      M02_AXI_bready => ps8_0_axi_periph_M02_AXI_BREADY,
      M02_AXI_bresp(1 downto 0) => ps8_0_axi_periph_M02_AXI_BRESP(1 downto 0),
      M02_AXI_bvalid => ps8_0_axi_periph_M02_AXI_BVALID,
      M02_AXI_rdata(31 downto 0) => ps8_0_axi_periph_M02_AXI_RDATA(31 downto 0),
      M02_AXI_rready => ps8_0_axi_periph_M02_AXI_RREADY,
      M02_AXI_rresp(1 downto 0) => ps8_0_axi_periph_M02_AXI_RRESP(1 downto 0),
      M02_AXI_rvalid => ps8_0_axi_periph_M02_AXI_RVALID,
      M02_AXI_wdata(31 downto 0) => ps8_0_axi_periph_M02_AXI_WDATA(31 downto 0),
      M02_AXI_wready => ps8_0_axi_periph_M02_AXI_WREADY,
      M02_AXI_wvalid => ps8_0_axi_periph_M02_AXI_WVALID,
      M03_ACLK => zynq_ultra_ps_e_0_pl_clk0,
      M03_ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      M03_AXI_araddr(39 downto 0) => ps8_0_axi_periph_M03_AXI_ARADDR(39 downto 0),
      M03_AXI_arready => ps8_0_axi_periph_M03_AXI_ARREADY,
      M03_AXI_arvalid => ps8_0_axi_periph_M03_AXI_ARVALID,
      M03_AXI_awaddr(39 downto 0) => ps8_0_axi_periph_M03_AXI_AWADDR(39 downto 0),
      M03_AXI_awready => ps8_0_axi_periph_M03_AXI_AWREADY,
      M03_AXI_awvalid => ps8_0_axi_periph_M03_AXI_AWVALID,
      M03_AXI_bready => ps8_0_axi_periph_M03_AXI_BREADY,
      M03_AXI_bresp(1 downto 0) => ps8_0_axi_periph_M03_AXI_BRESP(1 downto 0),
      M03_AXI_bvalid => ps8_0_axi_periph_M03_AXI_BVALID,
      M03_AXI_rdata(31 downto 0) => ps8_0_axi_periph_M03_AXI_RDATA(31 downto 0),
      M03_AXI_rready => ps8_0_axi_periph_M03_AXI_RREADY,
      M03_AXI_rresp(1 downto 0) => ps8_0_axi_periph_M03_AXI_RRESP(1 downto 0),
      M03_AXI_rvalid => ps8_0_axi_periph_M03_AXI_RVALID,
      M03_AXI_wdata(31 downto 0) => ps8_0_axi_periph_M03_AXI_WDATA(31 downto 0),
      M03_AXI_wready => ps8_0_axi_periph_M03_AXI_WREADY,
      M03_AXI_wvalid => ps8_0_axi_periph_M03_AXI_WVALID,
      M04_ACLK => zynq_ultra_ps_e_0_pl_clk0,
      M04_ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      M04_AXI_araddr(39 downto 0) => ps8_0_axi_periph_M04_AXI_ARADDR(39 downto 0),
      M04_AXI_arready => ps8_0_axi_periph_M04_AXI_ARREADY,
      M04_AXI_arvalid => ps8_0_axi_periph_M04_AXI_ARVALID,
      M04_AXI_awaddr(39 downto 0) => ps8_0_axi_periph_M04_AXI_AWADDR(39 downto 0),
      M04_AXI_awready => ps8_0_axi_periph_M04_AXI_AWREADY,
      M04_AXI_awvalid => ps8_0_axi_periph_M04_AXI_AWVALID,
      M04_AXI_bready => ps8_0_axi_periph_M04_AXI_BREADY,
      M04_AXI_bresp(1 downto 0) => ps8_0_axi_periph_M04_AXI_BRESP(1 downto 0),
      M04_AXI_bvalid => ps8_0_axi_periph_M04_AXI_BVALID,
      M04_AXI_rdata(31 downto 0) => ps8_0_axi_periph_M04_AXI_RDATA(31 downto 0),
      M04_AXI_rready => ps8_0_axi_periph_M04_AXI_RREADY,
      M04_AXI_rresp(1 downto 0) => ps8_0_axi_periph_M04_AXI_RRESP(1 downto 0),
      M04_AXI_rvalid => ps8_0_axi_periph_M04_AXI_RVALID,
      M04_AXI_wdata(31 downto 0) => ps8_0_axi_periph_M04_AXI_WDATA(31 downto 0),
      M04_AXI_wready => ps8_0_axi_periph_M04_AXI_WREADY,
      M04_AXI_wvalid => ps8_0_axi_periph_M04_AXI_WVALID,
      S00_ACLK => zynq_ultra_ps_e_0_pl_clk0,
      S00_ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      S00_AXI_araddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARADDR(39 downto 0),
      S00_AXI_arburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARCACHE(3 downto 0),
      S00_AXI_arid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARID(15 downto 0),
      S00_AXI_arlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLEN(7 downto 0),
      S00_AXI_arlock(0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLOCK,
      S00_AXI_arprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARQOS(3 downto 0),
      S00_AXI_arready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARREADY,
      S00_AXI_arsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARSIZE(2 downto 0),
      S00_AXI_arvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARVALID,
      S00_AXI_awaddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWADDR(39 downto 0),
      S00_AXI_awburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWBURST(1 downto 0),
      S00_AXI_awcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWCACHE(3 downto 0),
      S00_AXI_awid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWID(15 downto 0),
      S00_AXI_awlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLEN(7 downto 0),
      S00_AXI_awlock(0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLOCK,
      S00_AXI_awprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWPROT(2 downto 0),
      S00_AXI_awqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWQOS(3 downto 0),
      S00_AXI_awready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWREADY,
      S00_AXI_awsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWSIZE(2 downto 0),
      S00_AXI_awvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWVALID,
      S00_AXI_bid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BID(15 downto 0),
      S00_AXI_bready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BREADY,
      S00_AXI_bresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BRESP(1 downto 0),
      S00_AXI_bvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BVALID,
      S00_AXI_rdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RDATA(127 downto 0),
      S00_AXI_rid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RID(15 downto 0),
      S00_AXI_rlast => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RLAST,
      S00_AXI_rready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RREADY,
      S00_AXI_rresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RRESP(1 downto 0),
      S00_AXI_rvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RVALID,
      S00_AXI_wdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WDATA(127 downto 0),
      S00_AXI_wlast => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WLAST,
      S00_AXI_wready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WREADY,
      S00_AXI_wstrb(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WSTRB(15 downto 0),
      S00_AXI_wvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WVALID,
      S01_ACLK => zynq_ultra_ps_e_0_pl_clk0,
      S01_ARESETN => proc_sys_reset_0_peripheral_aresetn(0),
      S01_AXI_araddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARADDR(39 downto 0),
      S01_AXI_arburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARBURST(1 downto 0),
      S01_AXI_arcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARCACHE(3 downto 0),
      S01_AXI_arid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARID(15 downto 0),
      S01_AXI_arlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARLEN(7 downto 0),
      S01_AXI_arlock(0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARLOCK,
      S01_AXI_arprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARPROT(2 downto 0),
      S01_AXI_arqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARQOS(3 downto 0),
      S01_AXI_arready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARREADY,
      S01_AXI_arsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARSIZE(2 downto 0),
      S01_AXI_arvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARVALID,
      S01_AXI_awaddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWADDR(39 downto 0),
      S01_AXI_awburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWBURST(1 downto 0),
      S01_AXI_awcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWCACHE(3 downto 0),
      S01_AXI_awid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWID(15 downto 0),
      S01_AXI_awlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWLEN(7 downto 0),
      S01_AXI_awlock(0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWLOCK,
      S01_AXI_awprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWPROT(2 downto 0),
      S01_AXI_awqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWQOS(3 downto 0),
      S01_AXI_awready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWREADY,
      S01_AXI_awsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWSIZE(2 downto 0),
      S01_AXI_awvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWVALID,
      S01_AXI_bid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BID(15 downto 0),
      S01_AXI_bready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BREADY,
      S01_AXI_bresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BRESP(1 downto 0),
      S01_AXI_bvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BVALID,
      S01_AXI_rdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RDATA(127 downto 0),
      S01_AXI_rid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RID(15 downto 0),
      S01_AXI_rlast => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RLAST,
      S01_AXI_rready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RREADY,
      S01_AXI_rresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RRESP(1 downto 0),
      S01_AXI_rvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RVALID,
      S01_AXI_wdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WDATA(127 downto 0),
      S01_AXI_wlast => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WLAST,
      S01_AXI_wready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WREADY,
      S01_AXI_wstrb(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WSTRB(15 downto 0),
      S01_AXI_wvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WVALID
    );
smartconnect_0: component memthing_smartconnect_0_0
     port map (
      M00_AXI_araddr(48 downto 0) => smartconnect_0_M00_AXI_ARADDR(48 downto 0),
      M00_AXI_arburst(1 downto 0) => smartconnect_0_M00_AXI_ARBURST(1 downto 0),
      M00_AXI_arcache(3 downto 0) => smartconnect_0_M00_AXI_ARCACHE(3 downto 0),
      M00_AXI_arlen(7 downto 0) => smartconnect_0_M00_AXI_ARLEN(7 downto 0),
      M00_AXI_arlock(0) => smartconnect_0_M00_AXI_ARLOCK(0),
      M00_AXI_arprot(2 downto 0) => smartconnect_0_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arqos(3 downto 0) => smartconnect_0_M00_AXI_ARQOS(3 downto 0),
      M00_AXI_arready => smartconnect_0_M00_AXI_ARREADY,
      M00_AXI_arsize(2 downto 0) => smartconnect_0_M00_AXI_ARSIZE(2 downto 0),
      M00_AXI_arvalid => smartconnect_0_M00_AXI_ARVALID,
      M00_AXI_awaddr(48 downto 0) => smartconnect_0_M00_AXI_AWADDR(48 downto 0),
      M00_AXI_awburst(1 downto 0) => smartconnect_0_M00_AXI_AWBURST(1 downto 0),
      M00_AXI_awcache(3 downto 0) => smartconnect_0_M00_AXI_AWCACHE(3 downto 0),
      M00_AXI_awlen(7 downto 0) => smartconnect_0_M00_AXI_AWLEN(7 downto 0),
      M00_AXI_awlock(0) => smartconnect_0_M00_AXI_AWLOCK(0),
      M00_AXI_awprot(2 downto 0) => smartconnect_0_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awqos(3 downto 0) => smartconnect_0_M00_AXI_AWQOS(3 downto 0),
      M00_AXI_awready => smartconnect_0_M00_AXI_AWREADY,
      M00_AXI_awsize(2 downto 0) => smartconnect_0_M00_AXI_AWSIZE(2 downto 0),
      M00_AXI_awvalid => smartconnect_0_M00_AXI_AWVALID,
      M00_AXI_bready => smartconnect_0_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => smartconnect_0_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => smartconnect_0_M00_AXI_BVALID,
      M00_AXI_rdata(127 downto 0) => smartconnect_0_M00_AXI_RDATA(127 downto 0),
      M00_AXI_rlast => smartconnect_0_M00_AXI_RLAST,
      M00_AXI_rready => smartconnect_0_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => smartconnect_0_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => smartconnect_0_M00_AXI_RVALID,
      M00_AXI_wdata(127 downto 0) => smartconnect_0_M00_AXI_WDATA(127 downto 0),
      M00_AXI_wlast => smartconnect_0_M00_AXI_WLAST,
      M00_AXI_wready => smartconnect_0_M00_AXI_WREADY,
      M00_AXI_wstrb(15 downto 0) => smartconnect_0_M00_AXI_WSTRB(15 downto 0),
      M00_AXI_wvalid => smartconnect_0_M00_AXI_WVALID,
      S00_AXI_araddr(31 downto 0) => axi_dma_0_M_AXI_MM2S_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => axi_dma_0_M_AXI_MM2S_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => axi_dma_0_M_AXI_MM2S_ARCACHE(3 downto 0),
      S00_AXI_arlen(7 downto 0) => axi_dma_0_M_AXI_MM2S_ARLEN(7 downto 0),
      S00_AXI_arlock(0) => '0',
      S00_AXI_arprot(2 downto 0) => axi_dma_0_M_AXI_MM2S_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => B"0000",
      S00_AXI_arready => axi_dma_0_M_AXI_MM2S_ARREADY,
      S00_AXI_arsize(2 downto 0) => axi_dma_0_M_AXI_MM2S_ARSIZE(2 downto 0),
      S00_AXI_arvalid => axi_dma_0_M_AXI_MM2S_ARVALID,
      S00_AXI_rdata(127 downto 0) => axi_dma_0_M_AXI_MM2S_RDATA(127 downto 0),
      S00_AXI_rlast => axi_dma_0_M_AXI_MM2S_RLAST,
      S00_AXI_rready => axi_dma_0_M_AXI_MM2S_RREADY,
      S00_AXI_rresp(1 downto 0) => axi_dma_0_M_AXI_MM2S_RRESP(1 downto 0),
      S00_AXI_rvalid => axi_dma_0_M_AXI_MM2S_RVALID,
      S01_AXI_araddr(31 downto 0) => axi_dma_0_M_AXI_SG_ARADDR(31 downto 0),
      S01_AXI_arburst(1 downto 0) => axi_dma_0_M_AXI_SG_ARBURST(1 downto 0),
      S01_AXI_arcache(3 downto 0) => axi_dma_0_M_AXI_SG_ARCACHE(3 downto 0),
      S01_AXI_arlen(7 downto 0) => axi_dma_0_M_AXI_SG_ARLEN(7 downto 0),
      S01_AXI_arlock(0) => '0',
      S01_AXI_arprot(2 downto 0) => axi_dma_0_M_AXI_SG_ARPROT(2 downto 0),
      S01_AXI_arqos(3 downto 0) => B"0000",
      S01_AXI_arready => axi_dma_0_M_AXI_SG_ARREADY,
      S01_AXI_arsize(2 downto 0) => axi_dma_0_M_AXI_SG_ARSIZE(2 downto 0),
      S01_AXI_arvalid => axi_dma_0_M_AXI_SG_ARVALID,
      S01_AXI_awaddr(31 downto 0) => axi_dma_0_M_AXI_SG_AWADDR(31 downto 0),
      S01_AXI_awburst(1 downto 0) => axi_dma_0_M_AXI_SG_AWBURST(1 downto 0),
      S01_AXI_awcache(3 downto 0) => axi_dma_0_M_AXI_SG_AWCACHE(3 downto 0),
      S01_AXI_awlen(7 downto 0) => axi_dma_0_M_AXI_SG_AWLEN(7 downto 0),
      S01_AXI_awlock(0) => '0',
      S01_AXI_awprot(2 downto 0) => axi_dma_0_M_AXI_SG_AWPROT(2 downto 0),
      S01_AXI_awqos(3 downto 0) => B"0000",
      S01_AXI_awready => axi_dma_0_M_AXI_SG_AWREADY,
      S01_AXI_awsize(2 downto 0) => axi_dma_0_M_AXI_SG_AWSIZE(2 downto 0),
      S01_AXI_awvalid => axi_dma_0_M_AXI_SG_AWVALID,
      S01_AXI_bready => axi_dma_0_M_AXI_SG_BREADY,
      S01_AXI_bresp(1 downto 0) => axi_dma_0_M_AXI_SG_BRESP(1 downto 0),
      S01_AXI_bvalid => axi_dma_0_M_AXI_SG_BVALID,
      S01_AXI_rdata(31 downto 0) => axi_dma_0_M_AXI_SG_RDATA(31 downto 0),
      S01_AXI_rlast => axi_dma_0_M_AXI_SG_RLAST,
      S01_AXI_rready => axi_dma_0_M_AXI_SG_RREADY,
      S01_AXI_rresp(1 downto 0) => axi_dma_0_M_AXI_SG_RRESP(1 downto 0),
      S01_AXI_rvalid => axi_dma_0_M_AXI_SG_RVALID,
      S01_AXI_wdata(31 downto 0) => axi_dma_0_M_AXI_SG_WDATA(31 downto 0),
      S01_AXI_wlast => axi_dma_0_M_AXI_SG_WLAST,
      S01_AXI_wready => axi_dma_0_M_AXI_SG_WREADY,
      S01_AXI_wstrb(3 downto 0) => axi_dma_0_M_AXI_SG_WSTRB(3 downto 0),
      S01_AXI_wvalid => axi_dma_0_M_AXI_SG_WVALID,
      aclk => zynq_ultra_ps_e_0_pl_clk0,
      aresetn => proc_sys_reset_0_peripheral_aresetn(0)
    );
smartconnect_1: component memthing_smartconnect_0_1
     port map (
      M00_AXI_araddr(48 downto 0) => smartconnect_1_M00_AXI_ARADDR(48 downto 0),
      M00_AXI_arburst(1 downto 0) => smartconnect_1_M00_AXI_ARBURST(1 downto 0),
      M00_AXI_arcache(3 downto 0) => smartconnect_1_M00_AXI_ARCACHE(3 downto 0),
      M00_AXI_arlen(7 downto 0) => smartconnect_1_M00_AXI_ARLEN(7 downto 0),
      M00_AXI_arlock(0) => smartconnect_1_M00_AXI_ARLOCK(0),
      M00_AXI_arprot(2 downto 0) => smartconnect_1_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arqos(3 downto 0) => smartconnect_1_M00_AXI_ARQOS(3 downto 0),
      M00_AXI_arready => smartconnect_1_M00_AXI_ARREADY,
      M00_AXI_arsize(2 downto 0) => smartconnect_1_M00_AXI_ARSIZE(2 downto 0),
      M00_AXI_arvalid => smartconnect_1_M00_AXI_ARVALID,
      M00_AXI_awaddr(48 downto 0) => smartconnect_1_M00_AXI_AWADDR(48 downto 0),
      M00_AXI_awburst(1 downto 0) => smartconnect_1_M00_AXI_AWBURST(1 downto 0),
      M00_AXI_awcache(3 downto 0) => smartconnect_1_M00_AXI_AWCACHE(3 downto 0),
      M00_AXI_awlen(7 downto 0) => smartconnect_1_M00_AXI_AWLEN(7 downto 0),
      M00_AXI_awlock(0) => smartconnect_1_M00_AXI_AWLOCK(0),
      M00_AXI_awprot(2 downto 0) => smartconnect_1_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awqos(3 downto 0) => smartconnect_1_M00_AXI_AWQOS(3 downto 0),
      M00_AXI_awready => smartconnect_1_M00_AXI_AWREADY,
      M00_AXI_awsize(2 downto 0) => smartconnect_1_M00_AXI_AWSIZE(2 downto 0),
      M00_AXI_awvalid => smartconnect_1_M00_AXI_AWVALID,
      M00_AXI_bready => smartconnect_1_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => smartconnect_1_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => smartconnect_1_M00_AXI_BVALID,
      M00_AXI_rdata(127 downto 0) => smartconnect_1_M00_AXI_RDATA(127 downto 0),
      M00_AXI_rlast => smartconnect_1_M00_AXI_RLAST,
      M00_AXI_rready => smartconnect_1_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => smartconnect_1_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => smartconnect_1_M00_AXI_RVALID,
      M00_AXI_wdata(127 downto 0) => smartconnect_1_M00_AXI_WDATA(127 downto 0),
      M00_AXI_wlast => smartconnect_1_M00_AXI_WLAST,
      M00_AXI_wready => smartconnect_1_M00_AXI_WREADY,
      M00_AXI_wstrb(15 downto 0) => smartconnect_1_M00_AXI_WSTRB(15 downto 0),
      M00_AXI_wvalid => smartconnect_1_M00_AXI_WVALID,
      S00_AXI_araddr(31 downto 0) => axi_dma_1_M_AXI_MM2S_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => axi_dma_1_M_AXI_MM2S_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => axi_dma_1_M_AXI_MM2S_ARCACHE(3 downto 0),
      S00_AXI_arlen(7 downto 0) => axi_dma_1_M_AXI_MM2S_ARLEN(7 downto 0),
      S00_AXI_arlock(0) => '0',
      S00_AXI_arprot(2 downto 0) => axi_dma_1_M_AXI_MM2S_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => B"0000",
      S00_AXI_arready => axi_dma_1_M_AXI_MM2S_ARREADY,
      S00_AXI_arsize(2 downto 0) => axi_dma_1_M_AXI_MM2S_ARSIZE(2 downto 0),
      S00_AXI_arvalid => axi_dma_1_M_AXI_MM2S_ARVALID,
      S00_AXI_rdata(127 downto 0) => axi_dma_1_M_AXI_MM2S_RDATA(127 downto 0),
      S00_AXI_rlast => axi_dma_1_M_AXI_MM2S_RLAST,
      S00_AXI_rready => axi_dma_1_M_AXI_MM2S_RREADY,
      S00_AXI_rresp(1 downto 0) => axi_dma_1_M_AXI_MM2S_RRESP(1 downto 0),
      S00_AXI_rvalid => axi_dma_1_M_AXI_MM2S_RVALID,
      S01_AXI_araddr(31 downto 0) => axi_dma_1_M_AXI_SG_ARADDR(31 downto 0),
      S01_AXI_arburst(1 downto 0) => axi_dma_1_M_AXI_SG_ARBURST(1 downto 0),
      S01_AXI_arcache(3 downto 0) => axi_dma_1_M_AXI_SG_ARCACHE(3 downto 0),
      S01_AXI_arlen(7 downto 0) => axi_dma_1_M_AXI_SG_ARLEN(7 downto 0),
      S01_AXI_arlock(0) => '0',
      S01_AXI_arprot(2 downto 0) => axi_dma_1_M_AXI_SG_ARPROT(2 downto 0),
      S01_AXI_arqos(3 downto 0) => B"0000",
      S01_AXI_arready => axi_dma_1_M_AXI_SG_ARREADY,
      S01_AXI_arsize(2 downto 0) => axi_dma_1_M_AXI_SG_ARSIZE(2 downto 0),
      S01_AXI_arvalid => axi_dma_1_M_AXI_SG_ARVALID,
      S01_AXI_awaddr(31 downto 0) => axi_dma_1_M_AXI_SG_AWADDR(31 downto 0),
      S01_AXI_awburst(1 downto 0) => axi_dma_1_M_AXI_SG_AWBURST(1 downto 0),
      S01_AXI_awcache(3 downto 0) => axi_dma_1_M_AXI_SG_AWCACHE(3 downto 0),
      S01_AXI_awlen(7 downto 0) => axi_dma_1_M_AXI_SG_AWLEN(7 downto 0),
      S01_AXI_awlock(0) => '0',
      S01_AXI_awprot(2 downto 0) => axi_dma_1_M_AXI_SG_AWPROT(2 downto 0),
      S01_AXI_awqos(3 downto 0) => B"0000",
      S01_AXI_awready => axi_dma_1_M_AXI_SG_AWREADY,
      S01_AXI_awsize(2 downto 0) => axi_dma_1_M_AXI_SG_AWSIZE(2 downto 0),
      S01_AXI_awvalid => axi_dma_1_M_AXI_SG_AWVALID,
      S01_AXI_bready => axi_dma_1_M_AXI_SG_BREADY,
      S01_AXI_bresp(1 downto 0) => axi_dma_1_M_AXI_SG_BRESP(1 downto 0),
      S01_AXI_bvalid => axi_dma_1_M_AXI_SG_BVALID,
      S01_AXI_rdata(31 downto 0) => axi_dma_1_M_AXI_SG_RDATA(31 downto 0),
      S01_AXI_rlast => axi_dma_1_M_AXI_SG_RLAST,
      S01_AXI_rready => axi_dma_1_M_AXI_SG_RREADY,
      S01_AXI_rresp(1 downto 0) => axi_dma_1_M_AXI_SG_RRESP(1 downto 0),
      S01_AXI_rvalid => axi_dma_1_M_AXI_SG_RVALID,
      S01_AXI_wdata(31 downto 0) => axi_dma_1_M_AXI_SG_WDATA(31 downto 0),
      S01_AXI_wlast => axi_dma_1_M_AXI_SG_WLAST,
      S01_AXI_wready => axi_dma_1_M_AXI_SG_WREADY,
      S01_AXI_wstrb(3 downto 0) => axi_dma_1_M_AXI_SG_WSTRB(3 downto 0),
      S01_AXI_wvalid => axi_dma_1_M_AXI_SG_WVALID,
      aclk => zynq_ultra_ps_e_0_pl_clk0,
      aresetn => proc_sys_reset_0_peripheral_aresetn(0)
    );
smartconnect_2: component memthing_smartconnect_0_2
     port map (
      M00_AXI_araddr(48 downto 0) => smartconnect_2_M00_AXI_ARADDR(48 downto 0),
      M00_AXI_arburst(1 downto 0) => smartconnect_2_M00_AXI_ARBURST(1 downto 0),
      M00_AXI_arcache(3 downto 0) => smartconnect_2_M00_AXI_ARCACHE(3 downto 0),
      M00_AXI_arlen(7 downto 0) => smartconnect_2_M00_AXI_ARLEN(7 downto 0),
      M00_AXI_arlock(0) => smartconnect_2_M00_AXI_ARLOCK(0),
      M00_AXI_arprot(2 downto 0) => smartconnect_2_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arqos(3 downto 0) => smartconnect_2_M00_AXI_ARQOS(3 downto 0),
      M00_AXI_arready => smartconnect_2_M00_AXI_ARREADY,
      M00_AXI_arsize(2 downto 0) => smartconnect_2_M00_AXI_ARSIZE(2 downto 0),
      M00_AXI_arvalid => smartconnect_2_M00_AXI_ARVALID,
      M00_AXI_awaddr(48 downto 0) => smartconnect_2_M00_AXI_AWADDR(48 downto 0),
      M00_AXI_awburst(1 downto 0) => smartconnect_2_M00_AXI_AWBURST(1 downto 0),
      M00_AXI_awcache(3 downto 0) => smartconnect_2_M00_AXI_AWCACHE(3 downto 0),
      M00_AXI_awlen(7 downto 0) => smartconnect_2_M00_AXI_AWLEN(7 downto 0),
      M00_AXI_awlock(0) => smartconnect_2_M00_AXI_AWLOCK(0),
      M00_AXI_awprot(2 downto 0) => smartconnect_2_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awqos(3 downto 0) => smartconnect_2_M00_AXI_AWQOS(3 downto 0),
      M00_AXI_awready => smartconnect_2_M00_AXI_AWREADY,
      M00_AXI_awsize(2 downto 0) => smartconnect_2_M00_AXI_AWSIZE(2 downto 0),
      M00_AXI_awvalid => smartconnect_2_M00_AXI_AWVALID,
      M00_AXI_bready => smartconnect_2_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => smartconnect_2_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => smartconnect_2_M00_AXI_BVALID,
      M00_AXI_rdata(127 downto 0) => smartconnect_2_M00_AXI_RDATA(127 downto 0),
      M00_AXI_rlast => smartconnect_2_M00_AXI_RLAST,
      M00_AXI_rready => smartconnect_2_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => smartconnect_2_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => smartconnect_2_M00_AXI_RVALID,
      M00_AXI_wdata(127 downto 0) => smartconnect_2_M00_AXI_WDATA(127 downto 0),
      M00_AXI_wlast => smartconnect_2_M00_AXI_WLAST,
      M00_AXI_wready => smartconnect_2_M00_AXI_WREADY,
      M00_AXI_wstrb(15 downto 0) => smartconnect_2_M00_AXI_WSTRB(15 downto 0),
      M00_AXI_wvalid => smartconnect_2_M00_AXI_WVALID,
      S00_AXI_araddr(31 downto 0) => axi_dma_2_M_AXI_SG_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => axi_dma_2_M_AXI_SG_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => axi_dma_2_M_AXI_SG_ARCACHE(3 downto 0),
      S00_AXI_arlen(7 downto 0) => axi_dma_2_M_AXI_SG_ARLEN(7 downto 0),
      S00_AXI_arlock(0) => '0',
      S00_AXI_arprot(2 downto 0) => axi_dma_2_M_AXI_SG_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => B"0000",
      S00_AXI_arready => axi_dma_2_M_AXI_SG_ARREADY,
      S00_AXI_arsize(2 downto 0) => axi_dma_2_M_AXI_SG_ARSIZE(2 downto 0),
      S00_AXI_arvalid => axi_dma_2_M_AXI_SG_ARVALID,
      S00_AXI_awaddr(31 downto 0) => axi_dma_2_M_AXI_SG_AWADDR(31 downto 0),
      S00_AXI_awburst(1 downto 0) => axi_dma_2_M_AXI_SG_AWBURST(1 downto 0),
      S00_AXI_awcache(3 downto 0) => axi_dma_2_M_AXI_SG_AWCACHE(3 downto 0),
      S00_AXI_awlen(7 downto 0) => axi_dma_2_M_AXI_SG_AWLEN(7 downto 0),
      S00_AXI_awlock(0) => '0',
      S00_AXI_awprot(2 downto 0) => axi_dma_2_M_AXI_SG_AWPROT(2 downto 0),
      S00_AXI_awqos(3 downto 0) => B"0000",
      S00_AXI_awready => axi_dma_2_M_AXI_SG_AWREADY,
      S00_AXI_awsize(2 downto 0) => axi_dma_2_M_AXI_SG_AWSIZE(2 downto 0),
      S00_AXI_awvalid => axi_dma_2_M_AXI_SG_AWVALID,
      S00_AXI_bready => axi_dma_2_M_AXI_SG_BREADY,
      S00_AXI_bresp(1 downto 0) => axi_dma_2_M_AXI_SG_BRESP(1 downto 0),
      S00_AXI_bvalid => axi_dma_2_M_AXI_SG_BVALID,
      S00_AXI_rdata(31 downto 0) => axi_dma_2_M_AXI_SG_RDATA(31 downto 0),
      S00_AXI_rlast => axi_dma_2_M_AXI_SG_RLAST,
      S00_AXI_rready => axi_dma_2_M_AXI_SG_RREADY,
      S00_AXI_rresp(1 downto 0) => axi_dma_2_M_AXI_SG_RRESP(1 downto 0),
      S00_AXI_rvalid => axi_dma_2_M_AXI_SG_RVALID,
      S00_AXI_wdata(31 downto 0) => axi_dma_2_M_AXI_SG_WDATA(31 downto 0),
      S00_AXI_wlast => axi_dma_2_M_AXI_SG_WLAST,
      S00_AXI_wready => axi_dma_2_M_AXI_SG_WREADY,
      S00_AXI_wstrb(3 downto 0) => axi_dma_2_M_AXI_SG_WSTRB(3 downto 0),
      S00_AXI_wvalid => axi_dma_2_M_AXI_SG_WVALID,
      S01_AXI_araddr(31 downto 0) => axi_dma_2_M_AXI_MM2S_ARADDR(31 downto 0),
      S01_AXI_arburst(1 downto 0) => axi_dma_2_M_AXI_MM2S_ARBURST(1 downto 0),
      S01_AXI_arcache(3 downto 0) => axi_dma_2_M_AXI_MM2S_ARCACHE(3 downto 0),
      S01_AXI_arlen(7 downto 0) => axi_dma_2_M_AXI_MM2S_ARLEN(7 downto 0),
      S01_AXI_arlock(0) => '0',
      S01_AXI_arprot(2 downto 0) => axi_dma_2_M_AXI_MM2S_ARPROT(2 downto 0),
      S01_AXI_arqos(3 downto 0) => B"0000",
      S01_AXI_arready => axi_dma_2_M_AXI_MM2S_ARREADY,
      S01_AXI_arsize(2 downto 0) => axi_dma_2_M_AXI_MM2S_ARSIZE(2 downto 0),
      S01_AXI_arvalid => axi_dma_2_M_AXI_MM2S_ARVALID,
      S01_AXI_rdata(127 downto 0) => axi_dma_2_M_AXI_MM2S_RDATA(127 downto 0),
      S01_AXI_rlast => axi_dma_2_M_AXI_MM2S_RLAST,
      S01_AXI_rready => axi_dma_2_M_AXI_MM2S_RREADY,
      S01_AXI_rresp(1 downto 0) => axi_dma_2_M_AXI_MM2S_RRESP(1 downto 0),
      S01_AXI_rvalid => axi_dma_2_M_AXI_MM2S_RVALID,
      aclk => zynq_ultra_ps_e_0_pl_clk0,
      aresetn => proc_sys_reset_0_peripheral_aresetn(0)
    );
smartconnect_3: component memthing_smartconnect_2_0
     port map (
      M00_AXI_araddr(48 downto 0) => smartconnect_3_M00_AXI_ARADDR(48 downto 0),
      M00_AXI_arburst(1 downto 0) => smartconnect_3_M00_AXI_ARBURST(1 downto 0),
      M00_AXI_arcache(3 downto 0) => smartconnect_3_M00_AXI_ARCACHE(3 downto 0),
      M00_AXI_arlen(7 downto 0) => smartconnect_3_M00_AXI_ARLEN(7 downto 0),
      M00_AXI_arlock(0) => smartconnect_3_M00_AXI_ARLOCK(0),
      M00_AXI_arprot(2 downto 0) => smartconnect_3_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arqos(3 downto 0) => smartconnect_3_M00_AXI_ARQOS(3 downto 0),
      M00_AXI_arready => smartconnect_3_M00_AXI_ARREADY,
      M00_AXI_arsize(2 downto 0) => smartconnect_3_M00_AXI_ARSIZE(2 downto 0),
      M00_AXI_arvalid => smartconnect_3_M00_AXI_ARVALID,
      M00_AXI_awaddr(48 downto 0) => smartconnect_3_M00_AXI_AWADDR(48 downto 0),
      M00_AXI_awburst(1 downto 0) => smartconnect_3_M00_AXI_AWBURST(1 downto 0),
      M00_AXI_awcache(3 downto 0) => smartconnect_3_M00_AXI_AWCACHE(3 downto 0),
      M00_AXI_awlen(7 downto 0) => smartconnect_3_M00_AXI_AWLEN(7 downto 0),
      M00_AXI_awlock(0) => smartconnect_3_M00_AXI_AWLOCK(0),
      M00_AXI_awprot(2 downto 0) => smartconnect_3_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awqos(3 downto 0) => smartconnect_3_M00_AXI_AWQOS(3 downto 0),
      M00_AXI_awready => smartconnect_3_M00_AXI_AWREADY,
      M00_AXI_awsize(2 downto 0) => smartconnect_3_M00_AXI_AWSIZE(2 downto 0),
      M00_AXI_awvalid => smartconnect_3_M00_AXI_AWVALID,
      M00_AXI_bready => smartconnect_3_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => smartconnect_3_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => smartconnect_3_M00_AXI_BVALID,
      M00_AXI_rdata(127 downto 0) => smartconnect_3_M00_AXI_RDATA(127 downto 0),
      M00_AXI_rlast => smartconnect_3_M00_AXI_RLAST,
      M00_AXI_rready => smartconnect_3_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => smartconnect_3_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => smartconnect_3_M00_AXI_RVALID,
      M00_AXI_wdata(127 downto 0) => smartconnect_3_M00_AXI_WDATA(127 downto 0),
      M00_AXI_wlast => smartconnect_3_M00_AXI_WLAST,
      M00_AXI_wready => smartconnect_3_M00_AXI_WREADY,
      M00_AXI_wstrb(15 downto 0) => smartconnect_3_M00_AXI_WSTRB(15 downto 0),
      M00_AXI_wvalid => smartconnect_3_M00_AXI_WVALID,
      S00_AXI_araddr(31 downto 0) => axi_dma_3_M_AXI_SG_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => axi_dma_3_M_AXI_SG_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => axi_dma_3_M_AXI_SG_ARCACHE(3 downto 0),
      S00_AXI_arlen(7 downto 0) => axi_dma_3_M_AXI_SG_ARLEN(7 downto 0),
      S00_AXI_arlock(0) => '0',
      S00_AXI_arprot(2 downto 0) => axi_dma_3_M_AXI_SG_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => B"0000",
      S00_AXI_arready => axi_dma_3_M_AXI_SG_ARREADY,
      S00_AXI_arsize(2 downto 0) => axi_dma_3_M_AXI_SG_ARSIZE(2 downto 0),
      S00_AXI_arvalid => axi_dma_3_M_AXI_SG_ARVALID,
      S00_AXI_awaddr(31 downto 0) => axi_dma_3_M_AXI_SG_AWADDR(31 downto 0),
      S00_AXI_awburst(1 downto 0) => axi_dma_3_M_AXI_SG_AWBURST(1 downto 0),
      S00_AXI_awcache(3 downto 0) => axi_dma_3_M_AXI_SG_AWCACHE(3 downto 0),
      S00_AXI_awlen(7 downto 0) => axi_dma_3_M_AXI_SG_AWLEN(7 downto 0),
      S00_AXI_awlock(0) => '0',
      S00_AXI_awprot(2 downto 0) => axi_dma_3_M_AXI_SG_AWPROT(2 downto 0),
      S00_AXI_awqos(3 downto 0) => B"0000",
      S00_AXI_awready => axi_dma_3_M_AXI_SG_AWREADY,
      S00_AXI_awsize(2 downto 0) => axi_dma_3_M_AXI_SG_AWSIZE(2 downto 0),
      S00_AXI_awvalid => axi_dma_3_M_AXI_SG_AWVALID,
      S00_AXI_bready => axi_dma_3_M_AXI_SG_BREADY,
      S00_AXI_bresp(1 downto 0) => axi_dma_3_M_AXI_SG_BRESP(1 downto 0),
      S00_AXI_bvalid => axi_dma_3_M_AXI_SG_BVALID,
      S00_AXI_rdata(31 downto 0) => axi_dma_3_M_AXI_SG_RDATA(31 downto 0),
      S00_AXI_rlast => axi_dma_3_M_AXI_SG_RLAST,
      S00_AXI_rready => axi_dma_3_M_AXI_SG_RREADY,
      S00_AXI_rresp(1 downto 0) => axi_dma_3_M_AXI_SG_RRESP(1 downto 0),
      S00_AXI_rvalid => axi_dma_3_M_AXI_SG_RVALID,
      S00_AXI_wdata(31 downto 0) => axi_dma_3_M_AXI_SG_WDATA(31 downto 0),
      S00_AXI_wlast => axi_dma_3_M_AXI_SG_WLAST,
      S00_AXI_wready => axi_dma_3_M_AXI_SG_WREADY,
      S00_AXI_wstrb(3 downto 0) => axi_dma_3_M_AXI_SG_WSTRB(3 downto 0),
      S00_AXI_wvalid => axi_dma_3_M_AXI_SG_WVALID,
      S01_AXI_araddr(31 downto 0) => axi_dma_3_M_AXI_MM2S_ARADDR(31 downto 0),
      S01_AXI_arburst(1 downto 0) => axi_dma_3_M_AXI_MM2S_ARBURST(1 downto 0),
      S01_AXI_arcache(3 downto 0) => axi_dma_3_M_AXI_MM2S_ARCACHE(3 downto 0),
      S01_AXI_arlen(7 downto 0) => axi_dma_3_M_AXI_MM2S_ARLEN(7 downto 0),
      S01_AXI_arlock(0) => '0',
      S01_AXI_arprot(2 downto 0) => axi_dma_3_M_AXI_MM2S_ARPROT(2 downto 0),
      S01_AXI_arqos(3 downto 0) => B"0000",
      S01_AXI_arready => axi_dma_3_M_AXI_MM2S_ARREADY,
      S01_AXI_arsize(2 downto 0) => axi_dma_3_M_AXI_MM2S_ARSIZE(2 downto 0),
      S01_AXI_arvalid => axi_dma_3_M_AXI_MM2S_ARVALID,
      S01_AXI_rdata(127 downto 0) => axi_dma_3_M_AXI_MM2S_RDATA(127 downto 0),
      S01_AXI_rlast => axi_dma_3_M_AXI_MM2S_RLAST,
      S01_AXI_rready => axi_dma_3_M_AXI_MM2S_RREADY,
      S01_AXI_rresp(1 downto 0) => axi_dma_3_M_AXI_MM2S_RRESP(1 downto 0),
      S01_AXI_rvalid => axi_dma_3_M_AXI_MM2S_RVALID,
      aclk => zynq_ultra_ps_e_0_pl_clk0,
      aresetn => proc_sys_reset_0_peripheral_aresetn(0)
    );
smartconnect_4: component memthing_smartconnect_0_3
     port map (
      M00_AXI_araddr(48 downto 0) => smartconnect_4_M00_AXI_ARADDR(48 downto 0),
      M00_AXI_arburst(1 downto 0) => smartconnect_4_M00_AXI_ARBURST(1 downto 0),
      M00_AXI_arcache(3 downto 0) => smartconnect_4_M00_AXI_ARCACHE(3 downto 0),
      M00_AXI_arlen(7 downto 0) => smartconnect_4_M00_AXI_ARLEN(7 downto 0),
      M00_AXI_arlock(0) => smartconnect_4_M00_AXI_ARLOCK(0),
      M00_AXI_arprot(2 downto 0) => smartconnect_4_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arqos(3 downto 0) => smartconnect_4_M00_AXI_ARQOS(3 downto 0),
      M00_AXI_arready => smartconnect_4_M00_AXI_ARREADY,
      M00_AXI_arsize(2 downto 0) => smartconnect_4_M00_AXI_ARSIZE(2 downto 0),
      M00_AXI_arvalid => smartconnect_4_M00_AXI_ARVALID,
      M00_AXI_awaddr(48 downto 0) => smartconnect_4_M00_AXI_AWADDR(48 downto 0),
      M00_AXI_awburst(1 downto 0) => smartconnect_4_M00_AXI_AWBURST(1 downto 0),
      M00_AXI_awcache(3 downto 0) => smartconnect_4_M00_AXI_AWCACHE(3 downto 0),
      M00_AXI_awlen(7 downto 0) => smartconnect_4_M00_AXI_AWLEN(7 downto 0),
      M00_AXI_awlock(0) => smartconnect_4_M00_AXI_AWLOCK(0),
      M00_AXI_awprot(2 downto 0) => smartconnect_4_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awqos(3 downto 0) => smartconnect_4_M00_AXI_AWQOS(3 downto 0),
      M00_AXI_awready => smartconnect_4_M00_AXI_AWREADY,
      M00_AXI_awsize(2 downto 0) => smartconnect_4_M00_AXI_AWSIZE(2 downto 0),
      M00_AXI_awvalid => smartconnect_4_M00_AXI_AWVALID,
      M00_AXI_bready => smartconnect_4_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => smartconnect_4_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => smartconnect_4_M00_AXI_BVALID,
      M00_AXI_rdata(127 downto 0) => smartconnect_4_M00_AXI_RDATA(127 downto 0),
      M00_AXI_rlast => smartconnect_4_M00_AXI_RLAST,
      M00_AXI_rready => smartconnect_4_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => smartconnect_4_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => smartconnect_4_M00_AXI_RVALID,
      M00_AXI_wdata(127 downto 0) => smartconnect_4_M00_AXI_WDATA(127 downto 0),
      M00_AXI_wlast => smartconnect_4_M00_AXI_WLAST,
      M00_AXI_wready => smartconnect_4_M00_AXI_WREADY,
      M00_AXI_wstrb(15 downto 0) => smartconnect_4_M00_AXI_WSTRB(15 downto 0),
      M00_AXI_wvalid => smartconnect_4_M00_AXI_WVALID,
      S00_AXI_araddr(31 downto 0) => axi_dma_4_M_AXI_SG_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => axi_dma_4_M_AXI_SG_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => axi_dma_4_M_AXI_SG_ARCACHE(3 downto 0),
      S00_AXI_arlen(7 downto 0) => axi_dma_4_M_AXI_SG_ARLEN(7 downto 0),
      S00_AXI_arlock(0) => '0',
      S00_AXI_arprot(2 downto 0) => axi_dma_4_M_AXI_SG_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => B"0000",
      S00_AXI_arready => axi_dma_4_M_AXI_SG_ARREADY,
      S00_AXI_arsize(2 downto 0) => axi_dma_4_M_AXI_SG_ARSIZE(2 downto 0),
      S00_AXI_arvalid => axi_dma_4_M_AXI_SG_ARVALID,
      S00_AXI_awaddr(31 downto 0) => axi_dma_4_M_AXI_SG_AWADDR(31 downto 0),
      S00_AXI_awburst(1 downto 0) => axi_dma_4_M_AXI_SG_AWBURST(1 downto 0),
      S00_AXI_awcache(3 downto 0) => axi_dma_4_M_AXI_SG_AWCACHE(3 downto 0),
      S00_AXI_awlen(7 downto 0) => axi_dma_4_M_AXI_SG_AWLEN(7 downto 0),
      S00_AXI_awlock(0) => '0',
      S00_AXI_awprot(2 downto 0) => axi_dma_4_M_AXI_SG_AWPROT(2 downto 0),
      S00_AXI_awqos(3 downto 0) => B"0000",
      S00_AXI_awready => axi_dma_4_M_AXI_SG_AWREADY,
      S00_AXI_awsize(2 downto 0) => axi_dma_4_M_AXI_SG_AWSIZE(2 downto 0),
      S00_AXI_awvalid => axi_dma_4_M_AXI_SG_AWVALID,
      S00_AXI_bready => axi_dma_4_M_AXI_SG_BREADY,
      S00_AXI_bresp(1 downto 0) => axi_dma_4_M_AXI_SG_BRESP(1 downto 0),
      S00_AXI_bvalid => axi_dma_4_M_AXI_SG_BVALID,
      S00_AXI_rdata(31 downto 0) => axi_dma_4_M_AXI_SG_RDATA(31 downto 0),
      S00_AXI_rlast => axi_dma_4_M_AXI_SG_RLAST,
      S00_AXI_rready => axi_dma_4_M_AXI_SG_RREADY,
      S00_AXI_rresp(1 downto 0) => axi_dma_4_M_AXI_SG_RRESP(1 downto 0),
      S00_AXI_rvalid => axi_dma_4_M_AXI_SG_RVALID,
      S00_AXI_wdata(31 downto 0) => axi_dma_4_M_AXI_SG_WDATA(31 downto 0),
      S00_AXI_wlast => axi_dma_4_M_AXI_SG_WLAST,
      S00_AXI_wready => axi_dma_4_M_AXI_SG_WREADY,
      S00_AXI_wstrb(3 downto 0) => axi_dma_4_M_AXI_SG_WSTRB(3 downto 0),
      S00_AXI_wvalid => axi_dma_4_M_AXI_SG_WVALID,
      S01_AXI_araddr(31 downto 0) => axi_dma_4_M_AXI_MM2S_ARADDR(31 downto 0),
      S01_AXI_arburst(1 downto 0) => axi_dma_4_M_AXI_MM2S_ARBURST(1 downto 0),
      S01_AXI_arcache(3 downto 0) => axi_dma_4_M_AXI_MM2S_ARCACHE(3 downto 0),
      S01_AXI_arlen(7 downto 0) => axi_dma_4_M_AXI_MM2S_ARLEN(7 downto 0),
      S01_AXI_arlock(0) => '0',
      S01_AXI_arprot(2 downto 0) => axi_dma_4_M_AXI_MM2S_ARPROT(2 downto 0),
      S01_AXI_arqos(3 downto 0) => B"0000",
      S01_AXI_arready => axi_dma_4_M_AXI_MM2S_ARREADY,
      S01_AXI_arsize(2 downto 0) => axi_dma_4_M_AXI_MM2S_ARSIZE(2 downto 0),
      S01_AXI_arvalid => axi_dma_4_M_AXI_MM2S_ARVALID,
      S01_AXI_rdata(127 downto 0) => axi_dma_4_M_AXI_MM2S_RDATA(127 downto 0),
      S01_AXI_rlast => axi_dma_4_M_AXI_MM2S_RLAST,
      S01_AXI_rready => axi_dma_4_M_AXI_MM2S_RREADY,
      S01_AXI_rresp(1 downto 0) => axi_dma_4_M_AXI_MM2S_RRESP(1 downto 0),
      S01_AXI_rvalid => axi_dma_4_M_AXI_MM2S_RVALID,
      S02_AXI_awaddr(31 downto 0) => axi_dma_4_M_AXI_S2MM_AWADDR(31 downto 0),
      S02_AXI_awburst(1 downto 0) => axi_dma_4_M_AXI_S2MM_AWBURST(1 downto 0),
      S02_AXI_awcache(3 downto 0) => axi_dma_4_M_AXI_S2MM_AWCACHE(3 downto 0),
      S02_AXI_awlen(7 downto 0) => axi_dma_4_M_AXI_S2MM_AWLEN(7 downto 0),
      S02_AXI_awlock(0) => '0',
      S02_AXI_awprot(2 downto 0) => axi_dma_4_M_AXI_S2MM_AWPROT(2 downto 0),
      S02_AXI_awqos(3 downto 0) => B"0000",
      S02_AXI_awready => axi_dma_4_M_AXI_S2MM_AWREADY,
      S02_AXI_awsize(2 downto 0) => axi_dma_4_M_AXI_S2MM_AWSIZE(2 downto 0),
      S02_AXI_awvalid => axi_dma_4_M_AXI_S2MM_AWVALID,
      S02_AXI_bready => axi_dma_4_M_AXI_S2MM_BREADY,
      S02_AXI_bresp(1 downto 0) => axi_dma_4_M_AXI_S2MM_BRESP(1 downto 0),
      S02_AXI_bvalid => axi_dma_4_M_AXI_S2MM_BVALID,
      S02_AXI_wdata(127 downto 0) => axi_dma_4_M_AXI_S2MM_WDATA(127 downto 0),
      S02_AXI_wlast => axi_dma_4_M_AXI_S2MM_WLAST,
      S02_AXI_wready => axi_dma_4_M_AXI_S2MM_WREADY,
      S02_AXI_wstrb(15 downto 0) => axi_dma_4_M_AXI_S2MM_WSTRB(15 downto 0),
      S02_AXI_wvalid => axi_dma_4_M_AXI_S2MM_WVALID,
      aclk => zynq_ultra_ps_e_0_pl_clk0,
      aresetn => proc_sys_reset_0_peripheral_aresetn(0)
    );
xlconcat_0: component memthing_xlconcat_0_0
     port map (
      In0(0) => axi_dma_4_mm2s_introut,
      In1(0) => axi_dma_4_s2mm_introut,
      In2(0) => axi_dma_0_mm2s_introut,
      In3(0) => axi_dma_1_mm2s_introut,
      In4(0) => axi_dma_2_mm2s_introut,
      In5(0) => axi_dma_3_mm2s_introut,
      dout(5 downto 0) => xlconcat_0_dout(5 downto 0)
    );
xlconstant_0: component memthing_xlconstant_0_1
     port map (
      dout(0) => xlconstant_0_dout(0)
    );
zynq_ultra_ps_e_0: component memthing_zynq_ultra_ps_e_0_0
     port map (
      maxigp0_araddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARADDR(39 downto 0),
      maxigp0_arburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARBURST(1 downto 0),
      maxigp0_arcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARCACHE(3 downto 0),
      maxigp0_arid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARID(15 downto 0),
      maxigp0_arlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLEN(7 downto 0),
      maxigp0_arlock => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARLOCK,
      maxigp0_arprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARPROT(2 downto 0),
      maxigp0_arqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARQOS(3 downto 0),
      maxigp0_arready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARREADY,
      maxigp0_arsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARSIZE(2 downto 0),
      maxigp0_aruser(15 downto 0) => NLW_zynq_ultra_ps_e_0_maxigp0_aruser_UNCONNECTED(15 downto 0),
      maxigp0_arvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_ARVALID,
      maxigp0_awaddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWADDR(39 downto 0),
      maxigp0_awburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWBURST(1 downto 0),
      maxigp0_awcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWCACHE(3 downto 0),
      maxigp0_awid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWID(15 downto 0),
      maxigp0_awlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLEN(7 downto 0),
      maxigp0_awlock => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWLOCK,
      maxigp0_awprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWPROT(2 downto 0),
      maxigp0_awqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWQOS(3 downto 0),
      maxigp0_awready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWREADY,
      maxigp0_awsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWSIZE(2 downto 0),
      maxigp0_awuser(15 downto 0) => NLW_zynq_ultra_ps_e_0_maxigp0_awuser_UNCONNECTED(15 downto 0),
      maxigp0_awvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_AWVALID,
      maxigp0_bid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BID(15 downto 0),
      maxigp0_bready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BREADY,
      maxigp0_bresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BRESP(1 downto 0),
      maxigp0_bvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_BVALID,
      maxigp0_rdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RDATA(127 downto 0),
      maxigp0_rid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RID(15 downto 0),
      maxigp0_rlast => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RLAST,
      maxigp0_rready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RREADY,
      maxigp0_rresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RRESP(1 downto 0),
      maxigp0_rvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_RVALID,
      maxigp0_wdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WDATA(127 downto 0),
      maxigp0_wlast => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WLAST,
      maxigp0_wready => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WREADY,
      maxigp0_wstrb(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WSTRB(15 downto 0),
      maxigp0_wvalid => zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_WVALID,
      maxigp1_araddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARADDR(39 downto 0),
      maxigp1_arburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARBURST(1 downto 0),
      maxigp1_arcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARCACHE(3 downto 0),
      maxigp1_arid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARID(15 downto 0),
      maxigp1_arlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARLEN(7 downto 0),
      maxigp1_arlock => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARLOCK,
      maxigp1_arprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARPROT(2 downto 0),
      maxigp1_arqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARQOS(3 downto 0),
      maxigp1_arready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARREADY,
      maxigp1_arsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARSIZE(2 downto 0),
      maxigp1_aruser(15 downto 0) => NLW_zynq_ultra_ps_e_0_maxigp1_aruser_UNCONNECTED(15 downto 0),
      maxigp1_arvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_ARVALID,
      maxigp1_awaddr(39 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWADDR(39 downto 0),
      maxigp1_awburst(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWBURST(1 downto 0),
      maxigp1_awcache(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWCACHE(3 downto 0),
      maxigp1_awid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWID(15 downto 0),
      maxigp1_awlen(7 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWLEN(7 downto 0),
      maxigp1_awlock => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWLOCK,
      maxigp1_awprot(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWPROT(2 downto 0),
      maxigp1_awqos(3 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWQOS(3 downto 0),
      maxigp1_awready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWREADY,
      maxigp1_awsize(2 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWSIZE(2 downto 0),
      maxigp1_awuser(15 downto 0) => NLW_zynq_ultra_ps_e_0_maxigp1_awuser_UNCONNECTED(15 downto 0),
      maxigp1_awvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_AWVALID,
      maxigp1_bid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BID(15 downto 0),
      maxigp1_bready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BREADY,
      maxigp1_bresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BRESP(1 downto 0),
      maxigp1_bvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_BVALID,
      maxigp1_rdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RDATA(127 downto 0),
      maxigp1_rid(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RID(15 downto 0),
      maxigp1_rlast => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RLAST,
      maxigp1_rready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RREADY,
      maxigp1_rresp(1 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RRESP(1 downto 0),
      maxigp1_rvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_RVALID,
      maxigp1_wdata(127 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WDATA(127 downto 0),
      maxigp1_wlast => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WLAST,
      maxigp1_wready => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WREADY,
      maxigp1_wstrb(15 downto 0) => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WSTRB(15 downto 0),
      maxigp1_wvalid => zynq_ultra_ps_e_0_M_AXI_HPM1_FPD_WVALID,
      maxihpm0_fpd_aclk => zynq_ultra_ps_e_0_pl_clk0,
      maxihpm1_fpd_aclk => zynq_ultra_ps_e_0_pl_clk0,
      pl_clk0 => zynq_ultra_ps_e_0_pl_clk0,
      pl_ps_irq0(5 downto 0) => xlconcat_0_dout(5 downto 0),
      pl_resetn0 => zynq_ultra_ps_e_0_pl_resetn0,
      saxigp0_araddr(48 downto 0) => smartconnect_4_M00_AXI_ARADDR(48 downto 0),
      saxigp0_arburst(1 downto 0) => smartconnect_4_M00_AXI_ARBURST(1 downto 0),
      saxigp0_arcache(3 downto 0) => smartconnect_4_M00_AXI_ARCACHE(3 downto 0),
      saxigp0_arid(5 downto 0) => B"000000",
      saxigp0_arlen(7 downto 0) => smartconnect_4_M00_AXI_ARLEN(7 downto 0),
      saxigp0_arlock => smartconnect_4_M00_AXI_ARLOCK(0),
      saxigp0_arprot(2 downto 0) => smartconnect_4_M00_AXI_ARPROT(2 downto 0),
      saxigp0_arqos(3 downto 0) => smartconnect_4_M00_AXI_ARQOS(3 downto 0),
      saxigp0_arready => smartconnect_4_M00_AXI_ARREADY,
      saxigp0_arsize(2 downto 0) => smartconnect_4_M00_AXI_ARSIZE(2 downto 0),
      saxigp0_aruser => '0',
      saxigp0_arvalid => smartconnect_4_M00_AXI_ARVALID,
      saxigp0_awaddr(48 downto 0) => smartconnect_4_M00_AXI_AWADDR(48 downto 0),
      saxigp0_awburst(1 downto 0) => smartconnect_4_M00_AXI_AWBURST(1 downto 0),
      saxigp0_awcache(3 downto 0) => smartconnect_4_M00_AXI_AWCACHE(3 downto 0),
      saxigp0_awid(5 downto 0) => B"000000",
      saxigp0_awlen(7 downto 0) => smartconnect_4_M00_AXI_AWLEN(7 downto 0),
      saxigp0_awlock => smartconnect_4_M00_AXI_AWLOCK(0),
      saxigp0_awprot(2 downto 0) => smartconnect_4_M00_AXI_AWPROT(2 downto 0),
      saxigp0_awqos(3 downto 0) => smartconnect_4_M00_AXI_AWQOS(3 downto 0),
      saxigp0_awready => smartconnect_4_M00_AXI_AWREADY,
      saxigp0_awsize(2 downto 0) => smartconnect_4_M00_AXI_AWSIZE(2 downto 0),
      saxigp0_awuser => '0',
      saxigp0_awvalid => smartconnect_4_M00_AXI_AWVALID,
      saxigp0_bid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp0_bid_UNCONNECTED(5 downto 0),
      saxigp0_bready => smartconnect_4_M00_AXI_BREADY,
      saxigp0_bresp(1 downto 0) => smartconnect_4_M00_AXI_BRESP(1 downto 0),
      saxigp0_bvalid => smartconnect_4_M00_AXI_BVALID,
      saxigp0_rdata(127 downto 0) => smartconnect_4_M00_AXI_RDATA(127 downto 0),
      saxigp0_rid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp0_rid_UNCONNECTED(5 downto 0),
      saxigp0_rlast => smartconnect_4_M00_AXI_RLAST,
      saxigp0_rready => smartconnect_4_M00_AXI_RREADY,
      saxigp0_rresp(1 downto 0) => smartconnect_4_M00_AXI_RRESP(1 downto 0),
      saxigp0_rvalid => smartconnect_4_M00_AXI_RVALID,
      saxigp0_wdata(127 downto 0) => smartconnect_4_M00_AXI_WDATA(127 downto 0),
      saxigp0_wlast => smartconnect_4_M00_AXI_WLAST,
      saxigp0_wready => smartconnect_4_M00_AXI_WREADY,
      saxigp0_wstrb(15 downto 0) => smartconnect_4_M00_AXI_WSTRB(15 downto 0),
      saxigp0_wvalid => smartconnect_4_M00_AXI_WVALID,
      saxigp2_araddr(48 downto 0) => smartconnect_0_M00_AXI_ARADDR(48 downto 0),
      saxigp2_arburst(1 downto 0) => smartconnect_0_M00_AXI_ARBURST(1 downto 0),
      saxigp2_arcache(3 downto 0) => smartconnect_0_M00_AXI_ARCACHE(3 downto 0),
      saxigp2_arid(5 downto 0) => B"000000",
      saxigp2_arlen(7 downto 0) => smartconnect_0_M00_AXI_ARLEN(7 downto 0),
      saxigp2_arlock => smartconnect_0_M00_AXI_ARLOCK(0),
      saxigp2_arprot(2 downto 0) => smartconnect_0_M00_AXI_ARPROT(2 downto 0),
      saxigp2_arqos(3 downto 0) => smartconnect_0_M00_AXI_ARQOS(3 downto 0),
      saxigp2_arready => smartconnect_0_M00_AXI_ARREADY,
      saxigp2_arsize(2 downto 0) => smartconnect_0_M00_AXI_ARSIZE(2 downto 0),
      saxigp2_aruser => '0',
      saxigp2_arvalid => smartconnect_0_M00_AXI_ARVALID,
      saxigp2_awaddr(48 downto 0) => smartconnect_0_M00_AXI_AWADDR(48 downto 0),
      saxigp2_awburst(1 downto 0) => smartconnect_0_M00_AXI_AWBURST(1 downto 0),
      saxigp2_awcache(3 downto 0) => smartconnect_0_M00_AXI_AWCACHE(3 downto 0),
      saxigp2_awid(5 downto 0) => B"000000",
      saxigp2_awlen(7 downto 0) => smartconnect_0_M00_AXI_AWLEN(7 downto 0),
      saxigp2_awlock => smartconnect_0_M00_AXI_AWLOCK(0),
      saxigp2_awprot(2 downto 0) => smartconnect_0_M00_AXI_AWPROT(2 downto 0),
      saxigp2_awqos(3 downto 0) => smartconnect_0_M00_AXI_AWQOS(3 downto 0),
      saxigp2_awready => smartconnect_0_M00_AXI_AWREADY,
      saxigp2_awsize(2 downto 0) => smartconnect_0_M00_AXI_AWSIZE(2 downto 0),
      saxigp2_awuser => '0',
      saxigp2_awvalid => smartconnect_0_M00_AXI_AWVALID,
      saxigp2_bid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp2_bid_UNCONNECTED(5 downto 0),
      saxigp2_bready => smartconnect_0_M00_AXI_BREADY,
      saxigp2_bresp(1 downto 0) => smartconnect_0_M00_AXI_BRESP(1 downto 0),
      saxigp2_bvalid => smartconnect_0_M00_AXI_BVALID,
      saxigp2_rdata(127 downto 0) => smartconnect_0_M00_AXI_RDATA(127 downto 0),
      saxigp2_rid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp2_rid_UNCONNECTED(5 downto 0),
      saxigp2_rlast => smartconnect_0_M00_AXI_RLAST,
      saxigp2_rready => smartconnect_0_M00_AXI_RREADY,
      saxigp2_rresp(1 downto 0) => smartconnect_0_M00_AXI_RRESP(1 downto 0),
      saxigp2_rvalid => smartconnect_0_M00_AXI_RVALID,
      saxigp2_wdata(127 downto 0) => smartconnect_0_M00_AXI_WDATA(127 downto 0),
      saxigp2_wlast => smartconnect_0_M00_AXI_WLAST,
      saxigp2_wready => smartconnect_0_M00_AXI_WREADY,
      saxigp2_wstrb(15 downto 0) => smartconnect_0_M00_AXI_WSTRB(15 downto 0),
      saxigp2_wvalid => smartconnect_0_M00_AXI_WVALID,
      saxigp3_araddr(48 downto 0) => smartconnect_1_M00_AXI_ARADDR(48 downto 0),
      saxigp3_arburst(1 downto 0) => smartconnect_1_M00_AXI_ARBURST(1 downto 0),
      saxigp3_arcache(3 downto 0) => smartconnect_1_M00_AXI_ARCACHE(3 downto 0),
      saxigp3_arid(5 downto 0) => B"000000",
      saxigp3_arlen(7 downto 0) => smartconnect_1_M00_AXI_ARLEN(7 downto 0),
      saxigp3_arlock => smartconnect_1_M00_AXI_ARLOCK(0),
      saxigp3_arprot(2 downto 0) => smartconnect_1_M00_AXI_ARPROT(2 downto 0),
      saxigp3_arqos(3 downto 0) => smartconnect_1_M00_AXI_ARQOS(3 downto 0),
      saxigp3_arready => smartconnect_1_M00_AXI_ARREADY,
      saxigp3_arsize(2 downto 0) => smartconnect_1_M00_AXI_ARSIZE(2 downto 0),
      saxigp3_aruser => '0',
      saxigp3_arvalid => smartconnect_1_M00_AXI_ARVALID,
      saxigp3_awaddr(48 downto 0) => smartconnect_1_M00_AXI_AWADDR(48 downto 0),
      saxigp3_awburst(1 downto 0) => smartconnect_1_M00_AXI_AWBURST(1 downto 0),
      saxigp3_awcache(3 downto 0) => smartconnect_1_M00_AXI_AWCACHE(3 downto 0),
      saxigp3_awid(5 downto 0) => B"000000",
      saxigp3_awlen(7 downto 0) => smartconnect_1_M00_AXI_AWLEN(7 downto 0),
      saxigp3_awlock => smartconnect_1_M00_AXI_AWLOCK(0),
      saxigp3_awprot(2 downto 0) => smartconnect_1_M00_AXI_AWPROT(2 downto 0),
      saxigp3_awqos(3 downto 0) => smartconnect_1_M00_AXI_AWQOS(3 downto 0),
      saxigp3_awready => smartconnect_1_M00_AXI_AWREADY,
      saxigp3_awsize(2 downto 0) => smartconnect_1_M00_AXI_AWSIZE(2 downto 0),
      saxigp3_awuser => '0',
      saxigp3_awvalid => smartconnect_1_M00_AXI_AWVALID,
      saxigp3_bid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp3_bid_UNCONNECTED(5 downto 0),
      saxigp3_bready => smartconnect_1_M00_AXI_BREADY,
      saxigp3_bresp(1 downto 0) => smartconnect_1_M00_AXI_BRESP(1 downto 0),
      saxigp3_bvalid => smartconnect_1_M00_AXI_BVALID,
      saxigp3_rdata(127 downto 0) => smartconnect_1_M00_AXI_RDATA(127 downto 0),
      saxigp3_rid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp3_rid_UNCONNECTED(5 downto 0),
      saxigp3_rlast => smartconnect_1_M00_AXI_RLAST,
      saxigp3_rready => smartconnect_1_M00_AXI_RREADY,
      saxigp3_rresp(1 downto 0) => smartconnect_1_M00_AXI_RRESP(1 downto 0),
      saxigp3_rvalid => smartconnect_1_M00_AXI_RVALID,
      saxigp3_wdata(127 downto 0) => smartconnect_1_M00_AXI_WDATA(127 downto 0),
      saxigp3_wlast => smartconnect_1_M00_AXI_WLAST,
      saxigp3_wready => smartconnect_1_M00_AXI_WREADY,
      saxigp3_wstrb(15 downto 0) => smartconnect_1_M00_AXI_WSTRB(15 downto 0),
      saxigp3_wvalid => smartconnect_1_M00_AXI_WVALID,
      saxigp4_araddr(48 downto 0) => smartconnect_2_M00_AXI_ARADDR(48 downto 0),
      saxigp4_arburst(1 downto 0) => smartconnect_2_M00_AXI_ARBURST(1 downto 0),
      saxigp4_arcache(3 downto 0) => smartconnect_2_M00_AXI_ARCACHE(3 downto 0),
      saxigp4_arid(5 downto 0) => B"000000",
      saxigp4_arlen(7 downto 0) => smartconnect_2_M00_AXI_ARLEN(7 downto 0),
      saxigp4_arlock => smartconnect_2_M00_AXI_ARLOCK(0),
      saxigp4_arprot(2 downto 0) => smartconnect_2_M00_AXI_ARPROT(2 downto 0),
      saxigp4_arqos(3 downto 0) => smartconnect_2_M00_AXI_ARQOS(3 downto 0),
      saxigp4_arready => smartconnect_2_M00_AXI_ARREADY,
      saxigp4_arsize(2 downto 0) => smartconnect_2_M00_AXI_ARSIZE(2 downto 0),
      saxigp4_aruser => '0',
      saxigp4_arvalid => smartconnect_2_M00_AXI_ARVALID,
      saxigp4_awaddr(48 downto 0) => smartconnect_2_M00_AXI_AWADDR(48 downto 0),
      saxigp4_awburst(1 downto 0) => smartconnect_2_M00_AXI_AWBURST(1 downto 0),
      saxigp4_awcache(3 downto 0) => smartconnect_2_M00_AXI_AWCACHE(3 downto 0),
      saxigp4_awid(5 downto 0) => B"000000",
      saxigp4_awlen(7 downto 0) => smartconnect_2_M00_AXI_AWLEN(7 downto 0),
      saxigp4_awlock => smartconnect_2_M00_AXI_AWLOCK(0),
      saxigp4_awprot(2 downto 0) => smartconnect_2_M00_AXI_AWPROT(2 downto 0),
      saxigp4_awqos(3 downto 0) => smartconnect_2_M00_AXI_AWQOS(3 downto 0),
      saxigp4_awready => smartconnect_2_M00_AXI_AWREADY,
      saxigp4_awsize(2 downto 0) => smartconnect_2_M00_AXI_AWSIZE(2 downto 0),
      saxigp4_awuser => '0',
      saxigp4_awvalid => smartconnect_2_M00_AXI_AWVALID,
      saxigp4_bid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp4_bid_UNCONNECTED(5 downto 0),
      saxigp4_bready => smartconnect_2_M00_AXI_BREADY,
      saxigp4_bresp(1 downto 0) => smartconnect_2_M00_AXI_BRESP(1 downto 0),
      saxigp4_bvalid => smartconnect_2_M00_AXI_BVALID,
      saxigp4_rdata(127 downto 0) => smartconnect_2_M00_AXI_RDATA(127 downto 0),
      saxigp4_rid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp4_rid_UNCONNECTED(5 downto 0),
      saxigp4_rlast => smartconnect_2_M00_AXI_RLAST,
      saxigp4_rready => smartconnect_2_M00_AXI_RREADY,
      saxigp4_rresp(1 downto 0) => smartconnect_2_M00_AXI_RRESP(1 downto 0),
      saxigp4_rvalid => smartconnect_2_M00_AXI_RVALID,
      saxigp4_wdata(127 downto 0) => smartconnect_2_M00_AXI_WDATA(127 downto 0),
      saxigp4_wlast => smartconnect_2_M00_AXI_WLAST,
      saxigp4_wready => smartconnect_2_M00_AXI_WREADY,
      saxigp4_wstrb(15 downto 0) => smartconnect_2_M00_AXI_WSTRB(15 downto 0),
      saxigp4_wvalid => smartconnect_2_M00_AXI_WVALID,
      saxigp5_araddr(48 downto 0) => smartconnect_3_M00_AXI_ARADDR(48 downto 0),
      saxigp5_arburst(1 downto 0) => smartconnect_3_M00_AXI_ARBURST(1 downto 0),
      saxigp5_arcache(3 downto 0) => smartconnect_3_M00_AXI_ARCACHE(3 downto 0),
      saxigp5_arid(5 downto 0) => B"000000",
      saxigp5_arlen(7 downto 0) => smartconnect_3_M00_AXI_ARLEN(7 downto 0),
      saxigp5_arlock => smartconnect_3_M00_AXI_ARLOCK(0),
      saxigp5_arprot(2 downto 0) => smartconnect_3_M00_AXI_ARPROT(2 downto 0),
      saxigp5_arqos(3 downto 0) => smartconnect_3_M00_AXI_ARQOS(3 downto 0),
      saxigp5_arready => smartconnect_3_M00_AXI_ARREADY,
      saxigp5_arsize(2 downto 0) => smartconnect_3_M00_AXI_ARSIZE(2 downto 0),
      saxigp5_aruser => '0',
      saxigp5_arvalid => smartconnect_3_M00_AXI_ARVALID,
      saxigp5_awaddr(48 downto 0) => smartconnect_3_M00_AXI_AWADDR(48 downto 0),
      saxigp5_awburst(1 downto 0) => smartconnect_3_M00_AXI_AWBURST(1 downto 0),
      saxigp5_awcache(3 downto 0) => smartconnect_3_M00_AXI_AWCACHE(3 downto 0),
      saxigp5_awid(5 downto 0) => B"000000",
      saxigp5_awlen(7 downto 0) => smartconnect_3_M00_AXI_AWLEN(7 downto 0),
      saxigp5_awlock => smartconnect_3_M00_AXI_AWLOCK(0),
      saxigp5_awprot(2 downto 0) => smartconnect_3_M00_AXI_AWPROT(2 downto 0),
      saxigp5_awqos(3 downto 0) => smartconnect_3_M00_AXI_AWQOS(3 downto 0),
      saxigp5_awready => smartconnect_3_M00_AXI_AWREADY,
      saxigp5_awsize(2 downto 0) => smartconnect_3_M00_AXI_AWSIZE(2 downto 0),
      saxigp5_awuser => '0',
      saxigp5_awvalid => smartconnect_3_M00_AXI_AWVALID,
      saxigp5_bid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp5_bid_UNCONNECTED(5 downto 0),
      saxigp5_bready => smartconnect_3_M00_AXI_BREADY,
      saxigp5_bresp(1 downto 0) => smartconnect_3_M00_AXI_BRESP(1 downto 0),
      saxigp5_bvalid => smartconnect_3_M00_AXI_BVALID,
      saxigp5_rdata(127 downto 0) => smartconnect_3_M00_AXI_RDATA(127 downto 0),
      saxigp5_rid(5 downto 0) => NLW_zynq_ultra_ps_e_0_saxigp5_rid_UNCONNECTED(5 downto 0),
      saxigp5_rlast => smartconnect_3_M00_AXI_RLAST,
      saxigp5_rready => smartconnect_3_M00_AXI_RREADY,
      saxigp5_rresp(1 downto 0) => smartconnect_3_M00_AXI_RRESP(1 downto 0),
      saxigp5_rvalid => smartconnect_3_M00_AXI_RVALID,
      saxigp5_wdata(127 downto 0) => smartconnect_3_M00_AXI_WDATA(127 downto 0),
      saxigp5_wlast => smartconnect_3_M00_AXI_WLAST,
      saxigp5_wready => smartconnect_3_M00_AXI_WREADY,
      saxigp5_wstrb(15 downto 0) => smartconnect_3_M00_AXI_WSTRB(15 downto 0),
      saxigp5_wvalid => smartconnect_3_M00_AXI_WVALID,
      saxihp0_fpd_aclk => zynq_ultra_ps_e_0_pl_clk0,
      saxihp1_fpd_aclk => zynq_ultra_ps_e_0_pl_clk0,
      saxihp2_fpd_aclk => zynq_ultra_ps_e_0_pl_clk0,
      saxihp3_fpd_aclk => zynq_ultra_ps_e_0_pl_clk0,
      saxihpc0_fpd_aclk => zynq_ultra_ps_e_0_pl_clk0
    );
end STRUCTURE;
