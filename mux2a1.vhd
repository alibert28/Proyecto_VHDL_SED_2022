library ieee;
use ieee.std_logic_1164.all;

entity mux2a1 is
  port( signal sel :  in std_logic;
        signal   a :  in std_logic;
        signal   b :  in std_logic;
        signal   f : out std_logic);
end mux2a1;

architecture structural_1 of mux2a1 is

begin

  f <= a when(sel = '0') else 
       b when(sel = '1') else
		'-';

end structural_1;

