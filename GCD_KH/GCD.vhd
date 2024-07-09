LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.MyLib.All;


ENTITY GCD IS
    GENERIC (DATA_WIDTH : INTEGER);
    PORT (
        RST, CLK : IN STD_LOGIC;
        Start_i : IN STD_LOGIC;
        X_i, Y_i : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        GCD_o : OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
        Done_o : OUT STD_LOGIC
    );
END ENTITY;
ARCHITECTURE rtl OF GCD IS
	Signal X_sel, Y_sel : STD_LOGIC;
	Signal X_ld, Y_ld : STD_LOGIC;
	Signal GCD_ld : STD_LOGIC;
	Signal X_neq_Y, X_lt_Y: STD_LOGIC;
	
BEGIN
	CTRL_UNIT: Controller 

	PORT MAP (
		RST => RST,
		CLK => CLK,
		Start_i => Start_i,
		X_sel => X_sel,
		Y_sel => Y_sel,
		X_ld => X_ld,
		Y_ld => Y_ld,
		GCD_ld => GCD_ld,
		X_lt_Y  => X_lt_Y,
		X_neq_Y => X_neq_Y,
		Done_o => Done_o
	);

	DATAPATH_UNIT: Datapath
    GENERIC MAP (DATA_WIDTH )
    PORT MAP (
        RST, CLK,
        X_i, Y_i,
        X_sel, Y_sel,
        X_ld, Y_ld,
        GCD_ld,
        X_neq_Y, X_lt_y ,
        GCD_o
    );
END ARCHITECTURE;
