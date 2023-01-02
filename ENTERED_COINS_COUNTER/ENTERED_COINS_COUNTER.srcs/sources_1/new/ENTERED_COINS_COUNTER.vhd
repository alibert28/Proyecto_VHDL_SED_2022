library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ENTERED_COINS_COUNTER is
port(
    reset : in std_logic;
    CLK     : in std_logic;
    IN_C    : in std_logic;
    COUNT   : out std_logic_vector(3 downto 0)
);
end ENTERED_COINS_COUNTER;

architecture Behavioral of ENTERED_COINS_COUNTER is

constant clk_freq    : INTEGER := 100000000;
constant stable_time : INTEGER := 10;

signal signal_1 : std_logic;
signal signal_2 : std_logic;
signal signal_3 : std_logic;

component SYNCHRONIZER
port(
    signal reset :  in std_logic;
    signal clk     :  in std_logic;
    signal data_ns :  in std_logic;
    signal data_s  : out std_logic
);
end component;

component DEBOUNCE
  GENERIC(
    clk_freq    : INTEGER := 100000000;  --system clock frequency in Hz
    stable_time : INTEGER := 10);         --time DATA must remain stable in ms
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    reset   : IN  STD_LOGIC;  --asynchronous active low reset
    DATA  : IN  STD_LOGIC;  --input signal to be debounced
    OP_DATA  : OUT STD_LOGIC); --debounced signal
END component;

component RISING_EDGE_DETECTOR
port (
    CLK : in std_logic;
    SYNC_IN : in std_logic;
    EDGE : out std_logic
);
end component;

component COUNTER
  generic (width: natural);
  port (signal reset :  in std_logic;
        signal clk     :  in std_logic;
        signal en      :  in std_logic;
        signal q       : out std_logic_vector(width-1 downto 0));
end component;

begin

i0 : SYNCHRONIZER
port map(
    reset => reset,
    clk => CLK,
    data_ns => IN_C,
    data_s => signal_1
);

i1 : DEBOUNCE
generic map(
    clk_freq => clk_freq,
    stable_time => stable_time
)
port map(
    clk => CLK,
    reset => reset,
    DATA => signal_1,
    OP_DATA => signal_2
);

i2 : RISING_EDGE_DETECTOR
port map(
    CLK => CLK,
    SYNC_IN => signal_2,
    EDGE => signal_3
);

i3 : COUNTER
generic map(
    width => 4
)
port map(
    reset => reset,
    clk => CLK,
    en => signal_3,
    q => COUNT
);

end Behavioral;