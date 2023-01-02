library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package my_components is

component mux2a1
  port( signal sel :  in std_logic;
        signal   a :  in std_logic;
        signal   b :  in std_logic;
        signal   f : out std_logic);
end component;

component SEVEN_SEGMENTS_DISPLAY_DECODER
generic(speed : integer := 18);
port( clk : in std_logic;
       an : out std_logic_vector(3 downto 0);
       seg : out std_logic_vector(6 downto 0);
       dp  : out std_logic;
       sw : in std_logic_vector(15 downto 0)
);
end component;

component BIN_TO_BCD
port(
    a  :  in std_logic_vector(7 downto 0);
    f  : out std_logic_vector(11 downto 0)
);
end component;

component ENTERED_MONEY
port(
    reset   : in std_logic;
    CLK     : in std_logic;
    IN_10C  : in std_logic;
    IN_20C  : in std_logic;
    IN_50C  : in std_logic;
    IN_100C : in std_logic;
	CE      : in std_logic;
    MONTO_INGRESADO : out std_logic_vector(4 downto 0)
);
end component;

component FSM
port(
	MONTO_INGRESADO : in  std_logic_vector(4 downto 0);
	DEVOLVER_DINERO : out std_logic;
	BUTTON_OK       : in  std_logic;
	RESET           : in  std_logic;
	CLK             : in  std_logic;
	PRODUCTO        : out std_logic;
	ERROR           : out std_logic;
	CE_PS           : out std_logic;
	CE_TD           : out std_logic;
	CE_EM           : out std_logic;
	DONE            : in  std_logic
);
end component;

component DEC_2a4
port(
	signal w  :  in std_logic_vector(1 downto 0);
	signal en :  in std_logic;
	signal y  : out std_logic_vector(3 downto 0)
);
end component ;

component TIME_DELAY
generic(
	ClockFrequencyHz : integer := 100000000; --Frecuencia de reloj de la placa o número de periodos que hay en 1 segundo
    NUM_SECONDS_TO_DELAY : integer := 3 --De cuantos segundos quiere el delay
);
port(
    Clk      : in std_logic;
    CE    : in std_logic; -- Negative reset
    DONE : out std_logic); -- se pone a '1' si llega el delay
end component;

component PRODUCT_SELECTOR
port (
    reset : in  std_logic;
    CLK   : in  std_logic;
    CE    : in  std_logic;
    q     : out std_logic_vector(1 downto 0)
);
end component;

component DEBOUNCE
  GENERIC(
    clk_freq    : INTEGER := 100000000;  --system clock frequency in Hz
    stable_time : INTEGER := 10);         --time DATA must remain stable in ms
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    reset   : IN  STD_LOGIC;  --asynchronous active low reset
    DATA  : IN  STD_LOGIC;  --input signal to be debounced
    OP_DATA  : OUT STD_LOGIC); --debounced signal
end component ;

component SYNCHRONIZER
port(
    signal reset   :  in std_logic;
    signal clk     :  in std_logic;
    signal data_ns :  in std_logic;
    signal data_s  : out std_logic
);
end component;

component RISING_EDGE_DETECTOR
port (
	CLK : in std_logic;
	SYNC_IN : in std_logic;
	EDGE : out std_logic
);
end component;

end my_components;