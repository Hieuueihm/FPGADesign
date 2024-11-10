LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TopLevel_tb IS
    GENERIC (
        RS232_DATA_BITS : INTEGER := 8
    );
END ENTITY;
ARCHITECTURE rtl OF TopLevel_tb IS

    COMPONENT TopLevel IS
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
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL rs232_rx_pin : STD_LOGIC;
    SIGNAL rs232_tx_pin : STD_LOGIC;
    SIGNAL TransmittedData : STD_LOGIC_VECTOR(RS232_DATA_BITS - 1 DOWNTO 0);

BEGIN

    clk <= NOT clk AFTER 10ns;

    UUT : TopLevel
    GENERIC MAP
    (
        DATA_BITS => RS232_DATA_BITS,
        SYS_CLK_FREQ => 50000000,
        BAUD_RATE => 115200
    )
    PORT MAP
    (
        clk => clk,
        rst => rst,
        rx_pin => rs232_rx_pin,
        tx_pin => rs232_tx_pin
    );
    SerialToParallel : PROCESS
    BEGIN
        WAIT UNTIL falling_edge(rs232_tx_pin);

        WAIT FOR 4.3us;

        FOR i IN 1 TO RS232_DATA_BITS LOOP
            WAIT FOR 8.7us;
            TransmittedData(i - 1) <= rs232_tx_pin;
        END LOOP;

        WAIT FOR 8.7us;
    END PROCESS;

    TestProcess : PROCESS

        VARIABLE TransmitDataVector : STD_LOGIC_VECTOR(RS232_DATA_BITS - 1 DOWNTO 0);

        PROCEDURE TRANSMIT_CHARACTER
        (
        CONSTANT TransmitData : IN INTEGER
        ) IS
    BEGIN
        TransmitDataVector := STD_LOGIC_VECTOR(to_unsigned(TransmitData, RS232_DATA_BITS));
        -- Transmit Start Bit
        rs232_rx_pin <= '0';
        WAIT FOR 8.7us;

        -- Transmit Data Bits LSB first
        FOR i IN 1 TO RS232_DATA_BITS LOOP
            rs232_rx_pin <= TransmitDataVector(i - 1);
            WAIT FOR 8.7us;
        END LOOP;

        -- Transmit Stop Bit
        rs232_rx_pin <= '1';
        WAIT FOR 8.7us;
    END PROCEDURE;

BEGIN
    Rst <= '1';
    rs232_rx_pin <= '1';
    WAIT FOR 100ns;
    Rst <= '0';
    WAIT FOR 100ns;

    -- TRANSMIT_CHARACTER(1);
    -- WAIT FOR 10 ns;
    -- TRANSMIT_CHARACTER(2);
    -- 1 -> 0000 0001

    FOR i IN 0 TO 255 LOOP
        TRANSMIT_CHARACTER(i);
        WAIT FOR 20us;
    END LOOP;
    WAIT;
END PROCESS;

END rtl;