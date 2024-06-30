

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.MyLib.ALL;
ENTITY GCD_tb IS

END ENTITY;
ARCHITECTURE BEV OF GCD_tb IS
    CONSTANT DATA_WIDTH : INTEGER := 8;
    SIGNAL CLK, RST, Start_i : STD_LOGIC;
    SIGNAL X_i, Y_i : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL GCD_o : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL Done_o : STD_LOGIC;

BEGIN

    UUT : GCD
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        Start_i,
        X_i, Y_i,
        RST, CLK,
        GCD_o,
        Done_o
    );

    -- CLOCK
    CLK_sig : PROCESS
    BEGIN
        CLK <= '1';
        WAIT FOR 1 ns;
        CLK <= '0';
        WAIT FOR 1 ns;
    END PROCESS;
    --stimulus
    Stimulus : PROCESS
    BEGIN
        Start_i <= '0';
        RST <= '1';
        WAIT FOR 10 ns;
        RST <= '0';
        WAIT FOR 10 ns;

        -- case 1 : X = 4 , Y =  12 => ucln = 4 
        X_i <= X"0f";
        Y_i <= X"06";
        Start_i <= '1';
        WAIT UNTIL Done_o = '1';
        WAIT FOR 1 ns;
        Start_i <= '0';
        WAIT FOR 100 ns;
        -- case 2 x = 15, y = 6 => ucln = 3

        X_i <= X"06";
        Y_i <= X"0f";
        Start_i <= '1';
        WAIT UNTIL Done_o = '1';
        WAIT FOR 1 ns;
        Start_i <= '0';
        WAIT FOR 100 ns;
    END PROCESS;

END ARCHITECTURE;