library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity TIME_DELAY_tb is
end TIME_DELAY_tb;
 
architecture sim of TIME_DELAY_tb is
 
    -- We're slowing down the clock to speed up simulation time
    constant ClockFrequencyHz : integer := 5; -- 10 Hz
 	constant NUM_SECONDS_TO_DELAY : integer := 3;
    
    constant ClockPeriod      : time := 10 ns;
    
    signal Clk     : std_logic := '0';
    signal CE    : std_logic;
    signal DONE : std_logic;
    
    component TIME_DELAY
    generic(
        ClockFrequencyHz : integer; --Frecuencia de reloj de la placa
        NUM_SECONDS_TO_DELAY : integer --De cuantos segundos quiere el delay
    );
    port(
        Clk      : in std_logic;
        CE    : in std_logic; -- Negative reset
        DONE : out std_logic); -- se pone a '1' si llega el delay
    end component;
 
begin
 
    -- The Device Under Test (DUT)
    i_Timer : TIME_DELAY
    generic map(
    	ClockFrequencyHz => ClockFrequencyHz,
        NUM_SECONDS_TO_DELAY => NUM_SECONDS_TO_DELAY)
    port map (
        Clk     => Clk,
        CE    => CE,
        DONE => DONE);
 
    -- Process for generating the clock
    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench sequence
    always : process
    begin
    	CE <= '1';
        wait for 2*ClockPeriod;
        
        CE <= '0';
        wait for 23*ClockPeriod;
        
        CE <= '1';
        wait for 2*ClockPeriod;
        
        CE <= '0';
        wait for 20*ClockPeriod;
        
        assert FALSE report "# INFO:     "  & time'image(now) & ". SUCCESS: Simulation stopped due to successful completion!" severity FAILURE;
    end process;
 
end architecture sim;