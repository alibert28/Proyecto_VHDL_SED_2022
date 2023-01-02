library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PRODUCT_SELECTOR is
port (
    reset : in  std_logic;
    CLK   : in  std_logic;
    CE    : in  std_logic;
    q     : out std_logic_vector(1 downto 0)
);
end PRODUCT_SELECTOR;

architecture Behavioral of PRODUCT_SELECTOR is

signal count : integer := 0;

begin
    process(clk, reset, CE)
    begin
        if reset = '1' then
            count <= 0;
        else
            if CE = '0' then
                count <= 0;
            else
                if rising_edge(clk) then
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;
    
q <= std_logic_vector(to_unsigned(count,2));

end Behavioral;