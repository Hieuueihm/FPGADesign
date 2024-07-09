
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE MyLib IS
    -- n bit register
    COMPONENT Regn IS
        GENERIC (DATA_WIDTH : INTEGER);
        PORT (
            RST, CLK : IN STD_LOGIC;
            En : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;
    -- DIVIDER
    COMPONENT Divider IS
        GENERIC (
            DATA_WIDTH : INTEGER
        );
        PORT (
            X : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            Y : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            R : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;
    -- datapath 

    COMPONENT Datapath IS
        GENERIC (DATA_WIDTH : INTEGER);
        PORT (
            RST, CLK : IN STD_LOGIC;
            X_i, Y_i : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
            Per_sel, X_sel, Y_sel : IN STD_LOGIC;
            X_ld, Y_ld, R_ld, GCD_ld : IN STD_LOGIC;

            X_lt_Y, Y_eq_0 : OUT STD_LOGIC;
            GCD_o : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- CONTROLLER
    COMPONENT Controller IS

        PORT (
            RST, CLK : IN STD_LOGIC;
            Start_i : IN STD_LOGIC;
            Per_sel, X_sel, Y_sel, X_ld, Y_ld, GCD_ld : OUT STD_LOGIC;
            R_ld : OUT STD_LOGIC;
            X_lt_Y : IN STD_LOGIC;
            Y_eq_0 : IN STD_LOGIC;
            Done_o : OUT STD_LOGIC
        );
    END COMPONENT;

    -- GCD
    COMPONENT GCD IS
        GENERIC (DATA_WIDTH : INTEGER);
        PORT (
            Start_i : IN STD_LOGIC;
            X_i, Y_i : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            RST, CLK : IN STD_LOGIC;
            GCD_o : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            Done_o : OUT STD_LOGIC
        );
    END COMPONENT;
END PACKAGE;