LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE MyLib IS
    COMPONENT CLK_Divider IS
        PORT (
            clk_in : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC
        );
    END COMPONENT;
END PACKAGE MyLib;