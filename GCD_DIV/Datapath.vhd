LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

USE work.MyLib.ALL;
ENTITY Datapath IS
    GENERIC (DATA_WIDTH : INTEGER);
    PORT (
        RST, CLK : IN STD_LOGIC;
        X_i, Y_i : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
        Per_sel, X_sel, Y_sel : IN STD_LOGIC;
        X_ld, Y_ld, R_ld, GCD_ld : IN STD_LOGIC;

        X_lt_Y, Y_eq_0 : OUT STD_LOGIC;
        GCD_o : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );

END ENTITY Datapath;

ARCHITECTURE rtl OF Datapath IS

    SIGNAL X, Y, R, X_out, Y_out, Div_out, X_src, Y_src : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN
    -- permutation 
    -- x
    X <= Y_i WHEN Per_sel = '1' ELSE
        X_i;
    -- Y
    Y <= X_i WHEN Per_sel = '1' ELSE
        Y_i;
    -- MUL X
    X_src <= X WHEN X_sel = '1' ELSE
        Y_out;
    -- MUL Y
    Y_src <= Y WHEN Y_sel = '1' ELSE
        R;
    -- COM LT
    X_lt_Y <= '1' WHEN X_i < Y_i ELSE
        '0';
    -- COM ZERO
    Y_eq_0 <= '1' WHEN unsigned(Y_out) = 0 ELSE
        '0';

    REG_X : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => X_ld,
        D => X_src,
        Q => X_out

    );
    REG_Y : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => Y_ld,
        D => Y_src,
        Q => Y_out

    );
    REG_GCD : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => GCD_ld,
        D => X_out,
        Q => GCD_o

    );
    REG_R : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => R_ld,
        D => Div_out,
        Q => R

    );

    DIV : Divider
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH
    )
    PORT MAP(
        X => X_out,
        Y => Y_out,
        R => Div_out
    );
END ARCHITECTURE rtl;