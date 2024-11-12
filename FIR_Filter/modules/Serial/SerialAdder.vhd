LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SerialAdder IS
    PORT (
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            cin : IN STD_LOGIC;
            a, b : IN STD_LOGIC;
            sum : OUT STD_LOGIC;
            cout : OUT STD_LOGIC);
    );
END ENTITY SerialAdder;

ARCHITECTURE rtl OF SerialAdder IS

BEGIN
    SIGNAL carry : STD_LOGIC;
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            carry <= '0';
            sum <= '0';
        ELSIF rising_edge(clk) THEN
            sum <= a XOR b XOR carry;
            carry <= (a AND b) OR (a AND carry) OR (b AND carry);
        END IF;
    END PROCESS;

    cout <= carry;
    -

END ARCHITECTURE rtl;