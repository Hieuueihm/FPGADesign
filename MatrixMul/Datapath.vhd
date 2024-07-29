LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MyLib.ALL;

ENTITY Datapath IS
    GENERIC (
        ADDR_WIDTH : INTEGER;
        DATA_WIDTH : INTEGER;
        ColA : INTEGER;
        RowA : INTEGER;
        ColB : INTEGER;
        RowB : INTEGER
    );
    PORT (
        RST : IN STD_LOGIC;
        CLK : IN STD_LOGIC;
        Start : IN STD_LOGIC;
        Data_A : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Data_B : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        WE_A, WE_B, RE_C : IN STD_LOGIC;
        Addr_A, Addr_B, Addr_C : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        Int_RE_A, Int_RE_B, Int_RE_C, Int_WE_C : IN STD_LOGIC;
        En_k, En_i, En_j, LDI_k, LDI_j, LDI_i : IN STD_LOGIC;
        Din_C_sel : IN STD_LOGIC;
        Zk, Zi, Zj : OUT STD_LOGIC;
        RE_A, RE_B : IN STD_LOGIC;
        Data_out : OUT STD_LOGIC_VECTOR(2 * DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY Datapath;
ARCHITECTURE rtl OF Datapath IS
    SIGNAL Addr_in_A, Addr_in_B, Addr_in_C : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL I, J, K : STD_LOGIC_VECTOR(ADDR_WIDTH / 2 - 1 DOWNTO 0);
    SIGNAL IcAK, IcA, KcB, KcBJ, IcBJ, IcB : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL A, B : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL D_in_C, AB : STD_LOGIC_VECTOR((2 * DATA_WIDTH) - 1 DOWNTO 0);
    SIGNAL Internal_RE_C, Internal_RE_A, Internal_RE_B : STD_LOGIC;
    SIGNAL D_out : STD_LOGIC_VECTOR(2 * DATA_WIDTH - 1 DOWNTO 0);
BEGIN
    Internal_RE_C <= RE_C OR Int_RE_C;
    Internal_RE_A <= RE_A OR Int_RE_A;

    Internal_RE_B <= RE_B OR Int_RE_B;
    Addr_in_A <= STD_LOGIC_VECTOR(UNSIGNED(Addr_A) + UNSIGNED(IcAK)) WHEN Start = '1' ELSE
        Addr_A;
    Addr_in_B <= STD_LOGIC_VECTOR(UNSIGNED(Addr_B) + UNSIGNED(KcBJ)) WHEN Start = '1' ELSE
        Addr_B;
    Addr_in_C <= STD_LOGIC_VECTOR(UNSIGNED(Addr_C) + UNSIGNED(IcBJ)) WHEN Start = '1' ELSE
        Addr_C;

    -- C += A * B
    D_in_C <= (OTHERS => '0') WHEN Din_C_sel = '1' ELSE
        STD_LOGIC_VECTOR(UNSIGNED(AB) + UNSIGNED(D_out));

    AB <= STD_LOGIC_VECTOR(UNSIGNED(A) * UNSIGNED(B)); -- 15 * 15 = 225 -> 
    -- counter: 0 -> max(colA, rowA, colB, rowB) -- addrwidth = 8-bit -> counter max - 8 bit
    KcB <= STD_LOGIC_VECTOR(UNSIGNED(K) * ColB); --
    IcA <= STD_LOGIC_VECTOR(UNSIGNED(I) * ColA);
    IcB <= STD_LOGIC_VECTOR(UNSIGNED(I) * ColB);

    KcBJ <= STD_LOGIC_VECTOR(UNSIGNED(KcB) + UNSIGNED(J));
    IcAK <= STD_LOGIC_VECTOR(UNSIGNED(IcA) + UNSIGNED(K));
    IcBJ <= STD_LOGIC_VECTOR(UNSIGNED(IcB) + UNSIGNED(J));

    Zk <= '1' WHEN UNSIGNED(K) = TO_UNSIGNED(RowB, ADDR_WIDTH)ELSE -- 3
        '0';
    Zi <= '1' WHEN UNSIGNED(I) = TO_UNSIGNED(RowA, ADDR_WIDTH) ELSE --3 
        '0';
    Zj <= '1' WHEN UNSIGNED(J) = TO_UNSIGNED(ColB, ADDR_WIDTH) ELSE -- 2
        '0';
    Cnt_k : Counter
    GENERIC MAP(ADDR_WIDTH => ADDR_WIDTH / 2)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        EN => En_k,
        LDI => LDI_k,
        D => (OTHERS => '0'),
        Q => K
    );
    Cnt_i : Counter
    GENERIC MAP(ADDR_WIDTH => ADDR_WIDTH / 2)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        EN => En_i,
        LDI => LDI_i,
        D => (OTHERS => '0'),
        Q => I

    );
    Cnt_j : Counter
    GENERIC MAP(ADDR_WIDTH => ADDR_WIDTH / 2)
    PORT MAP(
        RST => RST,
        CLK => CLK,
        EN => En_j,
        LDI => LDI_j,
        D => (OTHERS => '0'),
        Q => J
    );

    M_A : Memory
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH,
        ADDR_WIDTH => ADDR_WIDTH)
    PORT MAP(
        Din => Data_A,
        ADDR => Addr_in_A,
        WE => WE_A,
        RE => Internal_RE_A,
        CLK => CLK,
        RST => RST,
        Dout => A
    );

    M_B : Memory
    GENERIC MAP(
        DATA_WIDTH => DATA_WIDTH,
        ADDR_WIDTH => ADDR_WIDTH)
    PORT MAP(
        Din => Data_B,
        ADDR => Addr_in_B,
        WE => WE_B,
        RE => Internal_RE_B,
        CLK => CLK,
        RST => RST,
        Dout => B
    );

    M_C : Memory
    GENERIC MAP(
        DATA_WIDTH => (2 * DATA_WIDTH),
        ADDR_WIDTH => ADDR_WIDTH)
    PORT MAP(
        Din => D_in_C,
        ADDR => Addr_in_C,
        WE => Int_WE_C,
        RE => Internal_RE_C,
        CLK => CLK,
        RST => RST,
        Dout => D_out
    );
    Data_out <= D_out;
END ARCHITECTURE rtl;