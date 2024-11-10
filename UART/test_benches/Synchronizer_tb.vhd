LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Synchronizer_tb IS
    GENERIC (
        IDLE_STATE : STD_LOGIC := '1'
    );
END ENTITY Synchronizer_tb;

ARCHITECTURE bev OF Synchronizer_tb IS
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

    SIGNAL clk : STD_LOGIC;
    SIGNAL rst : STD_LOGIC;
    SIGNAL async : STD_LOGIC;
    SIGNAL synced : STD_LOGIC;
BEGIN

    DUT : Synchronizer
    GENERIC MAP(IDLE_STATE => IDLE_STATE)
    PORT MAP(clk, rst, async, synced);

    clkProcess : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS;
    simu : PROCESS
    BEGIN
        rst <= '1';
        async <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;
        async <= '0';
        WAIT;
    END PROCESS;
END ARCHITECTURE bev;