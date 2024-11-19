LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY std;
USE STD.textio.ALL;
ENTITY FIR IS
    GENERIC (
        FILTER_TAPS : INTEGER := 11;
        INPUT_WIDTH : INTEGER RANGE 8 TO 25 := 8;
        COEF_WIDTH : INTEGER RANGE 8 TO 18 := 8;
        OUTPUT_WIDTH : INTEGER RANGE 8 TO 43 := 16
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        Din : IN STD_LOGIC_VECTOR (INPUT_WIDTH - 1 DOWNTO 0);
        Dout : OUT STD_LOGIC_VECTOR (OUTPUT_WIDTH - 1 DOWNTO 0)
    );
END FIR;

ARCHITECTURE Behavioral OF FIR IS
    TYPE input_registers IS ARRAY(0 TO FILTER_TAPS - 1) OF signed(INPUT_WIDTH - 1 DOWNTO 0);
    SIGNAL input_s : input_registers := (OTHERS => (OTHERS => '0'));

    TYPE output1_registers IS ARRAY(0 TO FILTER_TAPS - 1) OF signed(INPUT_WIDTH + COEF_WIDTH - 1 DOWNTO 0);
    SIGNAL output_delay1_s : output1_registers := (OTHERS => (OTHERS => '0'));

    TYPE delayout_registers IS ARRAY(0 TO FILTER_TAPS - 1) OF signed(INPUT_WIDTH + COEF_WIDTH - 1 DOWNTO 0);
    SIGNAL delay_s : delayout_registers := (OTHERS => (OTHERS => '0'));
    -- Chebyshev 1kH LPF, causes overflow at low freq. 
    TYPE COEFFICIENT_TYPE IS ARRAY (0 TO FILTER_TAPS - 1) OF signed(COEF_WIDTH - 1 DOWNTO 0);
    SIGNAL coefficients : COEFFICIENT_TYPE :=
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
BEGIN

    Dout <= STD_LOGIC_VECTOR(delay_s(0)(OUTPUT_WIDTH - 1 DOWNTO 0));
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            FOR i IN 0 TO FILTER_TAPS - 1 LOOP
                input_s(i) <= (OTHERS => '0');
                output_delay1_s(i) <= (OTHERS => '0');
                delay_s(i) <= (OTHERS => '0');
            END LOOP;
        ELSIF rising_edge(clk) THEN
            FOR i IN 0 TO FILTER_TAPS - 1 LOOP
                input_s(i) <= signed(Din);
                IF (i < FILTER_TAPS - 1) THEN
                    output_delay1_s(i) <= input_s(i) * coefficients(i);
                    delay_s(i) <= output_delay1_s(i) + delay_s(i + 1);
                    REPORT "output_delay1_s(" & INTEGER'IMAGE(i) & ") = " & INTEGER'IMAGE(to_integer(output_delay1_s(i)));
                    REPORT "delay_s(" & INTEGER'IMAGE(i) & ") = " & INTEGER'IMAGE(to_integer(delay_s(i)));
                ELSIF i = FILTER_TAPS - 1 THEN
                    output_delay1_s(i) <= input_s(i) * coefficients(i);
                    delay_s(i) <= output_delay1_s(i);
                    REPORT "output_delay1_s(" & INTEGER'IMAGE(i) & ") = " & INTEGER'IMAGE(to_integer(output_delay1_s(i)));
                    REPORT "delay_s(" & INTEGER'IMAGE(i) & ") = " & INTEGER'IMAGE(to_integer(delay_s(i)));

                END IF;
            END LOOP;
        END IF;

    END PROCESS;

END Behavioral;