
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Serialiser_tb IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8;
        DEFAULT_STATE : STD_LOGIC := '1'
    );

END ENTITY;

ARCHITECTURE rtl OF Serialiser_tb IS
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

    SIGNAL clk : STD_LOGIC;
    SIGNAL rst : STD_LOGIC;
    SIGNAL shiftEn : STD_LOGIC;
    SIGNAL Load : STD_LOGIC;
    SIGNAL Din : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL Dout : STD_LOGIC;
BEGIN

    DUT : Serialiser
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH,
        DEFAULT_STATE => DEFAULT_STATE
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        shiftEn => shiftEn,
        Load => Load,
        Din => Din,
        Dout => Dout
    );

    clkPrs : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS;
    simulate : PROCESS

    BEGIN
        rst <= '1';
        shiftEn <= '0';
        Load <= '0';
        Din <= (OTHERS => '0');
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        WAIT UNTIL rising_edge(clk);
        Load <= '1';
        Din <= x"AB";
        WAIT UNTIL rising_edge(clk);
        Load <= '0';
        Din <= (OTHERS => '0');

        FOR i IN 0 TO 7 LOOP
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '1';
            WAIT UNTIL rising_edge(clk);
            shiftEn <= '0';
        END LOOP;
        WAIT;

    END PROCESS;
END rtl;