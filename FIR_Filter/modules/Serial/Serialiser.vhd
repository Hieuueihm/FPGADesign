LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY Serialiser IS
    GENERIC (

        DATA_WIDTH : INTEGER := 8;
        DEFAULT_STATE : STD_LOGIC := '0'
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        shiftEn : IN STD_LOGIC;
        plsr_load : IN STD_LOGIC;
        Din : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Dout : OUT STD_LOGIC
    );
END ENTITY Serialiser;

ARCHITECTURE rtl OF Serialiser IS
    SIGNAL shiftRegister : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN
    Dout <= shiftRegister(0);
    SerialProcess : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            shiftRegister <= (OTHERS => DEFAULT_STATE);
        ELSIF rising_edge(clk) THEN
            IF plsr_load = '1' THEN
                shiftRegiste <= Din;
            ELSIF shiftEn = '1' THEN
                shiftRegister <= DEFAULT_STATE & shiftRegister(shiftRegister'left DOWNTO 1);
            END IF;
        END IF;
    END PROCESS SerialProcess;
END ARCHITECTURE rtl;