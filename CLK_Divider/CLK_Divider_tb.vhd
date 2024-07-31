LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.MyLib.ALL;
ENTITY CLK_Divider_tb IS

END ENTITY CLK_Divider_tb;

ARCHITECTURE rtl OF CLK_Divider_tb IS
    SIGNAL clk_50 : STD_LOGIC := '0';

    --Outputs
    SIGNAL clk_1s : STD_LOGIC;

    -- Clock period definitions
    CONSTANT clk_50_period : TIME := 20 ns;
BEGIN
    uut : CLK_Divider PORT MAP(
        clk_in => clk_50,
        clk_out => clk_1s
    );

    -- creating clock
    clk_50_process : PROCESS
    BEGIN
        clk_50 <= '0';
        WAIT FOR clk_50_period/2;
        clk_50 <= '1';
        WAIT FOR clk_50_period/2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        WAIT FOR clk_50_period * 10;
        WAIT;
    END PROCESS;

END ARCHITECTURE rtl;