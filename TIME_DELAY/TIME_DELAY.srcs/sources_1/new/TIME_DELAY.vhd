-- Basado en
-- https://vhdlwhiz.com/create-timer/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity TIME_DELAY is
generic(
	ClockFrequencyHz : integer := 100000000; --Frecuencia de reloj de la placa o número de periodos que hay en 1 segundo
    NUM_SECONDS_TO_DELAY : integer := 3 --De cuantos segundos quiere el delay
);
port(
    Clk      : in std_logic;
    CE    : in std_logic; -- Negative reset
    DONE : out std_logic); -- se pone a '1' si llega el delay
end TIME_DELAY;
 
architecture rtl of TIME_DELAY is

 	signal Seconds : integer := 0;
    -- Signal for counting clock periods
    signal Ticks : integer := 0;
    signal DONE_aux : std_logic := '0';
 
begin
	
    DONE <= DONE_aux;
 
    process(Clk) is
    begin
        if rising_edge(Clk) then
            -- If the negative reset signal is active
            if CE = '0' then
                Ticks   <= 0;
                Seconds <= 0;
                DONE_aux <= '0';
            else
                -- True once every second
                if Ticks = ClockFrequencyHz - 1 then
                    Ticks <= 0;
 
                    -- True once every minute
                    if Seconds = NUM_SECONDS_TO_DELAY - 1 then
                        Seconds <= 0;
                        DONE_aux <= '1';
                    else
                        Seconds <= Seconds + 1;
                    end if;
                else
                    Ticks <= Ticks + 1;
                end if;
            end if;
        end if;
    end process;
 
end architecture rtl;