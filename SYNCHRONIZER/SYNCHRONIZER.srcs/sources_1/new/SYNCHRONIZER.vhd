library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYNCHRONIZER is
port(
    signal reset :  in std_logic;
    signal clk     :  in std_logic;
    signal data_ns :  in std_logic;
    signal data_s  : out std_logic
);
end SYNCHRONIZER;

architecture structural of SYNCHRONIZER is

signal data_m :  std_logic;
  
begin
seq: process(reset,clk)
    begin
    if (reset = '1') then
        data_m <= '0'; 
        data_s <= '0'; 
    elsif rising_edge(clk) then
        data_m <= data_ns;
        data_s <= data_m;	
    end if;
end process seq;

end structural;

