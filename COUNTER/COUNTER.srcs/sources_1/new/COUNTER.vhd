library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity COUNTER is
  generic (width: natural);
  port (signal reset :  in std_logic;
        signal clk     :  in std_logic;
        signal en      :  in std_logic;
        signal q       : out std_logic_vector(width-1 downto 0));
end COUNTER;

architecture structural of COUNTER is

  signal q_reg   : unsigned(width-1 downto 0);
  signal q_next  : unsigned(width-1 downto 0);
  
begin

  seq: process(reset,clk)
  begin
    if (reset = '1') then
      q_reg <= (others => '0');
    elsif rising_edge(clk) then
      q_reg <= q_next;  
    end if;
  end process seq;

  comb: process(en, q_reg)
  begin
    if (en = '1') then
	  q_next <= q_reg + 1;
	else
	  q_next <= q_reg;
    end if;
  end process comb;
  
  q <= std_logic_vector(q_reg); 
  
end structural;
