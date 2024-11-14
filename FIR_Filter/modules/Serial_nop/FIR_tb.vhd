LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;
USE STD.TEXTIO.ALL;

ENTITY FIR_tb IS
    GENERIC (
        FILTER_TAPS : INTEGER := 11;
        INPUT_WIDTH : INTEGER RANGE 8 TO 32 := 8;
        COEF_WIDTH : INTEGER RANGE 8 TO 32 := 8;
        OUTPUT_WIDTH : INTEGER RANGE 8 TO 32 := 16 -- <COEF_WIDTH + INPUT_WIDTH - 1>
    );
END ENTITY FIR_tb;
ARCHITECTURE Behavioral OF FIR_tb IS

    COMPONENT FIR IS
        GENERIC (
            FILTER_TAPS : INTEGER := 11;
            INPUT_WIDTH : INTEGER RANGE 8 TO 32 := 8;
            COEF_WIDTH : INTEGER RANGE 8 TO 32 := 8;
            OUTPUT_WIDTH : INTEGER RANGE 8 TO 32 := 16 -- <COEF_WIDTH + INPUT_WIDTH - 1>
        );
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            --OUTPUTS
            Din : IN STD_LOGIC_VECTOR(INPUT_WIDTH - 1 DOWNTO 0);
            Dout : OUT STD_LOGIC_VECTOR(OUTPUT_WIDTH - 1 DOWNTO 0)

        );
    END COMPONENT;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC;
    SIGNAL start : STD_LOGIC;
    SIGNAL Din : STD_LOGIC_VECTOR(INPUT_WIDTH - 1 DOWNTO 0);
    SIGNAL Dout : STD_LOGIC_VECTOR(OUTPUT_WIDTH - 1 DOWNTO 0);
    SIGNAL Done : STD_LOGIC;

    FILE my_input : TEXT OPEN READ_MODE IS "input100.txt";
    FILE my_output : TEXT OPEN WRITE_MODE IS "output100_functional_sim.txt";
BEGIN
    DUT : FIR
    GENERIC MAP(
        FILTER_TAPS => FILTER_TAPS,
        INPUT_WIDTH => INPUT_WIDTH,
        COEF_WIDTH => COEF_WIDTH,
        OUTPUT_WIDTH => OUTPUT_WIDTH -- <COEF_WIDTH + INPUT_WIDTH - 1>
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        --OUTPUTS
        Din => Din,
        Dout => Dout

    );
    clk <= NOT clk AFTER 10 ns;

    PROCESS

    BEGIN
        rst <= '1';
        Din <= (OTHERS => '0');
        start <= '0';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;
        Din <= STD_LOGIC_VECTOR(to_signed(-7, INPUT_WIDTH));
        WAIT FOR 200 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE Behavioral;