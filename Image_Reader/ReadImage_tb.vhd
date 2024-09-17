LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
-- FPGA4student.com: FPGA/Verilog/VHDL projects for students
-- VHDL tutorial: How to Read images in VHDL
ENTITY ReadImage_tb IS
END ReadImage_tb;
ARCHITECTURE behavior OF ReadImage_tb IS
    COMPONENT ReadImage
        GENERIC (
            ADDR_WIDTH : INTEGER := 4;
            DATA_WIDTH : INTEGER := 8;
            IMAGE_SIZE : INTEGER := 15;
            IMAGE_FILE_NAME : STRING := "IMAGE_FILE.MIF"
        );
        PORT (
            clk : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR((DATA_WIDTH - 1) DOWNTO 0);
            read_addr : IN STD_LOGIC_VECTOR((ADDR_WIDTH - 1) DOWNTO 0);
            write_addr : IN STD_LOGIC_VECTOR((ADDR_WIDTH - 1) DOWNTO 0);
            write_en : IN STD_LOGIC;
            read_en : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR((DATA_WIDTH - 1) DOWNTO 0)
        );
    END COMPONENT;
    --Inputs
    SIGNAL clock : STD_LOGIC := '0';
    SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rdaddress : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL wraddress : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL we : STD_LOGIC := '0';
    SIGNAL re : STD_LOGIC := '0';
    --Outputs
    SIGNAL q : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Clock period definitions
    CONSTANT clock_period : TIME := 10 ns;
    SIGNAL i : INTEGER;
BEGIN
    -- Read image in VHDL
    uut : ReadImage PORT MAP(
        clk => clock,
        data => data,
        read_addr => rdaddress,
        write_addr => wraddress,
        write_en => we,
        read_en => re,
        Q => q
    );

    -- Clock process definitions
    clock_process : PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR clock_period/2;
        clock <= '1';
        WAIT FOR clock_period/2;
    END PROCESS;
    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        data <= x"00";
        rdaddress <= x"0";
        wraddress <= x"0";
        we <= '0';
        re <= '0';
        WAIT FOR 100 ns;
        re <= '1';
        FOR i IN 0 TO 15 LOOP
            rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i, 4));
            WAIT FOR 20 ns;
        END LOOP;
        WAIT;
    END PROCESS;

END;