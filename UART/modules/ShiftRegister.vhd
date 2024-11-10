LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY ShiftRegister IS
    GENERIC (
        CHAIN_LENGTH : INTEGER := 8;
        SHIFT_DIRECTION : CHARACTER := 'R' -- L is shift to the left, R is shift to the right
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;

        shiftEn : IN STD_LOGIC;
        Din : IN STD_LOGIC;
        Dout : OUT STD_LOGIC_VECTOR(CHAIN_LENGTH - 1 DOWNTO 0)

    );
END ENTITY ShiftRegister;

ARCHITECTURE rtl OF ShiftRegister IS
    SIGNAL SR : STD_LOGIC_VECTOR(CHAIN_LENGTH - 1 DOWNTO 0);
BEGIN
    Dout <= SR;

    SHIFT_TO_THE_RIGHT : IF SHIFT_DIRECTION = 'R' GENERATE
        ShiftProcess : PROCESS (rst, clk)
        BEGIN
            IF rst = '1' THEN
                SR <= (OTHERS => '0');
            ELSIF rising_edge(clk) THEN
                IF shiftEn = '1' THEN
                    SR <= Din & SR(SR'left DOWNTO 1);
                END IF;
            END IF;
        END PROCESS;
    END GENERATE;
    SHIFT_TO_THE_LEFT : IF SHIFT_DIRECTION = 'L' GENERATE
        ShiftProcess : PROCESS (rst, clk)
        BEGIN
            IF rst = '1' THEN
                SR <= (OTHERS => '0');
            ELSIF rising_edge(clk) THEN
                IF shiftEn = '1' THEN
                    SR <=  SR(SR'left - 1 DOWNTO 0) & Din;
                END IF;
            END IF;
        END PROCESS;
    END GENERATE;
END ARCHITECTURE rtl;