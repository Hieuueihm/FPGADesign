LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY Counter_tb IS
END ENTITY Counter_tb;

ARCHITECTURE behavior OF Counter_tb IS

    -- Component declaration for the Unit Under Test (UUT)
    COMPONENT Counter
        GENERIC (DATA_LENGTH : INTEGER);
        PORT (
            RST : IN STD_LOGIC;
            CLK : IN STD_LOGIC;
            En : IN STD_LOGIC;
            LD : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- Testbench signals
    SIGNAL RST : STD_LOGIC := '0';
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL En : STD_LOGIC := '0';
    SIGNAL LD : STD_LOGIC := '0';
    SIGNAL D : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Q : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Clock period definition
    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : Counter
    GENERIC MAP(
        DATA_LENGTH => 4
    )
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => En,
        LD => LD,
        D => D,
        Q => Q
    );

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR clk_period/2;
        CLK <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Reset the counter
        RST <= '1';
        D <= "0001"; -- Load data value
        WAIT FOR clk_period * 2;
        RST <= '0';

        -- Enable counting
        En <= '1';
        WAIT FOR clk_period * 6; -- Count 3 times (3 rising edges of CLK)

        -- Load data into the counter
        LD <= '1';
        WAIT FOR clk_period * 2;
        LD <= '0';

        WAIT FOR clk_period * 3;
        ld <= '1';
        WAIT FOR clk_period;
        ld <= '0';

        -- Wait for some time to observe the results
        WAIT FOR clk_period * 4;
        ld <= '1';
        WAIT FOR clk_period;

        -- End simulation
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;