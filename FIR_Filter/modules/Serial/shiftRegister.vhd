LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY ShiftRegister IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        shiftEn : IN STD_LOGIC;
        Din : IN STD_LOGIC;
        Dout : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)

    );
END ENTITY ShiftRegister;

ARCHITECTURE rtl OF ShiftRegister IS
BEGIN

END ARCHITECTURE rtl;