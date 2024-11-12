LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ScalingAccumulator IS
    GENERIC (WIDTH : INTEGER := 8); -- Width of accumulator
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        scale : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0); -- Scaling factor
        data_in : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0); -- Input data to accumulate
        accum_clr : IN STD_LOGIC; -- Accumulator clear signal
        result : OUT STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)); -- Accumulated result
END ScalingAccumulator;

ARCHITECTURE Behavioral OF ScalingAccumulator IS
    SIGNAL accumulator : STD_LOGIC_VECTOR(WIDTH DOWNTO 0); -- Extra bit for overflow
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            accumulator <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF accum_clr = '1' THEN
                accumulator <= (OTHERS => '0'); -- Clear accumulator
            ELSE
                accumulator <= (accumulator + (data_in * scale)); -- Accumulate scaled input
            END IF;
        END IF;
    END PROCESS;

    result <= accumulator(WIDTH - 1 DOWNTO 0); -- Output only the WIDTH bits
END Behavioral;