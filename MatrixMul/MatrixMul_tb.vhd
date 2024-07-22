	LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MyLib.ALL;

ENTITY MatrixMul_tb IS
END ENTITY MatrixMul_tb;

ARCHITECTURE behavior OF MatrixMul_tb IS
    -- Testbench signals
    SIGNAL RST : STD_LOGIC := '0';
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Start : STD_LOGIC := '0';
    SIGNAL Data_A : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Data_B : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL WE_A : STD_LOGIC := '0';
    SIGNAL WE_B : STD_LOGIC := '0';
    SIGNAL RE_C : STD_LOGIC := '0';
    SIGNAL Addr_A : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Addr_B : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Addr_C : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Done : STD_LOGIC;
    SIGNAL Data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Clock generation
    CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut : MatrixMul
    GENERIC MAP(
        ADDR_WIDTH => 6,
        DATA_WIDTH => 32,
        ColA => 3,
        RowA => 3,
        ColB => 2,
        RowB => 3
    )
    PORT MAP(
        RST => RST,
        CLK => CLK,
        Start => Start,
        Data_A => Data_A,
        Data_B => Data_B,
        WE_A => WE_A,
        WE_B => WE_B,
        RE_C => RE_C,
        Addr_A => Addr_A,
        Addr_B => Addr_B,
        Addr_C => Addr_C,
        Done => Done,
        Data_out => Data_out
    );

    -- Clock process definitions
    CLK_process : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR CLK_PERIOD/2;
        CLK <= '1';
        WAIT FOR CLK_PERIOD/2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- reset
        RST <= '1';
        WAIT FOR CLK_PERIOD * 10;
        RST <= '0';
        WAIT FOR CLK_PERIOD * 10;

        -- Load matrix A
        WE_A <= '1';
        Addr_A <= "000000";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(0, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "000001";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(1, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "000010";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(2, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "000011";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(3, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "000100";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(4, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "000101";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(5, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "000110";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(6, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "000111";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(7, 32));
        WAIT FOR CLK_PERIOD;
        Addr_A <= "001000";
        Data_A <= STD_LOGIC_VECTOR(to_unsigned(8, 32));
        WAIT FOR CLK_PERIOD;
        WE_A <= '0';

        -- Load matrix B
        WE_B <= '1';
        Addr_B <= "000000";
        Data_B <= STD_LOGIC_VECTOR(to_unsigned(0, 32));
        WAIT FOR CLK_PERIOD;
        Addr_B <= "000001";
        Data_B <= STD_LOGIC_VECTOR(to_unsigned(1, 32));
        WAIT FOR CLK_PERIOD;
        Addr_B <= "000010";
        Data_B <= STD_LOGIC_VECTOR(to_unsigned(2, 32));
        WAIT FOR CLK_PERIOD;
        Addr_B <= "000011";
        Data_B <= STD_LOGIC_VECTOR(to_unsigned(3, 32));
        WAIT FOR CLK_PERIOD;
        Addr_B <= "000100";
        Data_B <= STD_LOGIC_VECTOR(to_unsigned(4, 32));
        WAIT FOR CLK_PERIOD;
        Addr_B <= "000101";
        Data_B <= STD_LOGIC_VECTOR(to_unsigned(5, 32));
        WAIT FOR CLK_PERIOD;
        WE_B <= '0';

        -- Start matrix multiplication
        Start <= '1';
        WAIT FOR CLK_PERIOD;
        Start <= '0';

        -- Wait for completion
        WAIT UNTIL Done = '1';

        -- Read result
        RE_C <= '1';
        FOR i IN 0 TO 2 LOOP
            FOR j IN 0 TO 1 LOOP
                Addr_C <= STD_LOGIC_VECTOR(to_unsigned(i * 2 + j, 6));
                WAIT FOR CLK_PERIOD;
                -- Capture Data_out as needed
            END LOOP;
        END LOOP;
        RE_C <= '0';

        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;