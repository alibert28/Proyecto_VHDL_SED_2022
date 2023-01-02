LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
use ieee.numeric_std.all;                               

ENTITY COUNTER_tst IS
  generic (width : natural := 4);
END COUNTER_tst;

ARCHITECTURE counter_arch OF COUNTER_tst IS
-- constants       
constant CLOCK_PERIOD  : time := 10 ns;     
-- signals                                                 
SIGNAL clk : STD_LOGIC := '0';   
SIGNAL en : STD_LOGIC;
SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL reset_n : STD_LOGIC;

constant MIN  : integer := 0;
constant MAX  : integer := (2**(q'length))-1;

component COUNTER
  generic (width: natural);
  port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal en      :  in std_logic;
        signal q       : out std_logic_vector(width-1 downto 0));
end component;
BEGIN
	i1 : counter
	generic map(
	width => width
	)
	PORT MAP (
	clk => clk,
	en => en,
	q => q,
	reset_n => reset_n
	);
                                         
clk <= not (clk) after CLOCK_PERIOD/2;
                                       
always : PROCESS                                                                                   
BEGIN                                                         
    reset_n <= '0';
	en <= '0';
    wait for 3*CLOCK_PERIOD;
    reset_n <= '1';
	wait for 3*CLOCK_PERIOD;
  for i in MIN to MAX loop  
    en <= '1';
    wait for CLOCK_PERIOD;
  end loop;
  en <= '0';
  wait for 3*CLOCK_PERIOD; 
  en <= '1';
  wait for 2*CLOCK_PERIOD;
  en <= '0';
  wait for 1*CLOCK_PERIOD;
  reset_n <= '0';
  for i in MIN to MAX loop  
    en <= '1';
    wait for CLOCK_PERIOD;
  end loop;   
  assert FALSE report "# INFO:     "  & time'image(now) & ". SUCCESS: Simulation stopped due to successful completion!" severity FAILURE;  
--WAIT;                                                        
END PROCESS always;                                           
END counter_arch;
