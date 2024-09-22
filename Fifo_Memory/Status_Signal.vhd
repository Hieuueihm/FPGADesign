LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
-- generate fifo_full and fifo_empty signal
ENTITY Status_Signal IS
    GENERIC (
        ADDR_WIDTH : INTEGER := 4
    );
    PORT (
        clk : IN STD_LOGIC;
        fifo_we : IN STD_LOGIC;
        fifo_re : IN STD_LOGIC;
        wptr : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        rptr : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        fifo_full : OUT STD_LOGIC;
        fifo_empty : OUT STD_LOGIC
    );
END ENTITY Status_Signal;

ARCHITECTURE rtl OF Status_Signal IS
    SIGNAL full, empty : STD_LOGIC;
    SIGNAL memo_equal : STD_LOGIC;
BEGIN
    fifo_full <= full;
    fifo_empty <= empty;
    memo_equal <= '1' WHEN (wptr(ADDR_WIDTH - 1 DOWNTO 0) = rptr(ADDR_WIDTH - 1 DOWNTO 0)) ELSE
        '0';
    full <= '1' WHEN (unsigned(wptr) = to_unsigned(2 ** ADDR_WIDTH - 1, ADDR_WIDTH)) ELSE
        '0';

    empty <= memo_equal;
END ARCHITECTURE rtl;