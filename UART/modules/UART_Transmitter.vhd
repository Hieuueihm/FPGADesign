LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY UART_Transmitter IS

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

END ENTITY;

ARCHITECTURE rtl OF UART_Transmitter IS

    SIGNAL baudClk : STD_LOGIC;
    SIGNAL TxPacket : STD_LOGIC_VECTOR(RS232_DATA_BITS + 1 DOWNTO 0);

    COMPONENT Serialiser IS
        GENERIC (
            DATA_WIDTH : INTEGER;
            DEFAULT_STATE : STD_LOGIC
        );
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            shiftEn : IN STD_LOGIC;
            Load : IN STD_LOGIC;
            Din : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            Dout : OUT STD_LOGIC
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

BEGIN
    TxPacket <= '1' & TxData & '0';
    UART_Serialiser_Inst : Serialiser
    GENERIC MAP(
        DATA_WIDTH => RS232_DATA_BITS + 2,
        DEFAULT_STATE => '1'
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        shiftEn => baudclk,
        Load => TxStart,
        Din => TxPacket,
        Dout => UART_Tx_Pin
    );

    UART_BAUD_CLK : BaudClkGenerator
    GENERIC MAP(
        NUMBER_OF_CLOCKS => RS232_DATA_BITS + 2,
        SYS_CLK_FREQ => SYS_CLK_FREQ,
        BAUD_RATE => BAUD_RATE,
        IS_RX => false
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        start => TxStart,
        baudclk => baudclk,
        ready => TxReady
    );

END rtl;