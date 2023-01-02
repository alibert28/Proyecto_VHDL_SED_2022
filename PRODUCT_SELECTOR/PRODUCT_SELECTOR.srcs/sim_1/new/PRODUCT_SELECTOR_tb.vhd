library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PRODUCT_SELECTOR_tb is
end PRODUCT_SELECTOR_tb;

architecture sim of PRODUCT_SELECTOR_tb is

constant CLOCK_PERIOD  : time := 10 ns; 

signal reset : std_logic;
signal CLK   : std_logic := '0';
signal CE    : std_logic;
signal q     : std_logic_vector(1 downto 0);

component PRODUCT_SELECTOR
port (
    reset : in  std_logic;
    CLK   : in  std_logic;
    CE    : in  std_logic;
    q     : out std_logic_vector(1 downto 0)
);
end component;

begin

i0 : PRODUCT_SELECTOR
port map(
reset => reset,
CLK => CLK,
CE => CE,
q => q
);

CLK <= not (CLK) after CLOCK_PERIOD/2;

always : PROCESS
begin

CE <= '0';
reset <= '1';
wait for 2*CLOCK_PERIOD;

reset <= '0';
wait for 2*CLOCK_PERIOD;

CE <= '1';
wait for 7*CLOCK_PERIOD;

CE <= '0';
wait for 3*CLOCK_PERIOD;

CE <= '1';
wait for 7*CLOCK_PERIOD;

assert FALSE report "# INFO:     "  & time'image(now) & ". SUCCESS: Simulation stopped due to successful completion!" severity FAILURE;  

end process always;

end sim;