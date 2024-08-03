LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE MyLib IS
    COMPONENT UART_RX IS
        GENERIC (
            SYSTEM_CLK : INTEGER := 50_000_000;
            BAUD_RATE : INTEGER := 9_600;
            OS_RATE : INTEGER := 16;
            N : INTEGER := 8
        );
        PORT (
            CLK, RST : IN STD_LOGIC;
            Rx_data_in : IN STD_LOGIC;
            Rx_data_out : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            Rx_finish : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT UART_TX IS
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
            Tx_finish : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT UART IS
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
    END COMPONENT;
END PACKAGE MyLib;