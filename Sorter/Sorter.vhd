LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.MyLib.ALL;
ENTITY Sorter IS
    GENERIC (
        DATA_WIDTH : INTEGER;
        ADDR_WIDTH : INTEGER;
        K : INTEGER
    );
    PORT (
        RST, CLK : IN STD_LOGIC;
        Start : IN STD_LOGIC;
        Data_in : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        WE : IN STD_LOGIC;
        Addr_in : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Done : OUT STD_LOGIC;
        Data_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        RE : IN STD_LOGIC
    );
END ENTITY;
ARCHITECTURE rtl OF Sorter IS
    SIGNAL Min_sel, Addr_sel, En_i, En_j, LDO_i, LDI_i, LDO_j, LDI_j, En_A, En_B, Int_WE, Int_RE : STD_LOGIC;
    SIGNAL A_gt_B, Zi, Zj : STD_LOGIC;
BEGIN
    DATAPATH_UNIT : Datapath
    GENERIC MAP(
        DATA_WIDTH,
        ADDR_WIDTH,
        K)
    PORT MAP(
        WE => WE,
        RE => RE,
        RST => RST,
        CLK => CLK,
        Data_in => Data_in,
        Addr_in => Addr_in,
        Start => Start,
        Data_out => Data_out,
        Min_sel => Min_sel,
        Addr_sel => Addr_sel,
        En_i => En_i,
        En_j => En_j,
        LDO_i => LDO_i,
        LDO_j => LDO_j,
        LDI_i => LDI_i,
        LDI_j => LDI_j,
        En_A => En_A,
        En_B => En_B,
        Int_WE => Int_WE,
        Int_RE => Int_RE,
        A_gt_B => A_gt_B,
        Zi => Zi,
        Zj => Zj

    );
    CONTROLLER_UNIT : Controller
    PORT MAP(
        RST => RST,
        CLK => CLK,
        Start => Start,
        Min_sel => Min_sel,
        Addr_sel => Addr_sel,
        En_i => En_i,
        En_j => En_j,
        LDO_i => LDO_i,
        LDO_j => LDO_j,
        LDI_i => LDI_i,
        LDI_j => LDI_j,
        Int_WE => Int_WE,
        Int_RE => Int_RE,
        En_A => En_A,
        En_B => En_B,
        Done => Done,
        A_gt_B => A_gt_B,
        Zi => Zi,
        Zj => Zj
    );
END ARCHITECTURE;