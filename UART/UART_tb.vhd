LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MyLib.ALL;

ENTITY UART_tb IS

END ENTITY UART_tb;

ARCHITECTURE bev OF UART_tb IS
    CONSTANT N : INTEGER := 8;

    SIGNAL clk, Tx_data_out, Rx_data_in : STD_LOGIC := '1';
    SIGNAL rst, Tx_start, Tx_busy, Tx_finish, Rx_finish : STD_LOGIC := '0';
    SIGNAL Tx_data_in : STD_LOGIC_VECTOR(N - 1 DOWNTO 0) := "01101001";
    SIGNAL Rx_data_out : STD_LOGIC_VECTOR(N - 1 DOWNTO 0) := (OTHERS => '0');

    CONSTANT SYSTEM_CLK : INTEGER := 50e6; -- 50 MHz
    CONSTANT clk_period : TIME := 20 ns;
    CONSTANT BAUD_RATE : INTEGER := 9_600;
    CONSTANT OS_RATE : INTEGER := 16;
    CONSTANT CLK_BAUDRATE : INTEGER := (SYSTEM_CLK / BAUD_RATE / OS_RATE);
BEGIN
    UUT : UART
    GENERIC MAP(
        SYSTEM_CLK => SYSTEM_CLK,
        BAUD_RATE => BAUD_RATE,
        OS_RATE => OS_RATE,
        N => N
    )
    PORT MAP(
        CLK => clk,
        RST => rst,
        Tx_start => Tx_start,
        Tx_data_in => Tx_data_in,
        Tx_data_out => Tx_data_out,
        Tx_busy => Tx_busy,
        Tx_finish => Tx_finish,
        Rx_data_in => Rx_data_in,
        Rx_data_out => Rx_data_out,
        Rx_finish => Rx_finish
    );

    CLK_PROCESS : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;
    stim_proc : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR clk_period * 2;
        rst <= '0';
        -- tx
        -- Tx_start <= '1';

        -- WAIT UNTIL Tx_finish <= '1';

        -- Tx_start <= '0';

        -- rx

        Rx_data_in <= '0';

        WAIT FOR clk_period * CLK_BAUDRATE * 2;

        FOR i IN 0 TO N - 1 LOOP
            Rx_data_in <= Tx_data_in(i);
            WAIT FOR clk_period * CLK_BAUDRATE;
        END LOOP;

        Rx_data_in <= '1';
        WAIT FOR clk_period * CLK_BAUDRATE;
        WAIT;
    END PROCESS;

END ARCHITECTURE bev;