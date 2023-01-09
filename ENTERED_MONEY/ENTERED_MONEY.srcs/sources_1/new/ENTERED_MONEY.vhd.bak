library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ENTERED_MONEY is
port(
    reset : in std_logic;
    CLK     : in std_logic;
    IN_10C  : in std_logic;
    IN_20C  : in std_logic;
    IN_50C  : in std_logic;
    IN_100C : in std_logic;
    CE :in std_logic;
    MONTO_INGRESADO : out std_logic_vector(4 downto 0)
);
end ENTERED_MONEY;

architecture Behavioral of ENTERED_MONEY is

signal IN_10C_in : std_logic;
signal IN_20C_in : std_logic;
signal IN_50C_in : std_logic;
signal IN_100C_in : std_logic;

signal CE_in : std_logic;

signal COUNT_10C : std_logic_vector(3 downto 0);
signal COUNT_20C : std_logic_vector(3 downto 0);
signal COUNT_50C : std_logic_vector(3 downto 0);
signal COUNT_100C : std_logic_vector(3 downto 0);

signal MONTO_10C : std_logic_vector(4 downto 0);
signal MONTO_20C : std_logic_vector(4 downto 0);
signal MONTO_50C : std_logic_vector(4 downto 0);
signal MONTO_100C : std_logic_vector(4 downto 0);

signal MONTO_10C_int : integer;
signal MONTO_20C_int : integer;
signal MONTO_50C_int : integer;
signal MONTO_100C_int: integer;
signal MONTO_INGRESADO_int : integer;

component ENTERED_COINS_COUNTER
port(
    reset : in std_logic;
    CLK     : in std_logic;
    IN_C    : in std_logic;
    COUNT   : out std_logic_vector(3 downto 0)
);
end component;

component mux2a1
port(
    signal sel :  in std_logic;
    signal   a :  in std_logic;
    signal   b :  in std_logic;
    signal   f : out std_logic
);
end component;

begin

ECC_10C : ENTERED_COINS_COUNTER
port map(
    reset => reset,
    CLK => CLK,
    IN_C => IN_10C_in,
    COUNT => COUNT_10C
);

ECC_20C : ENTERED_COINS_COUNTER
port map(
    reset => reset,
    CLK => CLK,
    IN_C => IN_20C_in,
    COUNT => COUNT_20C
);

ECC_50C : ENTERED_COINS_COUNTER
port map(
    reset => reset,
    CLK => CLK,
    IN_C => IN_50C_in,
    COUNT => COUNT_50C
);

ECC_100C : ENTERED_COINS_COUNTER
port map(
    reset => reset,
    CLK => CLK,
    IN_C => IN_100C_in,
    COUNT => COUNT_100C
);

i0 : mux2a1
port map(
    sel => CE_in,
    a => IN_10C,
    b => '0',
    f => IN_10C_in
);
i1 : mux2a1
port map(
    sel => CE_in,
    a => IN_20C,
    b => '0',
    f => IN_20C_in
);
i2 : mux2a1
port map(
    sel => CE_in,
    a => IN_50C,
    b => '0',
    f => IN_50C_in
);
i3 : mux2a1
port map(
    sel => CE_in,
    a => IN_100C,
    b => '0',
    f => IN_100C_in
);
i4 :mux2a1
port map(
    sel => CE,
    a => '1',
    b => '0',
    f => CE_in
);

MONTO_10C_int  <= to_integer(unsigned("0" & COUNT_10C));
MONTO_20C_int  <= 2 * to_integer(unsigned(COUNT_20C));
MONTO_50C_int  <= 5 * to_integer(unsigned(COUNT_50C));
MONTO_100C_int <= 10* to_integer(unsigned(COUNT_100C));
MONTO_INGRESADO_int <= MONTO_10C_int+MONTO_20C_int+MONTO_50C_int+MONTO_100C_int;
MONTO_INGRESADO <= std_logic_vector(to_unsigned(MONTO_INGRESADO_int,5));

end Behavioral;
