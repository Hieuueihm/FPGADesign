----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2024 01:42:01 PM
-- Design Name: 
-- Module Name: RGB2Gray - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RGB2Gray is
   GENERIC (
    CAM_DATA_WIDTH : INTEGER := 8
   );
  Port ( 
    clk : in std_logic;
    rst : in std_logic;
    red_i: in std_logic_vector(CAM_DATA_WIDTH - 1 DOWNTO 0);
    green_i: in std_logic_vector(CAM_DATA_WIDTH - 1 DOWNTO 0);
    blue_i: in std_logic_vector(CAM_DATA_WIDTH - 1 DOWNTO 0);
    done_i : in std_logic;
    -- OUTPUTS
    
    grayscale_o: out std_logic_vector(CAM_DATA_WIDTH - 1 DOWNTO 0);
    done_o: out std_logic
   
  );
end RGB2Gray;

architecture Behavioral of RGB2Gray is

begin
    RGB2GrayScaleProcess: process(rst, clk)
    begin
        if rst = '1' then
            grayscale_o <= (others => '0');
            done_o <= '0';
        elsif rising_edge(clk) then
            if done_i = '1' then
               grayscale_o <= std_logic_vector(shift_right(unsigned(red_i), 2) + shift_right(unsigned(red_i), 5) + 
                   shift_right(unsigned(green_i), 1) + shift_right(unsigned(green_i), 4) + 
                   shift_right(unsigned(blue_i), 4) + shift_right(unsigned(blue_i), 5));
                done_o <= '1';
            else
                grayscale_o <= (others => '0');
                done_o <= '0';
            end if;
        end if;
    
    end process;

end Behavioral;
