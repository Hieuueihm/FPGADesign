LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MyLib.ALL;

ENTITY GCD IS
    GENERIC (DATA_WIDTH : INTEGER);
    PORT (

        Start_i : IN STD_LOGIC;
        X_i, Y_i : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        RST, CLK : IN STD_LOGIC;
        GCD_o : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Done_o : OUT STD_LOGIC
    );
END ENTITY GCD;
ARCHITECTURE rtl OF GCD IS
    SIGNAL X_sel, Y_sel : STD_LOGIC;
    SIGNAL X_ld, Y_ld, R_ld, GCD_ld : STD_LOGIC;
    SIGNAL Per_sel : STD_LOGIC;
    SIGNAL X_lt_Y, Y_eq_0 : STD_LOGIC;
BEGIN
    DATAPATH_UNIT : Datapath
    GENERIC MAP(DATA_WIDTH)
    PORT MAP(
        RST, CLK,
        X_i, Y_i,
        Per_sel, X_sel, Y_sel,
        X_ld, Y_ld, R_ld, GCD_ld,

        X_lt_Y, Y_eq_0,
        GCD_o
    );

    -- CONTROLLER
    CTRL_UNIT : Controller
    PORT MAP(
        RST, CLK,
        Start_i,
        Per_sel, X_sel, Y_sel, X_ld, Y_ld, GCD_ld,
        R_ld,
        X_lt_Y,
        Y_eq_0,
        Done_o
    );
END ARCHITECTURE rtl;