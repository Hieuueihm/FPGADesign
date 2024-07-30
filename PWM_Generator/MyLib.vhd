LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
PACKAGE MyLib IS
    COMPONENT DFF IS
        PORT (
            CLK : IN STD_LOGIC;
            EN : IN STD_LOGIC;
            D : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT PWM_Generator IS
        PORT (
            CLK : IN STD_LOGIC;
            DUTY_INCREASE : IN STD_LOGIC; -- increase 10 %
            DUTY_DECREASE : IN STD_LOGIC; -- 10 %
            PWM_OUT : OUT STD_LOGIC
        );
    END COMPONENT;
END PACKAGE MyLib;