library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RISING_EDGE_DETECTOR is
    port (
    CLK : in std_logic;
    SYNC_IN : in std_logic;
    EDGE : out std_logic
    );
end RISING_EDGE_DETECTOR;

architecture BEHAVIORAL of RISING_EDGE_DETECTOR is
signal reg1 :std_logic;
signal reg2 :std_logic;
begin
reg: process(CLK)
    begin
       if rising_edge(CLK) then
          reg1  <= SYNC_IN;
          reg2  <= reg1;
      end if;
    end process;
EDGE <= reg1 and (not reg2);

end BEHAVIORAL;