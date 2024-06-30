LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Divider IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8
    );
    PORT (
        X : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        Y : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        R : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END Divider;

ARCHITECTURE Behavioral OF Divider IS

BEGIN
    PROCESS (X, Y)
        VARIABLE X_int : unsigned(DATA_WIDTH - 1 DOWNTO 0);
        VARIABLE Y_int : unsigned(DATA_WIDTH - 1 DOWNTO 0);
        VARIABLE R_int : unsigned(DATA_WIDTH - 1 DOWNTO 0);
    BEGIN
        X_int := unsigned(X);
        Y_int := unsigned(Y);

        IF Y_int = 0 THEN
            R_int := (OTHERS => 'X');
        ELSE
            R_int := X_int MOD Y_int;
            R <= STD_LOGIC_VECTOR(R_int);
        END IF;
    END PROCESS;

END Behavioral;