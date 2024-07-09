LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Controller IS

    PORT (
        RST, CLK : IN STD_LOGIC;
        Start_i : IN STD_LOGIC;
        X_sel, Y_sel, X_ld, Y_ld, GCD_ld : OUT STD_LOGIC;
        X_lt_Y : IN STD_LOGIC;
        X_neq_Y : IN STD_LOGIC;
        Done_o : OUT STD_LOGIC
    );
END ENTITY;
ARCHITECTURE rtl OF Controller IS
    TYPE State_type IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12);
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
                    State <= S3;
                WHEN S3 =>
                    State <= S4;
                WHEN S4 =>
                    IF (X_neq_Y = '1') THEN
                        State <= S5;
                    ELSE
                        State <= S9;
                    END IF;
                WHEN S5 =>
                    IF (X_lt_Y = '1') THEN
                        State <= S6;
                    ELSE
                        State <= S7;
                    END IF;
                WHEN S6 =>
                    State <= S8;
                WHEN S7 =>
                    State <= S8;
                WHEN S8 =>
                    State <= S4;
                WHEN S9 =>
                    State <= S10;
                WHEN S10 =>
                    State <= S11;
                WHEN S11 =>
                    IF (Start_i = '0') THEN
                        State <= S12;
                    END IF;
                WHEN S12 => State <= S0;
                WHEN OTHERS =>
                    State <= S0;
            END CASE;
        END IF;
    END PROCESS;
    -- COMBINATIONAL LOGIC
    X_sel <= '1' WHEN State = S2 ELSE
        '0';
    X_ld <= '1' WHEN (State = S2 OR State = S7) ELSE
        '0';
    Y_sel <= '1' WHEN State = S3 ELSE
        '0';
    Y_ld <= '1' WHEN (State = S3 OR State = S6) ELSE
        '0';

    GCD_ld <= '1' WHEN (State = S9) ELSE
        '0';
    Done_o <= '1' WHEN (State = S10 OR State = S11) ELSE
        '0';

END ARCHITECTURE;