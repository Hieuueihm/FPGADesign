LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY Memory_Array IS
    GENERIC (
        ADDR_WIDTH : INTEGER := 4;
        DATA_WIDTH : INTEGER := 8
    );
    PORT (
        clk : IN STD_LOGIC;
        fifo_re : IN STD_LOGIC;
        fifo_we : IN STD_LOGIC;
        rptr : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        wptr : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY Memory_Array;

ARCHITECTURE behavioral OF Memory_Array IS
    TYPE memory_type IS ARRAY (2 ** ADDR_WIDTH - 1 DOWNTO 0) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL memory : memory_type := (OTHERS => (OTHERS => '0'));
    SIGNAL Dout : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

    process1 : PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (fifo_we = '1') THEN
                memory(TO_INTEGER(UNSIGNED(wptr))) <= data_in; -- Write data to memory
            END IF;
        END IF;
    END PROCESS;

    process2 : PROCESS (Clk)

    BEGIN
        IF (rising_edge(clk)) THEN
            IF (fifo_re = '1') THEN
                Dout <= memory(TO_INTEGER(UNSIGNED(rptr))); -- Read data from memory
            END IF;
        END IF;
    END PROCESS;

    data_out <= Dout;
END ARCHITECTURE behavioral;