
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY Counter IS
    GENERIC (ADDR_WIDTH : INTEGER);
    PORT (
        RST, CLK : IN STD_LOGIC;
        En : IN STD_LOGIC;
        LDI : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0); -- Data input for loading
        Q : OUT STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) -- Counter output
    );
END ENTITY Counter;

ARCHITECTURE rtl OF Counter IS
    SIGNAL counter_value : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    CONSTANT MAX_COUNT : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := (OTHERS => '1'); -- Maximum counter value
BEGIN
    -- when rst = '1' => load counter_value = d
    -- when rising_edge(clk) => if ld = '1' -> load Q = current counter
    -- else if en = '1' -> count
    PROCESS (RST, CLK)
    BEGIN
        IF RST = '1' THEN
            counter_value <= (OTHERS => '0');-- counter_value = D when rst
        ELSIF rising_edge(CLK) THEN
            IF LDI = '1' THEN
                counter_value <= D;
            ELSIF En = '1' THEN
                IF unsigned(counter_value) = unsigned(MAX_COUNT) THEN
                    counter_value <= (OTHERS => '0'); -- Reset counter to 0 when max value is reached
                ELSE
                    counter_value <= STD_LOGIC_VECTOR(unsigned(counter_value) + 1); -- Increment the counter
                END IF;
            END IF;
        END IF;
    END PROCESS;
    Q <= counter_value;

END ARCHITECTURE rtl;