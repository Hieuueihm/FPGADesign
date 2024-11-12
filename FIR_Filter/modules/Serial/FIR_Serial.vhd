LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY FIR_Serial IS

    GENERIC (
        FILTER_TAPS : INTEGER := 60;
        INPUT_WIDTH : INTEGER RANGE 8 TO 32 := 16;
        COEF_WIDTH : INTEGER RANGE 8 TO 32 := 16;
        OUTPUT_WIDTH : INTEGER RANGE 8 TO 32 := 16;
        ADDR_WIDTH : INTEGER := 8

    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        start : IN STD_LOGIC;
        Din : IN STD_LOGIC_VECTOR(INPUT_WIDTH - 1 DOWNTO 0);
        Dout : OUT STD_LOGIC_VECTOR(OUTPUT_WIDTH - 1 DOWNTO 0)
    );
END ENTITY FIR_Serial;
ARCHITECTURE rtl OF FIR_Serial IS
    TYPE coefficients IS ARRAY (0 TO FILTER_TAPS - 1) OF signed(15 DOWNTO 0);
    TYPE FSM IS (IDLE, ACTIVE);
    SIGNAL State : FSM;
    SIGNAL start_delay;
    SIGNAL coeff_s : coefficients := (
        -- 500Hz Blackman LPF
        x"0000", x"0001", x"0005", x"000C",
        x"0016", x"0025", x"0037", x"004E",
        x"0069", x"008B", x"00B2", x"00E0",
        x"0114", x"014E", x"018E", x"01D3",
        x"021D", x"026A", x"02BA", x"030B",
        x"035B", x"03AA", x"03F5", x"043B",
        x"047B", x"04B2", x"04E0", x"0504",
        x"051C", x"0528", x"0528", x"051C",
        x"0504", x"04E0", x"04B2", x"047B",
        x"043B", x"03F5", x"03AA", x"035B",
        x"030B", x"02BA", x"026A", x"021D",
        x"01D3", x"018E", x"014E", x"0114",
        x"00E0", x"00B2", x"008B", x"0069",
        x"004E", x"0037", x"0025", x"0016",
        x"000C", x"0005", x"0001", x"0000");

BEGIN

    FIRProcess : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            State <= IDLE;
        ELSIF rising_edge(clk) THEN
            start_delay <= start;
            CASE State IS
                WHEN IDLE =>
                    IF start_delay <= '0' AND start = '1' THEN
                        State <= ACTIVE;
                    END IF;
                WHEN ACTIVE =>

                WHEN OTHERS =>
                    State <= IDLE;

            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;