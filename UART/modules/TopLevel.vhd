LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY TopLevel IS

    GENERIC (
        DATA_BITS : INTEGER := 8;
        SYS_CLK_FREQ : INTEGER := 50000000;
        BAUD_RATE : INTEGER := 115200
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        rx_pin : IN STD_LOGIC;
        tx_pin : OUT STD_LOGIC
    );
END ENTITY TopLevel;

ARCHITECTURE rtl OF TopLevel IS
    -- Components
    COMPONENT UART_Transmitter IS
        GENERIC (
            RS232_DATA_BITS : INTEGER;
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER
        );
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            TxStart : IN STD_LOGIC;
            TxData : IN STD_LOGIC_VECTOR(RS232_DATA_BITS - 1 DOWNTO 0);
            TxReady : OUT STD_LOGIC;
            UART_Tx_Pin : OUT STD_LOGIC
        );

    END COMPONENT;
    COMPONENT UART_Receiver IS
        GENERIC (
            DATA_WIDTH : INTEGER;
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER);
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            RxSignal : IN STD_LOGIC; -- asynchronous signal transmitted by the COM port
            IRQClear : IN STD_LOGIC;

            IRQ : OUT STD_LOGIC;
            RxData : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;
    TYPE FSMState IS (IDLE, TRANSMIT);
    SIGNAL fsm_state : FSMState;
    SIGNAL TxStart : STD_LOGIC;
    SIGNAL TxReady : STD_LOGIC;
    SIGNAL IRQ : STD_LOGIC;
    SIGNAL RxData : STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
BEGIN
    Transmitter_inst : UART_Transmitter
    GENERIC MAP(
        RS232_DATA_BITS => DATA_BITS,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        TxStart => TxStart,
        TxData => RxData,
        TxReady => TxReady,
        UART_Tx_Pin => tx_pin
    );
    Receiver_inst : UART_Receiver
    GENERIC MAP(
        DATA_WIDTH => DATA_BITS,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE
    )
    PORT MAP(
        -- inputs
        clk => clk,
        rst => rst,
        RxSignal => rx_pin,
        IRQClear => TxStart,
        -- outputs
        IRQ => IRQ,
        RxData => RxData
    );
    processFSM : PROCESS (rst, clk)
    BEGIN
        IF rst = '1' THEN
            fsm_state <= IDLE;
            TxStart <= '0';
        ELSIF rising_edge(clk) THEN
            CASE fsm_state IS
                WHEN IDLE =>
                    IF IRQ = '1' AND TxReady = '1' THEN
                        fsm_state <= TRANSMIT;
                        TxStart <= '1';
                    END IF;
                WHEN TRANSMIT =>
                    TxStart <= '0';
                    fsm_state <= IDLE;
                WHEN OTHERS =>
                    fsm_state <= IDLE;
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE;