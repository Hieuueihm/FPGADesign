LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Controller IS

    PORT (
        RST, CLK : IN STD_LOGIC;
        Start_i : IN STD_LOGIC;
        Per_sel, X_sel, Y_sel, X_ld, Y_ld, GCD_ld : OUT STD_LOGIC;
        R_ld : OUT STD_LOGIC;
        X_lt_Y : IN STD_LOGIC;
        Y_eq_0 : IN STD_LOGIC;
        Done_o : OUT STD_LOGIC
    );
END ENTITY;
ARCHITECTURE rtl OF Controller IS
    TYPE State_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13);
    SIGNAL State : State_type;

BEGIN
    -- STATE REGISTER
    PROCESS (RST, CLK)
    BEGIN
        IF (RST = '1') THEN
            State <= S0;
        ELSIF rising_edge(CLK) THEN
            CASE State IS
                WHEN S0 =>
                    State <= S1;
                WHEN S1 =>
                    IF (Start_i = '1') THEN
                        State <= S2;
                    END IF;
                WHEN S2 =>
                    IF X_lt_Y = '1' THEN
                        State <= S3;
                    ELSE
                        State <= S4;
                    END IF;
                WHEN S3 =>
                    State <= S4;
                WHEN S4 => State <= S5;
                WHEN S5 => State <= S6;
                WHEN S6 =>
                    IF Y_eq_0 = '1' THEN
                        State <= S10;
                    ELSE
                        State <= S7;
                    END IF;
                WHEN S7 =>
                    State <= S8;
                WHEN S8 =>
                    State <= S9;
                WHEN S9 => State <= S6;
                WHEN S10 =>
                    State <= S11;
                WHEN S11 =>
                    State <= S12;
                WHEN S12 =>
                    IF Start_i = '1' THEN
                        State <= S12;
                    ELSE
                        State <= S13;
                    END IF;
                WHEN S13 => State <= S0;
                WHEN OTHERS =>
                    State <= S0;
            END CASE;
        END IF;
    END PROCESS;
    -- COMBINATIONAL LOGIC
    Per_sel <= '1' WHEN State = S3 ELSE
        '0';

    X_sel <= '1' WHEN State = S4 ELSE
        '0';
    X_ld <= '1' WHEN (State = S4 OR State = S8) ELSE
        '0';
    Y_sel <= '1' WHEN State = S5 ELSE
        '0';
    Y_ld <= '1' WHEN (State = S5 OR State = S9) ELSE
        '0';
    R_ld <= '1' WHEN State = S7 ELSE
        '0';
    GCD_ld <= '1' WHEN (State = S10) ELSE
        '0';
    Done_o <= '1' WHEN (State = S11 OR State = S12) ELSE
        '0';

END ARCHITECTURE;