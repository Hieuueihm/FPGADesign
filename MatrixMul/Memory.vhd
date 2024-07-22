LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Memory IS
    GENERIC (
        DATA_WIDTH : INTEGER;
        ADDR_WIDTH : INTEGER); -- Width of the address bus

    PORT (

        Din : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        ADDR : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0); -- Address input
        WE, RE : IN STD_LOGIC;
        CLK : IN STD_LOGIC;
        Dout : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) -- Data output
    );
END ENTITY Memory;
ARCHITECTURE rtl OF Memory IS
    TYPE memory_type IS ARRAY (2 ** ADDR_WIDTH - 1 DOWNTO 0) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL memory : memory_type := (OTHERS => (OTHERS => '0'));
BEGIN
    PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            IF WE = '1' THEN
                memory(TO_INTEGER(UNSIGNED(ADDR))) <= Din; -- Write data to memory
            END IF;
            IF RE = '1' THEN
                Dout <= memory(TO_INTEGER(UNSIGNED(ADDR))); -- Read data from memory
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;