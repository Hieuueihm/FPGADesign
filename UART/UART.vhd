LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MyLib.ALL;

ENTITY UART IS
    GENERIC (
        SYSTEM_CLK : INTEGER := 50_000_000;
        BAUD_RATE : INTEGER := 9_600;
        OS_RATE : INTEGER := 16;
        N : INTEGER := 8
    );
    PORT (
        CLK, RST : IN STD_LOGIC;

        Tx_start : IN STD_LOGIC;
        Tx_data_in : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Tx_data_out : OUT STD_LOGIC;
        Tx_busy : OUT STD_LOGIC;
        Tx_finish : OUT STD_LOGIC;
        Rx_data_in : IN STD_LOGIC;
        Rx_data_out : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Rx_finish : OUT STD_LOGIC
    );
END ENTITY UART;
ARCHITECTURE rtl OF UART IS

BEGIN
    TX : UART_TX
    GENERIC MAP(
        SYSTEM_CLK => SYSTEM_CLK,
        BAUD_RATE => BAUD_RATE,
        OS_RATE => OS_RATE,
        N => N
    )
    PORT MAP(
        CLK => CLK,
        RST => RST,
        Tx_start => Tx_start,
        Tx_data_in => Tx_data_in,
        Tx_data_out => Tx_data_out,
        Tx_busy => Tx_busy,
        Tx_finish => Tx_finish
    );

    RX : UART_RX
    GENERIC MAP(
        SYSTEM_CLK => SYSTEM_CLK,
        BAUD_RATE => BAUD_RATE,
        OS_RATE => OS_RATE,
        N => N
    )
    PORT MAP(
        CLK => CLK,
        RST => RST,
        Rx_data_in => Rx_data_in,
        Rx_data_out => Rx_data_out,
        Rx_finish => Rx_finish
    );

END ARCHITECTURE rtl;