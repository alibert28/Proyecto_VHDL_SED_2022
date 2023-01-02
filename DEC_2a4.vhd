library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity DEC_2a4 is
port(
	signal w  :  in std_logic_vector(1 downto 0);
	signal en :  in std_logic;
	signal y  : out std_logic_vector(3 downto 0)
);
end DEC_2a4 ;

architecture structural of DEC_2a4 is

signal en_w : std_logic_vector(2 downto 0);

begin

	en_w <= en & w ;
	
	with en_w select
		y <= "0001" when "100",
		     "0010" when "101",
		     "0100" when "110",
		     "1000" when "111",
			 "0000" when "000" | "001" | "010" | "011",		 
			 "----" when others;
			 
end structural;
