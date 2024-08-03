LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- no parity 
ENTITY UART_RX IS
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
END ENTITY UART_RX;

ARCHITECTURE rtl OF UART_RX IS
    CONSTANT CLK_BAUDRATE : INTEGER := SYSTEM_CLK / BAUD_RATE / OS_RATE;
    TYPE FSM IS(IDLE, START, DATA, STOP_S);
    SIGNAL STATE : FSM;
    SIGNAL rx_count : INTEGER RANGE 0 TO N - 1;
    SIGNAL count_clk : INTEGER RANGE 0 TO (CLK_BAUDRATE - 1);
    SIGNAL Rx_out : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL RX_end : STD_LOGIC;

BEGIN
    PROCESS (CLK, RST)

    BEGIN

        IF (RST = '1') THEN
            STATE <= IDLE;
            rx_count <= 0;
            count_clk <= 0;
            Rx_out <= (OTHERS => '0');
            RX_end <= '0';
        ELSIF (RISING_EDGE (CLK)) THEN
            CASE STATE IS

                WHEN IDLE =>
                    rx_count <= 0;
                    count_clk <= 0;
                    Rx_end <= '0';
                    IF (Rx_data_in = '0') THEN
                        STATE <= START;
                    ELSE
                        STATE <= IDLE;
                    END IF;

                WHEN START =>
                    IF (count_clk = (CLK_BAUDRATE - 1)) THEN
                        IF (Rx_data_in = '0') THEN
                            count_clk <= 0;
                            STATE <= DATA;
                        ELSE
                            STATE <= IDLE;
                        END IF;
                    ELSE
                        count_clk <= count_clk + 1;
                        STATE <= START;
                    END IF;
                WHEN DATA =>
                    IF (count_clk < (CLK_BAUDRATE - 1)) THEN
                        count_clk <= count_clk + 1;
                        STATE <= DATA;
                    ELSE
                        count_clk <= 0;
                        Rx_out(rx_count) <= Rx_data_in;
                        IF (rx_count < N - 1) THEN
                            rx_count <= rx_count + 1;
                            STATE <= DATA;
                        ELSE
                            rx_count <= 0;
                            STATE <= STOP_S;
                        END IF;
                    END IF;
                WHEN STOP_S =>
                    IF (count_clk < (CLK_BAUDRATE - 1)) THEN
                        count_clk <= count_clk + 1;
                        STATE <= STOP_S;
                    ELSE
                        IF (Rx_data_in = '1') THEN
                            count_clk <= 0;
                            Rx_end <= '1';
                            STATE <= IDLE;
                        END IF;
                    END IF;
            END CASE;
        END IF;
    END PROCESS;
    Rx_data_out <= Rx_out;
    Rx_finish <= Rx_end;
END ARCHITECTURE rtl;