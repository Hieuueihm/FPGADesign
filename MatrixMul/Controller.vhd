LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY Controller IS
    PORT (
        Start : IN STD_LOGIC;
        CLK, RST : IN STD_LOGIC;
        Int_RE_A, Int_RE_B, Int_RE_C, Int_WE_C : OUT STD_LOGIC;
        En_k, En_i, En_j, LDI_k, LDI_j, LDI_i : OUT STD_LOGIC;
        Din_C_sel : OUT STD_LOGIC;
        Zk, Zi, Zj : IN STD_LOGIC;
        Done : OUT STD_LOGIC
    );
END ENTITY Controller;

ARCHITECTURE rtl OF Controller IS
    TYPE State_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);
    SIGNAL STATE : State_type;
BEGIN
    PROCESS (RST, CLK)
    BEGIN
        IF (RST = '1') THEN
            STATE <= S0;
        ELSIF rising_edge(CLK) THEN
            CASE STATE IS
                WHEN S0 =>
                    STATE <= S1;
                WHEN S1 =>
                    IF Start = '1' THEN
                        STATE <= S2;
                    ELSE
                        STATE <= S1;
                    END IF;
                WHEN S2 =>
                    IF Zi = '0' THEN
                        STATE <= S3;
                    ELSE
                        STATE <= S13;
                    END IF;
                WHEN S3 =>
                    IF Zj = '0' THEN
                        STATE <= S4;
                    ELSE
                        STATE <= S12;
                    END IF;
                WHEN S4 =>
                    IF Zk = '0' THEN
                        STATE <= S5;
                    ELSE
                        STATE <= S9;
                    END IF;
                WHEN S5 =>
                    STATE <= S6;
                WHEN S6 =>
                    STATE <= S7;
                WHEN S7 =>
                    STATE <= S8;
                WHEN S8 => STATE <= S4;
                WHEN S9 => STATE <= S10;
                WHEN S10 => STATE <= S11;
                WHEN S11 => STATE <= S3;
                WHEN S12 => STATE <= S2;
                WHEN S13 => STATE <= S14;
                WHEN S14 => STATE <= S0;
                WHEN OTHERS =>
                    STATE <= S0;
            END CASE;
        END IF;
    END PROCESS;

    Int_RE_A <= '1' WHEN STATE <= S5 ELSE
        '0';
    Int_RE_B <= '1' WHEN sTATE <= S5 ELSE
        '0';
    Int_WE_C <= '1' WHEN (STATE <= S6 OR STATE <= S10) ELSE
        '0';
    Int_RE_C <= '1' WHEN (STATE <= S7 OR STATE <= S11) ELSE
        '0';
    En_k <= '1' WHEN STATE <= S8 ELSE
        '0';
    En_j <= '1' WHEN STATE <= S9 ELSE
        '0';
    LDI_k <= '1' WHEN STATE <= S9 ELSE
        '0';
    Din_C_sel <= '1' WHEN STATE <= S10 ELSE
        '0';
    En_i <= '1' WHEN STATE <= S12 ELSE
        '0';
    LDI_j <= '1' WHEN STATE <= S12 ELSE
        '0';
    Done <= '1' WHEN STATE <= S13 ELSE
        '0';
END ARCHITECTURE rtl;