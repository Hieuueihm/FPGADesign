LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.MyLib.ALL;

ENTITY PWM_Generator IS
    PORT (
        CLK : IN STD_LOGIC;
        DUTY_INCREASE : IN STD_LOGIC; -- increase 10 %
        DUTY_DECREASE : IN STD_LOGIC; -- 10 %
        PWM_OUT : OUT STD_LOGIC
    );
END ENTITY PWM_Generator;

ARCHITECTURE rtl OF PWM_Generator IS
    SIGNAL DUTY_CYCLE : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"5"; -- start  with duty = 50%
    SIGNAL Counter_PWM : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    SIGNAL slow_clk_en : STD_LOGIC := '0';
    SIGNAL counter_slow : STD_LOGIC_VECTOR(27 DOWNTO 0) := (OTHERS => '0');
    SIGNAL duty_inc, duty_dec : STD_LOGIC;
    SIGNAL temp1, temp2, temp3, temp4 : STD_LOGIC;
BEGIN

    -- debouncing
    PROCESS (CLK)
    BEGIN
        IF (rising_edge(CLK)) THEN
            counter_slow <= counter_slow + x"0000001";
            IF (counter_slow >= x"0000001") THEN
                counter_slow <= x"0000000";
            END IF;
        END IF;
    END PROCESS;
    slow_clk_en <= '1' WHEN counter_slow = x"0000001" ELSE
        '0';
    stage0 : DFF
    PORT MAP(
        CLK => CLK,
        EN => slow_clk_en,
        D => DUTY_INCREASE,
        Q => temp1
    );
    stage1 : DFF
    PORT MAP(
        CLK => CLK,
        EN => slow_clk_en,
        D => temp1,
        Q => temp2
    );
    duty_inc <= temp1 AND (NOT temp2) AND slow_clk_en;
    stage3 : DFF
    PORT MAP(
        CLK => CLK,
        EN => slow_clk_en,
        D => DUTY_DECREASE,
        Q => temp3
    );
    stage4 : DFF
    PORT MAP(
        CLK => CLK,
        EN => slow_clk_en,
        D => temp3,
        Q => temp4
    );
    duty_dec <= temp3 AND (NOT temp4) AND slow_clk_en;

    -- controlling duty cycle by these buttons
    PROCESS (CLK)
    BEGIN
        IF (RISING_EDGE(CLK)) THEN
            IF (duty_inc = '1' AND DUTY_CYCLE <= x"9") THEN
                DUTY_CYCLE <= DUTY_CYCLE + x"1";
            ELSIF (duty_dec = '1' AND DUTY_CYCLE >= x"1") THEN
                DUTY_CYCLE <= DUTY_CYCLE - x"1";
            END IF;
        END IF;
    END PROCESS;

    -- COUNTER
    PROCESS (CLK)
    BEGIN
        IF (RISING_EDGE(CLK)) THEN
            Counter_PWM <= Counter_PWM + b"0001";
            IF (Counter_PWM >= x"9") THEN
                Counter_PWM <= x"0";
            END IF;
        END IF;
    END PROCESS;
    PWM_OUT <= '1' WHEN Counter_PWM < DUTY_CYCLE ELSE
        '0';
END ARCHITECTURE rtl;