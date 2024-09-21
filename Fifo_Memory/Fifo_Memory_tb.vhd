
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.numeric_std.ALL;
USE work.MyLib.ALL;
ENTITY Fifo_Memory_tb IS
END ENTITY;

ARCHITECTURE behavior OF Fifo_Memory_tb IS

    -- 1. Parameter definitions
    CONSTANT ENDTIME : TIME := 40000 ns;

    -- 2. DUT Input signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL wr : STD_LOGIC := '0';
    SIGNAL rd : STD_LOGIC := '0';
    SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL base_addr : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

    -- 3. DUT Output signals
    SIGNAL data_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- SIGNAL fifo_empty : STD_LOGIC;
    -- SIGNAL fifo_full : STD_LOGIC;
    -- SIGNAL fifo_threshold : STD_LOGIC;
    -- SIGNAL fifo_overflow : STD_LOGIC;
    -- SIGNAL fifo_underflow : STD_LOGIC;

    -- 4. Memory for self-checking
    SIGNAL waddr : INTEGER := 0;
    SIGNAL raddr : INTEGER := 0;

BEGIN

    -- 5. DUT Instantiation (Replace fifo_mem with your DUT entity and architecture)
    dut_inst : Fifo_Memory
    GENERIC MAP(
        ADDR_WIDTH => 4,
        DATA_WIDTH => 8
    )
    PORT MAP(
        clk => clk,
        wr => wr,
        rd => rd,
        data_in => data_in,
        data_out => data_out,
        base_addr => base_addr
    );

    -- 6. Clock generation
    clock_gen : PROCESS
    BEGIN
        LOOP
            clk <= NOT clk AFTER 10 ns; -- DELAY equivalent
            WAIT FOR 10 ns;
        END LOOP;
    END PROCESS;

    -- 8. Operation process (Write/Read data)
    operation_proc : PROCESS
    BEGIN

        FOR i IN 0 TO 16 LOOP
            WAIT FOR 50 ns; -- DELAY * 5
            data_in <= STD_LOGIC_VECTOR(unsigned(to_unsigned(i, 8)));
            wr <= '1';
            WAIT FOR 20 ns; -- DELAY * 2
            wr <= '0';
        END LOOP;
        WAIT FOR 10 ns; -- DELAY
        FOR i IN 0 TO 16 LOOP
            WAIT FOR 20 ns; -- DELAY * 2
            rd <= '1';
            WAIT FOR 20 ns; -- DELAY * 2
            rd <= '0';
        END LOOP;
    END PROCESS;
    -- 10. End of Simulation
    end_simulation : PROCESS
    BEGIN
        WAIT FOR ENDTIME;
        REPORT "=== Simulation Ended ===";
    END PROCESS;

END ARCHITECTURE;