----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2024 01:57:08 PM
-- Design Name: 
-- Module Name: RGB2Gray_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY RGB2Gray_tb IS

  GENERIC (CAM_DATA_WIDTH : INTEGER := 8);
  --  Port ( );
END RGB2Gray_tb;

ARCHITECTURE Behavioral OF RGB2Gray_tb IS
  COMPONENT RGB2Gray IS
    GENERIC (
      CAM_DATA_WIDTH : INTEGER := 8
    );
    PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      red_i : IN STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
      green_i : IN STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
      blue_i : IN STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
      done_i : IN STD_LOGIC;
      -- OUTPUTS

      grayscale_o : OUT STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
      done_o : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL clk : STD_LOGIC;
  SIGNAL rst : STD_LOGIC;
  SIGNAL red_i : STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL green_i : STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL blue_i : STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL done_i : STD_LOGIC;
  SIGNAL grayscale_o : STD_LOGIC_VECTOR(CAM_DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL done_o : STD_LOGIC;

  CONSTANT clk_period : TIME := 20 ns;

BEGIN

DUT : RGB2Gray
GENERIC MAP(CAM_DATA_WIDTH)
PORT MAP(clk, rst, red_i, green_i, blue_i, done_i, grayscale_o, done_o);

clkProcess : PROCESS
BEGIN
  clk <= '0';
  WAIT FOR clk_period / 2;
  clk <= '1';
  WAIT FOR clk_period / 2;
END PROCESS;

SIM : PROCESS
BEGIN
  rst <= '1';
  done_i <= '0';
  red_i <= (OTHERS => '0');
  blue_i <= (OTHERS => '0');
  green_i <= (OTHERS => '0');
  WAIT FOR clk_period * 2;
  rst <= '0';
  red_i <= "00000100";
  green_i <= "00000010";
  blue_i <= "00010000";
  done_i <= '1';

  WAIT FOR clk_period;
  done_i <= '0';
  WAIT;
END PROCESS;
END Behavioral;