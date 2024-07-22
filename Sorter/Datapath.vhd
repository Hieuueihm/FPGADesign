LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.MyLib.ALL;

-- K is number of input array
ENTITY Datapath IS
    GENERIC (
        DATA_WIDTH : INTEGER;
        ADDR_WIDTH : INTEGER;
        K : INTEGER
    );
    -- input port: WE, RE, RST, CLK, Data_in, Addr-in, Start
    PORT (
        WE : IN STD_LOGIC;
        RE : IN STD_LOGIC;
        RST, CLK : IN STD_LOGIC;
        Data_in : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Addr_in : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        Start : IN STD_LOGIC;
        Min_sel, Addr_sel, En_i, En_j, LDO_i, LDI_i, LDO_j, LDI_j, En_A, En_B, Int_WE, Int_RE : IN STD_LOGIC;
        A_gt_B, Zi, Zj : OUT STD_LOGIC;
        Data_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY Datapath;

ARCHITECTURE RTL OF Datapath IS
    -- ??m ??n 16
    SIGNAL A, B, Min_sel_value, D_in_m, Value_i_j, D_out : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL Addr_in_m : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL I, J : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ZERO, Incrementer_OUT : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');

    SIGNAL internal_WE, internal_RE : STD_LOGIC;

BEGIN

    --  MUL MIN_SEL
    Min_sel_value <= B WHEN Min_sel = '1' ELSE
        A;
    -- MUL memmory
    D_in_m <= Min_sel_value WHEN Start = '1' ELSE
        Data_in;

    internal_WE <= Int_WE OR WE;
    internal_RE <= Int_RE OR RE;

    Memory_ins : Memory
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH, ADDR_WIDTH => ADDR_WIDTH)
    PORT MAP(
        CLK => CLK,
        Din => D_in_m,
        ADDR => Addr_in_m,
        WE => internal_WE,
        RE => internal_RE,
        Dout => D_out
    );

    Data_out <= D_out;

    -- MUL i, j
    Value_i_j <= J WHEN Addr_sel = '1' ELSE
        I;

    -- MUL addr
    Addr_in_m <= STD_LOGIC_VECTOR(unsigned(Addr_in) + unsigned(Value_i_j)) WHEN Start = '1' ELSE
        Addr_in;
    -- counter I
    COUNTER_I : Counter
    GENERIC MAP(ADDR_WIDTH => ADDR_WIDTH)
    PORT MAP(
        RST, CLK,
        En => En_i,
        LD_o => LDO_i,
        LD_i => LDI_i,
        D => ZERO,
        Q => I
    );
    -- incrementer I J
    INCREMENTER_I_J : Incrementer
    GENERIC MAP(ADDR_WIDTH => ADDR_WIDTH)
    PORT MAP(
        INP => I,
        OUTP => Incrementer_OUT

    );
    -- counter J
    COUNTER_J : Counter
    GENERIC MAP(ADDR_WIDTH => ADDR_WIDTH)

    PORT MAP(
        RST, CLK,
        En => En_j,
        LD_o => LDO_j,
        LD_i => LDI_j,
        D => Incrementer_OUT,
        Q => J

    );
    -- COMPARATOR A > B
    A_gt_B <= '1' WHEN UNSIGNED(A) > UNSIGNED(B) ELSE
        '0';

    Zi <= '1' WHEN ((unsigned(I)) = K - 1) ELSE
        '0';
    Zj <= '1' WHEN ((unsigned(J)) = K) ELSE
        '0';
    -- REG A
    REGA : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => En_A,
        D => D_out,
        Q => A

    );
    -- REG B
    REGB : Regn
    GENERIC MAP(DATA_WIDTH => DATA_WIDTH)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        En => En_B,
        D => D_out,
        Q => B

    );

END ARCHITECTURE;