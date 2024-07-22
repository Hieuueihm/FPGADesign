LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MyLib.ALL;

ENTITY sorter_tb IS
END ENTITY sorter_tb;

ARCHITECTURE BEV OF sorter_tb IS

    -- Constants for the test
    CONSTANT DATA_WIDTH : INTEGER := 4;
    CONSTANT ADDR_WIDTH : INTEGER := 4;
    CONSTANT K : INTEGER := 8;

    -- Signals to interface with the DUT
    SIGNAL RST, CLK : STD_LOGIC;
    SIGNAL Start : STD_LOGIC;
    SIGNAL Data_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL WE : STD_LOGIC := '0';
    SIGNAL Addr_in : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Done : STD_LOGIC;
    SIGNAL Data_out : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL RE : STD_LOGIC := '0';

    -- Internal signals for the testbench
    TYPE data_array IS ARRAY(0 TO K - 1) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL input_array : data_array := (
        "0100", "0010", "0110", "0001", "1000", "0111", "0011", "0000"
    );
    SIGNAL Addr_in_tmp : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);

BEGIN
    DUT : Sorter
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH,
        ADDR_WIDTH => ADDR_WIDTH,
        K => K
    )
    PORT MAP(
        RST => RST,
        CLK => CLK,
        Start => Start,
        Data_in => Data_in,
        WE => WE,
        Addr_in => Addr_in,
        Done => Done,
        Data_out => Data_out,
        RE => RE
    );

    -- Clock process
    CLK_process : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR 10 ns;
        CLK <= '1';
        WAIT FOR 10 ns;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Initialize Inputs
        RST <= '1';
        Start <= '0';
        Data_in <= (OTHERS => '0');
        Addr_in_tmp <= Addr_in;
        WAIT FOR 300 ns;

        RST <= '0'; -- Release reset
        WAIT FOR 20 ns;

        -- Load data into memory
        FOR i IN 0 TO K - 1 LOOP
            WE <= '1';
            Addr_in <= STD_LOGIC_VECTOR(to_unsigned(TO_INTEGER(UNSIGNED(Addr_in_tmp)) + i, ADDR_WIDTH));
            Data_in <= input_array(i);
            WAIT FOR 20 ns;
            WE <= '0';
            WAIT FOR 20 ns;
        END LOOP;
        FOR i IN 0 TO K - 1 LOOP
            RE <= '1';

            Addr_in <= STD_LOGIC_VECTOR(to_unsigned(i, ADDR_WIDTH));
            WAIT FOR 20 ns;
            -- Display sorted data
            re <= '0';
            WAIT FOR 20 ns;
        END LOOP;
        Addr_in <= Addr_in_tmp;
        WAIT FOR 20 ns;

        -- Start sorting
        Start <= '1';
        -- Wait for the sorting to complete
        WAIT UNTIL Done = '1';
        Start <= '0';
        WAIT FOR 20 ns;
        -- Read sorted data
        FOR i IN 0 TO K - 1 LOOP
            RE <= '1';

            Addr_in <= STD_LOGIC_VECTOR(to_unsigned(i, ADDR_WIDTH));
            WAIT FOR 20 ns;
            -- Display sorted data
            re <= '0';
            WAIT FOR 20 ns;
        END LOOP;

        WAIT;
    END PROCESS;
END BEV;