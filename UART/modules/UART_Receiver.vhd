LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY UART_Receiver IS

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
END ENTITY UART_Receiver;
ARCHITECTURE rtl OF UART_Receiver IS

    COMPONENT Synchronizer IS

        GENERIC (
            IDLE_STATE : STD_LOGIC
        );
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            async : IN STD_LOGIC;
            synced : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT BaudClkGenerator IS

        GENERIC (
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER;
            NUMBER_OF_CLOCKS : INTEGER;
            IS_RX : BOOLEAN
        );
        PORT (
            clk : IN STD_LOGIC; -- 50 MHz 
            rst : IN STD_LOGIC;
            start : IN STD_LOGIC;
            baudClk : OUT STD_LOGIC;
            ready : OUT STD_LOGIC
        );

    END COMPONENT;
    COMPONENT ShiftRegister IS
        GENERIC (
            CHAIN_LENGTH : INTEGER;
            SHIFT_DIRECTION : CHARACTER -- L is shift to the left, R is shift to the right
        );
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;

            shiftEn : IN STD_LOGIC;
            Din : IN STD_LOGIC;
            Dout : OUT STD_LOGIC_VECTOR(CHAIN_LENGTH - 1 DOWNTO 0)

        );
    END COMPONENT;
    SIGNAL synced_rx : STD_LOGIC;
    SIGNAL start : STD_LOGIC;
    SIGNAL baudclk : STD_LOGIC;
    SIGNAL ready : STD_LOGIC;
    SIGNAL Rx_Synced_Delay : STD_LOGIC;
    SIGNAL is_started : STD_LOGIC;

    TYPE FSM IS (IDLE, COLLECT, ASSERT_IRQ);
    SIGNAL State : FSM;
BEGIN

    Sync_Rx_ins : Synchronizer
    GENERIC MAP(IDLE_STATE => '1')
    PORT MAP(clk, rst, async => RxSignal, synced => synced_rx);
    BaudClk_Rx : BaudClkGenerator
    GENERIC MAP(
        NUMBER_OF_CLOCKS => DATA_WIDTH + 1,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE,
        IS_RX => true
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        start => start,
        baudclk => baudclk,
        ready => ready
    );
    ShiftRegister_Rx : ShiftRegister
    GENERIC MAP(
        CHAIN_LENGTH => DATA_WIDTH,
        SHIFT_DIRECTION => 'R'
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        shiftEn => baudclk,
        Din => synced_rx,
        Dout => RxData
    );
    FallingEdgeDetectProcess : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            Rx_Synced_Delay <= '1';
            is_started <= '0';
        ELSIF rising_edge(clk) THEN
            rx_synced_delay <= synced_rx;
            IF synced_rx = '0' AND rx_synced_delay = '1' THEN
                is_started <= '1';
            ELSE
                is_started <= '0';
            END IF;
        END IF;
    END PROCESS;

    FSMProcess : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            start <= '0';
            State <= IDLE;
            IRQ <= '0';
        ELSIF rising_edge(clk) THEN
            IF IRQClear = '1' THEN
                IRQ <= '0';
            END IF;
            CASE State IS
                WHEN IDLE =>
                    IF is_started = '1' THEN
                        start <= '1';
                    ELSE
                        start <= '0';
                    END IF;
                    IF ready = '0' THEN
                        State <= COLLECT;
                    END IF;
                WHEN COLLECT =>
                    start <= '0';
                    IF ready = '1' THEN
                        State <= ASSERT_IRQ;
                    END IF;
                WHEN ASSERT_IRQ =>
                    IRQ <= '1';
                    State <= IDLE;

                WHEN OTHERS =>
                    State <= IDLE;
            END CASE;

        END IF;
    END PROCESS;
END ARCHITECTURE rtl;