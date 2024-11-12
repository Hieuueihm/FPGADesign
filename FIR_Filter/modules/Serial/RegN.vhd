LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RegN IS
    GENERIC (

        DATA_WIDTH : INTEGER := 8;
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY RegN;

ARCHITECTURE rtl OF RegN IS
    SIGNAL Dout : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
BEGIN

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            Dout <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            Dout <= D;
        END IF;
    END PROCESS;
    Q <= Dout;
END ARCHITECTURE rtl;