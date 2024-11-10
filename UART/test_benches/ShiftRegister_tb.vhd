LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ShiftRegister_tb IS
    GENERIC (
        CHAIN_LENGTH : INTEGER := 8;
        SHIFT_DIRECTION : CHARACTER := 'R' -- L is shift to the left, R is shift to the right
    );
END ENTITY ShiftRegister_tb;

ARCHITECTURE bev OF ShiftRegister_tb IS
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
    SIGNAL clk : STD_LOGIC;
    SIGNAL rst : STD_LOGIC;

    SIGNAL shiftEn : STD_LOGIC;
    SIGNAL Din : STD_LOGIC;
    SIGNAL Dout : STD_LOGIC_VECTOR(CHAIN_LENGTH - 1 DOWNTO 0);

BEGIN

    DUT : ShiftRegister
    GENERIC MAP(
        CHAIN_LENGTH => CHAIN_LENGTH,
        SHIFT_DIRECTION => SHIFT_DIRECTION)
    PORT MAP(
        clk => clk,
        rst => rst,

        shiftEn => shiftEn,
        Din => Din,
        Dout => Dout
    );

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
        shiftEn <= '0';
        Din <= '0';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        -- 0101 0001
        Din <= '1';
        WAIT FOR 4.3 us;
        WAIT UNTIL rising_edge(clk);
        shiftEn <= '1';
        WAIT UNTIL rising_edge(clk);
        shiftEn <= '0';
        WAIT FOR 4.3 us;

        FOR i IN 0 TO 2 LOOP
            Din <= '0';
            WAIT FOR 4.3 us;
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '1';
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '0';
            WAIT FOR 4.3 us;
        END LOOP;

        FOR i IN 0 TO 1 LOOP
            Din <= '1';
            WAIT FOR 4.3 us;
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '1';
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '0';
            WAIT FOR 4.3 us;
            Din <= '0';
            WAIT FOR 4.3 us;
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '1';
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '0';

        END LOOP;

        WAIT;
    END PROCESS;
END ARCHITECTURE bev;