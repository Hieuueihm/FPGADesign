LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Divider_tb IS
END Divider_tb;

ARCHITECTURE Behavioral OF Divider_tb IS
    -- Các tham s? chung
    CONSTANT DATA_WIDTH : INTEGER := 8;

    -- Các tín hi?u cho mô-?un divider
    SIGNAL X : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL Y : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL R : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN
    -- Kh?i t?o mô-?un c?n ki?m tra
    uut: ENTITY work.Divider
        GENERIC MAP (
            DATA_WIDTH => DATA_WIDTH
        )
        PORT MAP (
            X => X,
            Y => Y,
            R => R
        );

    -- Quá trình ki?m tra
    PROCESS
    BEGIN
        -- Ki?m tra tr??ng h?p Y = 0
        X <= "00000010"; -- 2
        Y <= "00000000"; -- 0
        WAIT FOR 10 ns;
        ASSERT (R = "XXXXXXXX") REPORT "Test case 1 failed" SEVERITY ERROR;

        -- Ki?m tra phép chia có d?
        X <= "00001001"; -- 9
        Y <= "00000011"; -- 3
        WAIT FOR 10 ns;
        ASSERT (R = "00000000") REPORT "Test case 2 failed" SEVERITY ERROR;

        -- Ki?m tra phép chia không d?
        X <= "00001000"; -- 8
        Y <= "00000010"; -- 2
        WAIT FOR 10 ns;
        ASSERT (R = "00000000") REPORT "Test case 3 failed" SEVERITY ERROR;

        -- Ki?m tra khi X < Y
        X <= "00000001"; -- 1
        Y <= "00000010"; -- 2
        WAIT FOR 10 ns;
        ASSERT (R = "00000001") REPORT "Test case 4 failed" SEVERITY ERROR;

        -- Ki?m tra các giá tr? biên
        X <= "11111111"; -- 255
        Y <= "00000001"; -- 1
        WAIT FOR 10 ns;
        ASSERT (R = "00000000") REPORT "Test case 5 failed" SEVERITY ERROR;

        -- Ki?m tra các giá tr? biên khác
        X <= "11111111"; -- 255
        Y <= "00000011"; -- 3
        WAIT FOR 10 ns;
        ASSERT (R = "00000000") REPORT "Test case 6 failed" SEVERITY ERROR;

        -- Ki?m tra phép chia có d? khác
        X <= "00000101"; -- 5
        Y <= "00000010"; -- 2
        WAIT FOR 10 ns;
        ASSERT (R = "00000001") REPORT "Test case 7 failed" SEVERITY ERROR;

        -- K?t thúc ki?m tra
        WAIT;
    END PROCESS;
END Behavioral;

