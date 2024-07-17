LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
PACKAGE MyLib IS

    COMPONENT I2C_Master
        GENERIC (
            SYSTEM_CLK : INTEGER := 10_000_000;
            BUS_CLK : INTEGER := 400_000 -- FAST MODE
        );
        PORT (
            CLK : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            En : IN STD_LOGIC;
            Addr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
            I2C_RW : IN STD_LOGIC; -- 0: WRITE 1: READ
            Data_wr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Data_rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            I2C_busy : OUT STD_LOGIC;
            SCL : OUT STD_LOGIC;
            SDA : INOUT STD_LOGIC
        );
    END COMPONENT;
END PACKAGE MyLib;