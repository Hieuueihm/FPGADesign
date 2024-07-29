
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.MyLib.ALL;

ENTITY MatrixMul_tb IS
END ENTITY MatrixMul_tb;

ARCHITECTURE behavioral OF MatrixMul_tb IS

    -- Constants and types
    CONSTANT ADDR_WIDTH : INTEGER := 8;
    CONSTANT DATA_WIDTH : INTEGER := 8;
    CONSTANT ColA : INTEGER := 3;
    CONSTANT RowA : INTEGER := 3;
    CONSTANT ColB : INTEGER := 2;
    CONSTANT RowB : INTEGER := 3;

    -- Signals
    SIGNAL clk, rst : STD_LOGIC := '0';
    SIGNAL start : STD_LOGIC := '0';
    SIGNAL data_a, data_b : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL we_a, we_b, re_a, re_b, re_c : STD_LOGIC := '0';
    SIGNAL addr_a : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := "00000000";
    SIGNAL addr_b : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := "01000000";
    SIGNAL addr_c : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := "00100000";

    SIGNAL done : STD_LOGIC;
    SIGNAL data_out : STD_LOGIC_VECTOR(2 * DATA_WIDTH - 1 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

    TYPE matrix_type_a IS ARRAY (0 TO RowA - 1, 0 TO ColA - 1) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    TYPE matrix_type_b IS ARRAY (0 TO RowB - 1, 0 TO ColB - 1) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    TYPE matrix_type_c IS ARRAY (0 TO RowA - 1, 0 TO ColB - 1) OF STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    SIGNAL A : matrix_type_a := ((x"00", x"01", x"02"), (x"03", x"04", x"05"), (x"06", x"07", x"08")); -- 3x3
    SIGNAL B : matrix_type_b := ((x"00", x"01"), (x"02", x"03"), (x"04", x"05")); -- 3 x 3 * 3 x 2 -> 3 x 2
    SIGNAL addr_a_tmp, addr_b_tmp, addr_c_tmp : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
BEGIN

    -- UUT instance
    UUT : MatrixMul
    GENERIC MAP(
        ADDR_WIDTH => ADDR_WIDTH,
        DATA_WIDTH => DATA_WIDTH,
        ColA => ColA,
        RowA => RowA,
        ColB => ColB,
        RowB => RowB
    )
    PORT MAP(
        rst => rst,
        clk => clk,
        start => start,
        data_a => data_a,
        data_b => data_b,
        we_a => we_a,
        we_b => we_b,
        re_a => re_a,
        re_b => re_b,
        re_c => re_c,
        addr_a => addr_a,
        addr_b => addr_b,
        addr_c => addr_c,
        done => done,
        data_out => data_out
    );
    -- Clock generation
    PROCESS
    BEGIN
        clk <= '1';
        WAIT FOR clk_period / 2;
        clk <= '0';
        WAIT FOR clk_period / 2;
    END PROCESS;

    -- Testbench stimulus
    PROCESS
    BEGIN
        -- Reset
        rst <= '1';
        WAIT FOR clk_period * 2;
        rst <= '0';
        WAIT FOR clk_period;
        addr_a_tmp <= addr_a;
        addr_b_tmp <= addr_b;
        addr_c_tmp <= addr_c;
        WAIT FOR clk_period;
        -- Kích thích dữ liệu cho ma trận A
        FOR i IN 0 TO RowA - 1 LOOP
            FOR j IN 0 TO ColA - 1 LOOP

                addr_a <= STD_LOGIC_VECTOR(UNSIGNED(addr_a_tmp) + to_unsigned(i * ColA + j, ADDR_WIDTH));
                data_a <= A(i, j);
                WAIT FOR clk_period / 2;
                we_a <= '1';

                WAIT FOR clk_period;
                we_a <= '0';
                WAIT FOR clk_period;

            END LOOP;
        END LOOP;
        -- Kích thích dữ liệu cho ma trận B
        FOR i IN 0 TO RowB - 1 LOOP
            FOR j IN 0 TO ColB - 1 LOOP

                addr_b <= STD_LOGIC_VECTOR(UNSIGNED(addr_b_tmp) + to_unsigned(i * ColB + j, ADDR_WIDTH));
                data_b <= B(i, j);
                WAIT FOR clk_period / 2;
                we_b <= '1';

                WAIT FOR clk_period;
                we_b <= '0';
                WAIT FOR clk_period;
            END LOOP;
        END LOOP;
        WAIT FOR clk_period;
        addr_a <= addr_a_tmp;
        addr_b <= addr_b_tmp;
        WAIT FOR clk_period;
        FOR i IN 0 TO RowA - 1 LOOP
            FOR j IN 0 TO ColA - 1 LOOP

                addr_a <= STD_LOGIC_VECTOR(UNSIGNED(addr_a_tmp) + to_unsigned(i * ColA + j, ADDR_WIDTH));
                WAIT FOR clk_period / 2;
                re_a <= '1';

                WAIT FOR clk_period;
                re_a <= '0';
                WAIT FOR clk_period;

            END LOOP;
        END LOOP;

        -- Kích thích dữ liệu cho ma trận B
        FOR i IN 0 TO RowB - 1 LOOP
            FOR j IN 0 TO ColB - 1 LOOP

                addr_b <= STD_LOGIC_VECTOR(UNSIGNED(addr_b_tmp) + to_unsigned(i * ColB + j, ADDR_WIDTH));
                WAIT FOR clk_period / 2;
                re_b <= '1';

                WAIT FOR clk_period;
                re_b <= '0';
                WAIT FOR clk_period;
            END LOOP;
        END LOOP;
        WAIT FOR clk_period;

        addr_a <= addr_a_tmp;
        addr_b <= addr_b_tmp;

        WAIT FOR clk_period;
        start <= '1';

        -- Chờ cho phép tính hoàn tất (kiểm tra tín hiệu Done)
        WAIT UNTIL done = '1';
        start <= '0';
        WAIT FOR clk_period * 2;

        -- Kiểm tra kết quả
        FOR i IN 0 TO RowA - 1 LOOP -- row a = 3
            FOR j IN 0 TO ColB - 1 LOOP -- col b = 2 

                addr_c <= STD_LOGIC_VECTOR(UNSIGNED(addr_c_tmp) + to_unsigned(i * ColB + j, ADDR_WIDTH));
                WAIT FOR clk_period / 2;
                re_c <= '1';

                WAIT FOR clk_period;
                re_c <= '0';
                WAIT FOR clk_period;
            END LOOP;
        END LOOP;

        WAIT;
    END PROCESS;
END ARCHITECTURE behavioral;