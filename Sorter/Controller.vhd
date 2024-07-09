LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Controller IS

    PORT (
        RST, CLK : IN STD_LOGIC;
        Start : IN STD_LOGIC;
        A_gt_B, Zi, Zj : IN STD_LOGIC;

        Min_sel, Addr_sel, En_i, En_j, LDO_i, LDI_i, LDO_j, LDI_j, Int_WE, Int_RE, En_A, En_B : OUT STD_LOGIC;
        Done : OUT STD_LOGIC
    );
END ENTITY;
ARCHITECTURE rtl OF Controller IS
    TYPE State_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21);
    SIGNAL STATE : State_type;

BEGIN
    -- STATE REGISTER
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
                        STATE <= S19;
                    ELSE
                        STATE <= S5;
                    END IF;
                WHEN S5 =>
                    STATE <= S6;
                WHEN S6 =>
                    STATE <= S7;
                WHEN S7 =>
                    STATE <= S8;
                WHEN S8 =>
                    STATE <= S9;
                WHEN S9 =>
                    IF Zj = '1' THEN
                        STATE <= S18;
                    ELSE
                        STATE <= S10;
                    END IF;
                WHEN S10 =>
                    STATE <= S11;
                WHEN S11 =>
                    STATE <= S12;
                WHEN S12 =>
                    IF A_gt_B = '1' THEN
                        STATE <= S13;
                    ELSE
                        STATE <= S17;
                    END IF;
                WHEN S13 =>
                    STATE <= S14;
                WHEN S14 =>
                    STATE <= S15;
                WHEN S15 =>
                    STATE <= S16;
                WHEN S16 =>
                    STATE <= S17;
                WHEN S17 =>
                    STATE <= S8;
                WHEN S18 =>
                    STATE <= S3;
                WHEN S19 =>
                    STATE <= S20;
                WHEN S20 =>
                    IF Start = '0' THEN
                        STATE <= S21;
                    ELSE
                        STATE <= S20;
                    END IF;
                WHEN S21 =>
                    STATE <= S1;
                WHEN OTHERS =>
                    STATE <= S0;
            END CASE;
        END IF;
    END PROCESS;
    -- COMBINATIONAL LOGIC
    LDI_i <= '1' WHEN STATE = S2 ELSE
        '0';
    LDI_j <= '1' WHEN STATE = S7 ELSE
        '0';
    LDO_i <= '1' WHEN STATE = S3 ELSE
        '0';
    Addr_sel <= '1' WHEN (STATE = S10 OR STATE = S14) ELSE
        '0';
    Int_RE <= '1' WHEN (STATE = S5 OR STATE = S10 OR STATE = S15) ELSE
        '0';
    En_A <= '1' WHEN (STATE = S6 OR STATE = S16) ELSE
        '0';
    LDO_j <= '1' WHEN STATE = S8 ELSE
        '0';
    En_B <= '1' WHEN STATE = S11 ELSE
        '0';
    Min_sel <= '1' WHEN STATE = S13 ELSE
        '0';
    Int_WE <= '1' WHEN (STATE = S13 OR STATE = S14) ELSE
        '0';
    En_j <= '1' WHEN STATE = S17 ELSE
        '0';
    EN_i <= '1' WHEN STATE = S18 ELSE
        '0';
    Done <= '1' WHEN STATE = S19 ELSE
        '0';
END ARCHITECTURE;