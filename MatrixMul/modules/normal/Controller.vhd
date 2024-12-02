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
    TYPE State_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16);
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
                    STATE <= S3;
                WHEN S3 =>
                    STATE <= S4;
                WHEN S4 =>
                    IF Zi = '1' THEN
                        STATE <= S15;
                    ELSE
                        STATE <= S5;
                    END IF;
                WHEN S5 =>
                    IF Zj = '1' THEN
                        STATE <= S14;
                    ELSE
                        STATE <= S6;
                    END IF;
                WHEN S6 =>
                    IF Zk = '1' THEN
                        STATE <= S11;
                    ELSE
                        STATE <= S7;
                    END IF;
                WHEN S7 =>
                    STATE <= S8;
                WHEN S8 =>
                    STATE <= S9;
                WHEN S9 =>
                    STATE <= S10;
                WHEN S10 => STATE <= S6;
                WHEN S11 => STATE <= S12;
                WHEN S12 => STATE <= S13;
                WHEN S13 => STATE <= S5;
                WHEN S14 => STATE <= S4;
                WHEN S15 => STATE <= S16;
                WHEN S16 => STATE <= S0;
                WHEN OTHERS =>
                    STATE <= S0;
            END CASE;
        END IF;
    END PROCESS;

    Int_RE_A <= '1' WHEN STATE = S7 ELSE
        '0';
    Int_RE_B <= '1' WHEN STATE = S7 ELSE
        '0';
    Int_WE_C <= '1' WHEN (STATE = S8 OR STATE = S12 OR STATE = S2) ELSE
        '0';
    Int_RE_C <= '1' WHEN (STATE = S9 OR STATE = S13 OR STATE = S3) ELSE
        '0';
    En_k <= '1' WHEN STATE = S10 ELSE
        '0';
    En_j <= '1' WHEN STATE = S11 ELSE
        '0';
    LDI_k <= '1' WHEN STATE = S11 ELSE
        '0';
    Din_C_sel <= '1' WHEN STATE = S12 OR STATE = S2 ELSE
        '0';
    En_i <= '1' WHEN STATE = S14 ELSE
        '0';
    LDI_j <= '1' WHEN STATE = S14 ELSE
        '0';
    Done <= '1' WHEN STATE = S15 ELSE
        '0';
    LDI_i <= '1' WHEN STATE = S1 ELSE
        '0';
END ARCHITECTURE rtl;