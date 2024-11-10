
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Serialiser IS

    GENERIC (
        DATA_WIDTH : INTEGER := 8;
        DEFAULT_STATE : STD_LOGIC := '1'
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        shiftEn : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        Din : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Dout : OUT STD_LOGIC
    );

END ENTITY;
ARCHITECTURE rtl OF Serialiser IS
    SIGNAL shiftRegister : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
BEGIN
    Dout <= shiftRegister(0);
    SerialiserProcess : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            shiftRegister <= (OTHERS => DEFAULT_STATE);
        ELSIF rising_edge(clk) THEN
            IF Load = '1' THEN
                shiftRegister <= Din;
            ELSIF shiftEn = '1' THEN
                shiftRegister <= DEFAULT_STATE & shiftRegister(shiftRegister'left DOWNTO 1);
            END IF;

        END IF;
    END PROCESS;

END rtl;