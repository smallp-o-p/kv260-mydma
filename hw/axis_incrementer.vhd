library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axis_incrementer is
    port (
        axis_aclk : in std_logic;
        aresetn       : in  std_logic;
        s_axis_tdata  : in  std_logic_vector(31 downto 0);
        s_axis_tkeep  : in  std_logic_vector(3 downto 0);
        s_axis_tvalid : in  std_logic;
        s_axis_tready : out std_logic;
        s_axis_tlast  : in  std_logic;
        m_axis_tdata  : out std_logic_vector(31 downto 0);
        m_axis_tkeep  : out std_logic_vector(3 downto 0);
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
    m_axis_tdata  <= std_logic_vector(unsigned(s_axis_tdata) + 1);
    m_axis_tkeep  <= s_axis_tkeep;
    m_axis_tlast  <= s_axis_tlast;
    m_axis_tvalid <= s_axis_tvalid and aresetn;
    s_axis_tready <= m_axis_tready and aresetn;
end architecture;
