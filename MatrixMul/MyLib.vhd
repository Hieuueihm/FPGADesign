LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
PACKAGE MyLib IS

    COMPONENT Memory IS
        GENERIC (
            DATA_WIDTH : INTEGER;
            ADDR_WIDTH : INTEGER); -- Width of the address bus

        PORT (

            Din : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            ADDR : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0); -- Address input
            WE, RE : IN STD_LOGIC;
            CLK : IN STD_LOGIC;
            Dout : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) -- Data output
        );
    END COMPONENT;

    COMPONENT Counter IS
        GENERIC (ADDR_WIDTH : INTEGER);
        PORT (
            RST, CLK : IN STD_LOGIC;
            En : IN STD_LOGIC;
            LDI : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0); -- Data input for loading
            Q : OUT STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) -- Counter output
        );
    END COMPONENT;

    -- DATAPATH

    COMPONENT Datapath IS
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
            Data_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- Controller
    COMPONENT Controller IS
        PORT (
            Start : IN STD_LOGIC;
            CLK, RST : IN STD_LOGIC;
            Int_RE_A, Int_RE_B, Int_RE_C, Int_WE_C : OUT STD_LOGIC;
            En_k, En_i, En_j, LDI_k, LDI_j, LDI_i : OUT STD_LOGIC;
            Din_C_sel : OUT STD_LOGIC;
            Zk, Zi, Zj : IN STD_LOGIC;
            Done : OUT STD_LOGIC
        );
    END COMPONENT;

    --
    COMPONENT MatrixMul IS
        GENERIC (
            ADDR_WIDTH : INTEGER;
            DATA_WIDTH : INTEGER;
            ColA : INTEGER;
            RowA : INTEGER;
            ColB : INTEGER;
            RowB : INTEGER
        );
        PORT (
            -- (RowA, ColA) x (RowB, ColB)
            RST : IN STD_LOGIC;
            CLK : IN STD_LOGIC;
            Start : IN STD_LOGIC;
            Data_A : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            Data_B : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            WE_A, WE_B : IN STD_LOGIC;
            RE_C : IN STD_LOGIC;
            Addr_A, Addr_B, Addr_C : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
            Done : OUT STD_LOGIC;
            Data_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)

        );
    END COMPONENT;
END PACKAGE MyLib;