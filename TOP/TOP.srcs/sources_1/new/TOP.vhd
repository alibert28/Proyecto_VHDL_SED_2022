library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.my_components.all;

entity TOP is
port(
    RESET   : in std_logic;
    CLK     : in std_logic;
    IN_10C  : in std_logic;
    IN_20C  : in std_logic;
    IN_50C  : in std_logic;
    IN_100C : in std_logic;
    BUTTON_OK       : in  std_logic;
    BUTTON_CHANGE   : in  std_logic;
    PRODUCTO        : out std_logic;
    ERROR           : out std_logic;
    an    : out std_logic_vector(3 downto 0);
    seg   : out std_logic_vector(6 downto 0);
    dp : out std_logic;
    LED : out std_logic_vector(3 downto 0)
);
end TOP;

architecture structural of TOP is

constant speed_SSDD : integer := 18;

constant ClockFrequencyHz : integer := 100000000;
constant NUM_SECONDS_TO_DELAY : integer := 3;

signal a_in : std_logic_vector(7 downto 0);
signal f_in : std_logic_vector(11 downto 0);

signal MONTO_INGRESADO_in : std_logic_vector(4 downto 0);
signal DEVOLVER_DINERO_in : std_logic;
signal RESET_TO_EM : std_logic;

signal CE_PS_in : std_logic;
signal CE_TD_in : std_logic;

signal DONE_in : std_logic;

signal q_in : std_logic_vector(1 downto 0);

signal MONTO_INGRESADO_in2 : std_logic_vector(7 downto 0);

signal f_in2 : std_logic_vector (15 downto 0);

signal OP_DATA_in : std_logic;
signal data_s_in : std_logic;
signal EDGE_in : std_logic;

signal BUTTON_OK_in : std_logic;

signal CE_EM_in : std_logic;

constant clk_freq    : INTEGER := 100000000;  --system clock frequency in Hz
constant stable_time : INTEGER := 10;         --time DATA must remain stable in ms

begin
f_in2 <= f_in & "0000";
MONTO_INGRESADO_in2 <= "000" & MONTO_INGRESADO_in;

i0 : mux2a1
port map(
    sel => DEVOLVER_DINERO_in,
    a => RESET,
    b => '1',
    f => RESET_TO_EM
);

i1 : ENTERED_MONEY
port map(
    reset => RESET_TO_EM,
    CLK => CLK,
    IN_10C => IN_10C,
    IN_20C => IN_20C,
    IN_50C => IN_50C,
    IN_100C => IN_100C,
	CE => CE_EM_in,
    MONTO_INGRESADO => MONTO_INGRESADO_in
);

i2 : BIN_TO_BCD
port map(
    a => MONTO_INGRESADO_in2,
    f => f_in
);

i3 : SEVEN_SEGMENTS_DISPLAY_DECODER
generic map(speed => speed_SSDD)
port map(
    clk => CLK,
    an => an,
    seg => seg,
    dp => dp,
    sw => f_in2
);

i4 : FSM
port map(
    MONTO_INGRESADO => MONTO_INGRESADO_in,
    DEVOLVER_DINERO => DEVOLVER_DINERO_in,
    BUTTON_OK       => BUTTON_OK,
    RESET           => RESET,
    CLK             => CLK,
    PRODUCTO        => PRODUCTO,
    ERROR           => ERROR,
	CE_EM           => CE_EM_in,
    CE_PS           => CE_PS_in,
    CE_TD           => CE_TD_in,
    DONE            => DONE_in
);

i5 : PRODUCT_SELECTOR
port map(
    reset => RESET,
    CLK => EDGE_in,
    CE => CE_PS_in,
    q => q_in
);

i6 : DEC_2a4
port map(
    w => q_in,
    en => CE_PS_in,
    y => LED
);

i7 : TIME_DELAY
generic map(
    ClockFrequencyHz => ClockFrequencyHz,
    NUM_SECONDS_TO_DELAY => NUM_SECONDS_TO_DELAY
)
port map(
    Clk => CLK,
    CE => CE_TD_in,
    DONE => DONE_in
);

i8 : SYNCHRONIZER
port map(
    reset => RESET,
    clk => CLK,
    data_ns => BUTTON_CHANGE,
    data_s => data_s_in
);

i9 : DEBOUNCE
generic map(
    clk_freq => clk_freq,  --system clock frequency in Hz
    stable_time => stable_time        --time DATA must remain stable in ms
)
port map(
    DATA => data_s_in,
    reset => RESET,
    CLK => CLK,
    OP_DATA => OP_DATA_in
);

i10 : RISING_EDGE_DETECTOR
port map(
    clk => CLK,
    SYNC_IN => OP_DATA_in,
    EDGE => EDGE_in
);

end structural;
