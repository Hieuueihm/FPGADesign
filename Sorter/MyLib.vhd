
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE MyLib IS
    -- register
    COMPONENT Regn IS
        GENERIC (DATA_WIDTH : INTEGER);
        PORT (
            RST, CLK : IN STD_LOGIC;
            En : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- counter
    -- Data length is maxmimum length of count 
    -- ex: 40 -> data length = 6 : 2^6 = 64
    COMPONENT Counter IS
        GENERIC (DATA_LENGTH : INTEGER);
        PORT (
            RST, CLK : IN STD_LOGIC;
            En : IN STD_LOGIC;
            LD_o, LD_i : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0); -- Data input for loading
            Q : OUT STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0) -- Counter output
        );
    END COMPONENT;
    -- memory
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

    -- Incrementer 
    COMPONENT Incrementer IS
        GENERIC (DATA_LENGTH : INTEGER);
        PORT (
            INP : IN STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0);
            OUTP : OUT STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0)
        );
    END COMPONENT;
    -- Datapath 

    COMPONENT Datapath IS
        GENERIC (
            DATA_WIDTH : INTEGER;
            ADDR_WIDTH : INTEGER;
            DATA_LENGTH : INTEGER;
            K : INTEGER
        );
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
    END COMPONENT;

    -- controller
    COMPONENT Controller IS

        PORT (
            RST, CLK : IN STD_LOGIC;
            Start : IN STD_LOGIC;
            A_gt_B, Zi, Zj : IN STD_LOGIC;
            Min_sel, Addr_sel, En_i, En_j, LDO_i, LDI_i, LDO_j, LDI_j, Int_WE, Int_RE, En_A, En_B : OUT STD_LOGIC;
            Done : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Sorter
    COMPONENT Sorter IS
        GENERIC (
            DATA_WIDTH : INTEGER;
            ADDR_WIDTH : INTEGER;
            DATA_LENGTH : INTEGER;
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
    END COMPONENT;
END PACKAGE;