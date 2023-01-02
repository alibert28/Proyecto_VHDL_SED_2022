-- Basado en
-- https://github.com/bilalkabas/Basys3-VHDL-Basics/tree/master/example5

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SEVEN_SEGMENTS_DISPLAY_DECODER is
generic(speed : integer := 18);
port( clk : in std_logic;
       an : out std_logic_vector(3 downto 0);
       seg : out std_logic_vector(6 downto 0);
       dp  : out std_logic;
       sw : in std_logic_vector(15 downto 0)
);
end SEVEN_SEGMENTS_DISPLAY_DECODER;

architecture Behavioral of SEVEN_SEGMENTS_DISPLAY_DECODER is

signal counter : std_logic_vector(speed downto 0) := (others => '0');
signal sel : std_logic_vector(1 downto 0) := (others => '0');
signal num : std_logic_vector(3 downto 0) := (others => '0');

begin

process(clk)
begin
    if clk'event and clk = '1' then
        counter <= std_logic_vector(unsigned(counter) + 1);
    end if;
end process;
    
process(counter(speed))
begin
    if counter(speed)'event and counter(speed) = '1' then
        sel <= std_logic_vector(unsigned(sel) + 1);
    end if;
end process;
    
process(sel)
begin
    case sel is
        when "00" => an <= "1110";
                     num <= sw(3 downto 0);
                     dp <= '1';
        when "01" => an <= "1101";
                     num <= sw(7 downto 4);
                     dp <= '1';
        when "10" => an <= "1011";
                     num <= sw(11 downto 8);
                     dp <= '0';
        when "11" => an <= "0111";
                     num <= "1111"; -- dummy value, for others
                     dp <= '1';
        when others => null;
    end case;
end process;
    
process(sw)
begin
    case num is
        when "0000" => seg <= "1000000"; -- 0
        when "0001" => seg <= "1111001"; -- 1
        when "0010" => seg <= "0100100"; -- 2
        when "0011" => seg <= "0110000"; -- 3
        when "0100" => seg <= "0011001"; -- 4
        when "0101" => seg <= "0010010"; -- 5
        when "0110" => seg <= "0000010"; -- 6
        when "0111" => seg <= "1111000"; -- 7
        when "1000" => seg <= "0000000"; -- 8
        when "1001" => seg <= "0010000"; -- 9
        when others => seg <= "1111111"; -- off
    end case;
end process;

end Behavioral;
