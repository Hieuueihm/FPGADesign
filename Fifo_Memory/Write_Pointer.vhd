LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY Write_Pointer IS
    GENERIC (
        ADDR_WIDTH : INTEGER := 4
    );
    PORT (
        clk : IN STD_LOGIC;
        wr : IN STD_LOGIC;
        base_addr : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        wptr : OUT STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        fifo_we : OUT STD_LOGIC
    );
END ENTITY Write_Pointer;
ARCHITECTURE behavioral OF Write_Pointer IS
    SIGNAL write_addr : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL we : STD_LOGIC; -- fifo _we 
    SIGNAL initialized : BOOLEAN := FALSE; -- To track initialization state

BEGIN

    wptr <= write_addr;
    fifo_we <= we;
    we <= wr;

    PROCESS (clk) BEGIN
        IF (rising_edge(clk)) THEN
            IF (NOT initialized) THEN
                write_addr <= base_addr;
                initialized <= TRUE;
            ELSIF (we = '1') THEN
                write_addr <= write_addr + STD_LOGIC_VECTOR(UNSIGNED(TO_UNSIGNED(1, ADDR_WIDTH)));
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;