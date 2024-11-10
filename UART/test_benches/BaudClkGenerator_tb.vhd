
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY std;
USE std.standard.TIME;

ENTITY BaudClkGenerator_tb IS
END ENTITY;
ARCHITECTURE rtl OF BaudClkGenerator_tb IS

    COMPONENT BaudClkgenerator IS
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

    SIGNAL clk : STD_LOGIC;
    SIGNAL rst : STD_LOGIC;
    SIGNAL start : STD_LOGIC;
    SIGNAL baudclk : STD_LOGIC;
    SIGNAL ready : STD_LOGIC;
BEGIN

    DUT : BaudClkGenerator
    GENERIC MAP(
        NUMBER_OF_CLOCKS => 10,
        SYS_CLK_FREQ => 50000000,
        BAUD_RATE => 115200,
        IS_RX => false
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        start => start,
        baudclk => baudclk,
        ready => ready
    );
    processClkSim : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS;
    simulate : PROCESS
    BEGIN
        rst <= '1';
        start <= '0';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT UNTIL rising_edge(clk);
        start <= '1';
        WAIT UNTIL rising_edge(clk);
        start <= '0';

        WAIT;
    END PROCESS;
END rtl;