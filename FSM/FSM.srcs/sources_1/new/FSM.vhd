library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM is
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
end FSM;

architecture Behavioral of FSM is
    TYPE state IS (s_Espera,s_Contando,s_Elegir_Producto,s_Error,s_Correcto);
    SIGNAL state_reg, state_next : state;
    attribute syn_encoding : string;
    attribute syn_encoding of state : type is "safe";
BEGIN
    ------------------------Lógica Secuencial-----------------------
    SEQ: PROCESS (RESET,CLK)
    BEGIN
        IF (reset = '1') THEN
            state_reg <= s_Espera;
        ELSIF rising_edge(CLK) THEN
            state_reg <= state_next;
        END IF;
    END PROCESS SEQ;
    -----------------------Lógica Combinacional estado siguiente y salidas---------------------
    COMB: PROCESS (MONTO_INGRESADO, BUTTON_OK, DONE, state_reg)
    BEGIN
        CASE state_reg IS
            WHEN s_Espera =>
                ERROR    <= '0';
                PRODUCTO <= '0';
                CE_TD <= '0';
                CE_PS <= '0';
                CE_EM <= '1';
                DEVOLVER_DINERO <= '0';
                IF (unsigned(MONTO_INGRESADO)>0) THEN
                    state_next <= s_Contando;
                ELSE
                    state_next <= s_Espera;
                END IF;
            WHEN s_Contando =>
                ERROR    <= '0';
                PRODUCTO <= '0';
                CE_TD <= '0';
                CE_PS <= '0';
                CE_EM <= '1';
                DEVOLVER_DINERO <= '0';
                IF (unsigned(MONTO_INGRESADO) = 10) THEN
                    state_next <= s_Elegir_Producto;
                elsif (unsigned(MONTO_INGRESADO) > 10) THEN
                    state_next <= s_Error;
                ELSE
                    state_next <= s_Contando;
                END IF;
            WHEN s_Elegir_Producto =>
                ERROR    <= '0';
                PRODUCTO <= '0';
                CE_TD <= '0';
                CE_PS <= '1';
                CE_EM <= '0';
                DEVOLVER_DINERO <= '0';
                IF BUTTON_OK = '1' then
                    state_next <= s_Correcto;
                ELSE
                    state_next <= s_Elegir_Producto;
                END IF;
            WHEN s_Error =>
                ERROR    <= '1';
                PRODUCTO <= '0';
                CE_TD <= '1';
                CE_PS <= '0';
                CE_EM <= '0';
                DEVOLVER_DINERO <= '1';
                IF DONE = '1' then
                    state_next <= s_Espera;
                else
                    state_next <= s_Error;
                end if;
            WHEN s_Correcto =>
                ERROR    <= '0';
                PRODUCTO <= '1';
                CE_TD <= '1';
                CE_PS <= '0';
                CE_EM <= '0';
                DEVOLVER_DINERO <= '1';
                IF DONE = '1' then
                    state_next <= s_Espera;
                else
                    state_next <= s_Correcto;
                end if;
        END CASE;

    END PROCESS COMB;

end Behavioral;
