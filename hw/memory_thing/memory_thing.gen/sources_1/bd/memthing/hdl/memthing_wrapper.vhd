--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
--Date        : Mon Nov  2 19:44:50 2026
--Host        : 1850-B302S102 running 64-bit major release  (build 9200)
--Command     : generate_target memthing_wrapper.bd
--Design      : memthing_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity memthing_wrapper is
end memthing_wrapper;

architecture STRUCTURE of memthing_wrapper is
  component memthing is
  end component memthing;
begin
memthing_i: component memthing
 ;
end STRUCTURE;
