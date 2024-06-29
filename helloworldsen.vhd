LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY helloworldsen IS
END ENTITY;

ARCHITECTURE sim OF helloworldsen IS
    SIGNAL Signal1 : STD_LOGIC := '0';
    SIGNAL signal2 : STD_LOGIC;
    SIGNAL signal3 : STD_LOGIC;
BEGIN

    PROCESS IS
    BEGIN
        Signal1 <= NOT Signal1;
        WAIT FOR 10 ns;
    END PROCESS;

    PROCESS IS
    BEGIN
        signal2 <= 'Z';
        signal3 <= '0';
        WAIT;
    END PROCESS;

END ARCHITECTURE;