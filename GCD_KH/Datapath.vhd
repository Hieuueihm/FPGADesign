LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.all;

USE work.MyLib.ALL;

ENTITY Datapath IS
    GENERIC (DATA_WIDTH : INTEGER);
    PORT (
        RST, CLK : IN STD_LOGIC;
        X_i, Y_i : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        X_sel, Y_sel : IN STD_LOGIC;
        X_ld, Y_ld : IN STD_LOGIC;
        GCD_ld : IN STD_LOGIC;
        X_neq_Y, X_lt_y : OUT STD_LOGIC;

        GCD_o : OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY Datapath;

ARCHITECTURE RTL OF Datapath IS

    SIGNAL X_src, Y_src, XsubY, YsubX, X, Y : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

    --  MUL X
    X_src <= X_i WHEN X_sel = '1' ELSE
        XsubY;
    -- MUL Y
    Y_src <= Y_i WHEN Y_sel = '1' ELSE
        YsubX;

    -- COMPARATOR NOT EQUAL
    X_neq_Y <= '1' WHEN X /= Y ELSE
        '0';
    -- COMPARATOR LESS THAN
    X_lt_y <= '1' WHEN X < Y ELSE
        '0';
    -- X - Y
    XsubY <= X - Y;
    -- Y - X
    YsubX <= Y - X;
    -- REG X
    REGX : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => X_ld,
        D => X_src,
        Q => X

    );
    REGY : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => Y_ld,
        D => Y_src,
        Q => Y

    );
    REG_GCD : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => GCD_ld,
        D => X,
        Q => GCD_o

    );
END ARCHITECTURE;