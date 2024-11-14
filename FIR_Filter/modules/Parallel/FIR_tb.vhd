LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FIR_tb IS
END FIR_tb;

ARCHITECTURE behavior OF FIR_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT FIR IS
        GENERIC (
            FILTER_TAPS : INTEGER := 11;
            INPUT_WIDTH : INTEGER := 8;
            COEF_WIDTH : INTEGER := 8;
            OUTPUT_WIDTH : INTEGER := 16
        );
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            Din : IN STD_LOGIC_VECTOR (INPUT_WIDTH - 1 DOWNTO 0);
            Dout : OUT STD_LOGIC_VECTOR (OUTPUT_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- Signals for UUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL Din : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Dout : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- Clock period definition
    CONSTANT clk_period : TIME := 20 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : FIR
    PORT MAP(
        clk => clk,
        rst => reset,
        Din => Din,
        Dout => Dout
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Reset the system
        reset <= '1';
        WAIT FOR clk_period * 2;
        reset <= '0';

        Din <= "11111001";
        WAIT FOR clk_period;
        WAIT FOR clk_period * 20;

        WAIT;
    END PROCESS;

END behavior;