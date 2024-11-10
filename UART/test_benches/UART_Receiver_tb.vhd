
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UART_Receiver_tb IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8;
        SYS_CLK_FREQ : INTEGER := 50000000;
        BAUD_RATE : INTEGER := 115200

    );
END ENTITY;

ARCHITECTURE rtl OF UART_Receiver_tb IS
    -- Components
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
    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL RxSignal : STD_LOGIC;
    SIGNAL IRQClear : STD_LOGIC;
    SIGNAL IRQ : STD_LOGIC;
    SIGNAL RxData : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    SIGNAL test_data1 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) := x"0F";
    SIGNAL test_data2 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) := x"02";
BEGIN
    clk <= NOT clk AFTER 10 ns; -- Simulate 50 MHz clock
    Receiver_inst : UART_Receiver
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        RxSignal => RxSignal,
        IRQClear => IRQClear,
        IRQ => IRQ,
        RxData => RxData
    );
    processTest : PROCESS
    BEGIN
        -- init - run 200 ns
        rst <= '1';
        RxSignal <= '1';
        IRQClear <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        IRQClear <= '0';

        WAIT FOR 100 ns;
        -- 0F 0000 1111
        RxSignal <= '0';
        WAIT FOR 8.7 us;
        FOR i IN 0 TO 7 LOOP
            RxSignal <= test_data1(i);
            WAIT FOR 8.7 us;
        END LOOP;
        RxSignal <= '1';
        WAIT FOR 8.7 us;

        WAIT FOR 50 ns;
        WAIT UNTIL rising_edge(clk);
        IRQClear <= '1';
        WAIT UNTIL rising_edge(clk);
        IRQClear <= '0';

        WAIT FOR 100 ns;
        -- 0F 0000 1111
        RxSignal <= '0';
        WAIT FOR 8.7 us;
        FOR i IN 0 TO 7 LOOP
            RxSignal <= test_data2(i);
            WAIT FOR 8.7 us;
        END LOOP;
        RxSignal <= '1';
        WAIT FOR 8.7 us;

        WAIT FOR 50 ns;
        WAIT UNTIL rising_edge(clk);
        IRQClear <= '1';
        WAIT UNTIL rising_edge(clk);
        IRQClear <= '0';
        WAIT;
    END PROCESS;
END ARCHITECTURE;