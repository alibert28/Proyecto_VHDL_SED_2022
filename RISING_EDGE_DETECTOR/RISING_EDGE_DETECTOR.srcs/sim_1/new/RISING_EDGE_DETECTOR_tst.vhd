library ieee;
use ieee.std_logic_1164.all;

entity RISING_EDGE_DETECTOR_tst is
end entity RISING_EDGE_DETECTOR_tst;

architecture RISING_EDGE_DETECTOR_tst_arch of RISING_EDGE_DETECTOR_tst is

constant CLOCK_PERIOD  : time := 10 ns; 

signal CLK     : std_logic := '0';
signal SYNC_IN : std_logic;
signal EDGE    : std_logic;

component RISING_EDGE_DETECTOR
    port (
    CLK : in std_logic;
    SYNC_IN : in std_logic;
    EDGE : out std_logic
    );
end component;

begin

i0: RISING_EDGE_DETECTOR
port map(
    CLK => CLK,
    SYNC_IN => SYNC_IN,
    EDGE => EDGE
);

CLK <= not (CLK) after CLOCK_PERIOD/2;

always: process
    begin
    SYNC_IN <= '0';
    wait for 1*CLOCK_PERIOD;
    
    SYNC_IN <= '1';
    wait for 1*CLOCK_PERIOD;
    
    SYNC_IN <= '0';
    wait for 1*CLOCK_PERIOD;
    
    SYNC_IN <= '1';
    wait for 2*CLOCK_PERIOD;
    
    SYNC_IN <= '0';
    wait for 1*CLOCK_PERIOD;
    
    SYNC_IN <= '1';
    wait for 3*CLOCK_PERIOD;
    assert FALSE report "# INFO:     "  & time'image(now) & ". SUCCESS: Simulation stopped due to successful completion!" severity FAILURE;
end process;

end architecture RISING_EDGE_DETECTOR_tst_arch;

