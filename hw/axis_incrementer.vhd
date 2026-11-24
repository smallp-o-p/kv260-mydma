-- axis_incrementer: adds 1 to every 32-bit word of an AXI4-Stream and passes
-- it on. A test block: with it between a DMA's MM2S and S2MM, every word read
-- back should be the word sent plus 1.
--
-- DATA_WIDTH is the stream width in bits, a multiple of 32. The default 32
-- is the original memory_thing design; set it to 128 for the multi_hp
-- weight lanes (Vivado: double-click the module in the block design). Each
-- 32-bit lane is incremented on its own, with no carry between lanes, so
-- the check is the same at any width: out[i] = in[i] + 1 per 32-bit word.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axis_incrementer is
    generic (
        DATA_WIDTH : integer := 32
    );
    port (
        axis_aclk : in std_logic;
        aresetn       : in  std_logic;
        s_axis_tdata  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        s_axis_tkeep  : in  std_logic_vector(DATA_WIDTH/8-1 downto 0);
        s_axis_tvalid : in  std_logic;
        s_axis_tready : out std_logic;
        s_axis_tlast  : in  std_logic;
        m_axis_tdata  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        m_axis_tkeep  : out std_logic_vector(DATA_WIDTH/8-1 downto 0);
        m_axis_tvalid : out std_logic;
        m_axis_tready : in  std_logic;
        m_axis_tlast  : out std_logic
    );
    attribute X_INTERFACE_INFO : string;
    attribute X_INTERFACE_PARAMETER : string;

    attribute X_INTERFACE_INFO of axis_aclk : signal is
        "xilinx.com:signal:clock:1.0 axis_aclk CLK";

    attribute X_INTERFACE_PARAMETER of axis_aclk : signal is
        "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET aresetn";
end entity;

architecture rtl of axis_incrementer is
begin
    lanes : for i in 0 to DATA_WIDTH/32 - 1 generate
        m_axis_tdata(32*i+31 downto 32*i) <=
            std_logic_vector(unsigned(s_axis_tdata(32*i+31 downto 32*i)) + 1);
    end generate;
    m_axis_tkeep  <= s_axis_tkeep;
    m_axis_tlast  <= s_axis_tlast;
    m_axis_tvalid <= s_axis_tvalid and aresetn;
    s_axis_tready <= m_axis_tready and aresetn;
end architecture;
