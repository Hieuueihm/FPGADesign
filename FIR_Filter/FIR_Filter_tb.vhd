LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.TEXTIO.ALL;

ENTITY FIR_Filter_tb IS

END ENTITY FIR_Filter_tb;

ARCHITECTURE behavioral OF FIR_Filter_tb IS
    COMPONENT FIR_Filter IS

        GENERIC (
            DATA_INPUT_WIDTH : INTEGER := 8;
            COEF_WIDTH : INTEGER := 8;
            DATA_OUTPUT_WIDTH : INTEGER := 16;
            TAP : INTEGER := 11;
            GUARD : INTEGER := 0
        );
        PORT (
            CLK : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            Din : IN STD_LOGIC_VECTOR(DATA_INPUT_WIDTH - 1 DOWNTO 0);
            Dout : OUT STD_LOGIC_VECTOR(DATA_OUTPUT_WIDTH - 1 DOWNTO 0)

        );
    END COMPONENT;
    SIGNAL Din : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL output_ready : STD_LOGIC := '0';
    SIGNAL Dout : STD_LOGIC_VECTOR(15 DOWNTO 0);
    FILE my_input : TEXT OPEN READ_MODE IS "input101.txt";
    FILE my_output : TEXT OPEN WRITE_MODE IS "output101_functional_sim.txt";
BEGIN
    FIR_int : FIR_Filter
    GENERIC MAP(
        DATA_INPUT_WIDTH => 8,
        DATA_OUTPUT_WIDTH => 16,
        coef_width => 8,
        tap => 11,
        guard => 0)
    PORT MAP(
        Din => Din,
        Clk => Clk,
        RST => reset,
        Dout => Dout
    );
    PROCESS (clk)
    BEGIN
        Clk <= NOT Clk AFTER 10 ns;
    END PROCESS;
    reset <= '1', '1' AFTER 100 ns, '0' AFTER 503 ns;
    PROCESS (clk)
        VARIABLE my_input_line : LINE;
        VARIABLE input1 : INTEGER;
    BEGIN
        IF reset = '1' THEN
            Din <= (OTHERS => '0');
            output_ready <= '0';
        ELSIF rising_edge(clk) THEN
            readline(my_input, my_input_line);
            read(my_input_line, input1);
            Din <= STD_LOGIC_VECTOR(to_signed(input1, 8));
            output_ready <= '1';
        END IF;
    END PROCESS;
    PROCESS (clk)
        VARIABLE my_output_line : LINE;
        VARIABLE input1 : INTEGER;
    BEGIN
        IF falling_edge(clk) THEN
            IF output_ready = '1' THEN
                write(my_output_line, to_integer(signed(Dout)));
                writeline(my_output, my_output_line);
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;