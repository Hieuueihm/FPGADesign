LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY FIR IS
    GENERIC (
        FILTER_TAPS : INTEGER := 11;
        INPUT_WIDTH : INTEGER RANGE 8 TO 32 := 8;
        COEF_WIDTH : INTEGER RANGE 8 TO 32 := 8;
        OUTPUT_WIDTH : INTEGER RANGE 8 TO 32 := 16 -- <COEF_WIDTH + INPUT_WIDTH - 1>
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        start : IN STD_LOGIC;
        --OUTPUTS
        Din : IN STD_LOGIC_VECTOR(INPUT_WIDTH - 1 DOWNTO 0);
        Dout : OUT STD_LOGIC_VECTOR(OUTPUT_WIDTH - 1 DOWNTO 0);
        Done : OUT STD_LOGIC

    );
END ENTITY FIR;

ARCHITECTURE Behavioral OF FIR IS
    TYPE input_registers IS ARRAY(0 TO FILTER_TAPS - 1) OF signed(INPUT_WIDTH - 1 DOWNTO 0);
    SIGNAL delay_line_s : input_registers := (OTHERS => (OTHERS => '0'));

    TYPE COEFFICIENT_TYPE IS ARRAY (0 TO FILTER_TAPS - 1) OF signed(COEF_WIDTH - 1 DOWNTO 0);
    CONSTANT coefficients : COEFFICIENT_TYPE :=
    (X"F1",
    X"F3",
    X"07",
    X"26",
    X"42",
    X"4E",
    X"42",
    X"26",
    X"07",
    X"F3",
    X"F1"
    );
    SIGNAL start_delay : STD_LOGIC := 'X'; -- to determine the rising edge of start 
    TYPE FSM IS (IDLE, ACTIVE, DONEIT);
    SIGNAL STATE : FSM;
    SIGNAL accumulator : signed(INPUT_WIDTH + COEF_WIDTH - 1 DOWNTO 0);
    SIGNAL current_tap : INTEGER RANGE 0 TO FILTER_TAPS - 1;

BEGIN
    -- 15 -> 
    Dout <= STD_LOGIC_VECTOR(accumulator(OUTPUT_WIDTH - 1 DOWNTO 0));
    FIRProcess : PROCESS (clk, rst)
        VARIABLE sum : signed(INPUT_WIDTH + COEF_WIDTH - 1 DOWNTO 0);
    BEGIN
        IF rst = '1' THEN
            Done <= '0';
            accumulator <= (OTHERS => '0');
            sum := (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            start_delay <= start;
            CASE STATE IS
                WHEN IDLE =>
                    IF start = '1' AND start_delay <= '0' THEN
                        STATE <= ACTIVE;
                        current_tap <= FILTER_TAPS - 1;
                        delay_line_s(FILTER_TAPS - 1) <= signed(Din);
                    END IF;
                WHEN ACTIVE =>
                    IF current_tap > 0 THEN
                        sum := delay_line_s(current_tap) * coefficients(current_tap);
                        accumulator <= accumulator + sum;
                        delay_line_s(current_tap) <= delay_line_s(current_tap - 1);
                        current_tap <= current_tap - 1;
                    ELSE
                        STATE <= DONEIT;
                    END IF;
                WHEN DONEIT =>
                    Done <= '1';
                    STATE <= IDLE;
                WHEN OTHERS =>
                    STATE <= IDLE;
            END CASE;

        END IF;
    END PROCESS;

END ARCHITECTURE Behavioral;