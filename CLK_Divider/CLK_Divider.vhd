LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
--- div 2 
ENTITY CLK_Divider IS
    PORT (
        clk_in : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC
    );
END ENTITY CLK_Divider;

ARCHITECTURE rtl OF CLK_Divider IS
    SIGNAL Divisor : STD_LOGIC_VECTOR(27 DOWNTO 0) := (OTHERS => '0');

BEGIN
    PROCESS (clk_in)
    BEGIN
        IF (rising_edge(clk_in)) THEN
            Divisor <= Divisor + x"0000001";
            IF (Divisor >= x"0000001") THEN
                Divisor <= x"0000000";
            END IF;
            IF (Divisor < x"0000001") THEN
                clk_out <= '1';
            ELSE
                clk_out <= '0';
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;