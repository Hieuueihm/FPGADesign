LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Regn IS
    GENERIC (DATA_WIDTH : INTEGER);
    PORT (
        RST, CLK : IN STD_LOGIC;
        En : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY Regn;
ARCHITECTURE rtl OF Regn IS

BEGIN
    PROCESS (RST, CLK)
    BEGIN
        IF (RST = '1') THEN
            Q <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF (En = '1') THEN
                Q <= D;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;