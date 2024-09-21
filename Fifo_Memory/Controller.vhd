-- generate signal to control

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY Controller IS
    GENERIC (
        ADDR_WIDTH : INTEGER := 4
    );
    PORT (
        clk : IN STD_LOGIC;
        fifo_we : IN STD_LOGIC;
        fifo_rd : IN STD_LOGIC;
        wptr : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        rptr : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        fifo_full : OUT STD_LOGIC;
        fifo_empty : OUT STD_LOGIC;
    );
END ENTITY Controller;

ARCHITECTURE rtl OF Controller IS
    SIGNAL full, empty : STD_LOGIC;
    SIGNAL pointer_equal : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
BEGIN

END ARCHITECTURE rtl;