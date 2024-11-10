LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UART_Transmitter_tb IS
    GENERIC (
        RS232_DATA_BITS : INTEGER := 8;
        SYS_CLK_FREQ : INTEGER := 50000000;
        BAUD_RATE : INTEGER := 50000 -- Bit period = 20us
    );
END ENTITY;

ARCHITECTURE rtl OF UART_Transmitter_tb IS

    COMPONENT UART_Transmitter IS
        GENERIC (
            RS232_DATA_BITS : INTEGER; -- NUMBER OF DATA BITS
            SYS_CLK_FREQ : INTEGER;
            BAUD_RATE : INTEGER

        );

        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            TxStart : IN STD_LOGIC;
            TxData : IN STD_LOGIC_VECTOR(RS232_DATA_BITS - 1 DOWNTO 0);
            --outputs
            TxReady : OUT STD_LOGIC;
            UART_Tx_Pin : OUT STD_LOGIC

        );
    END COMPONENT;

    SIGNAL Clk : STD_LOGIC := '0'; -- 50MHz
    SIGNAL Rst : STD_LOGIC;

    SIGNAL TxStart : STD_LOGIC;
    SIGNAL TxData : STD_LOGIC_VECTOR(RS232_DATA_BITS - 1 DOWNTO 0);
    SIGNAL TxReady : STD_LOGIC;
    SIGNAL UART_tx_pin : STD_LOGIC;

BEGIN

    Clk <= NOT Clk AFTER 10 ns; -- Simulate the 50MHz clock input

    UART_tx_inst : UART_Transmitter
    GENERIC MAP
    (
        RS232_DATA_BITS => RS232_DATA_BITS,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE
    )
    PORT MAP
    (
        clk => Clk,
        rst => Rst,

        TxStart => TxStart,
        TxData => TxData,
        TxReady => TxReady,
        UART_tx_pin => UART_tx_pin
    );

    TestProcess : PROCESS
    BEGIN
        Rst <= '1';
        TxStart <= '0';
        TxData <= (OTHERS => '0');
        WAIT FOR 100ns;
        Rst <= '0';
        WAIT FOR 100ns;

        WAIT UNTIL rising_edge(Clk);
        TxData <= x"AA";
        TxStart <= '1';
        WAIT UNTIL rising_edge(Clk);
        TxStart <= '0';
        TxData <= (OTHERS => '0');
        WAIT FOR 100ns;

        WAIT UNTIL rising_edge(Clk);
        TxData <= x"01";
        TxStart <= '1';
        WAIT UNTIL rising_edge(Clk);
        TxStart <= '0';
        TxData <= (OTHERS => '0');
        WAIT;
    END PROCESS;

END rtl;