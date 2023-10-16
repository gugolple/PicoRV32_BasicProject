----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2023 05:07:18 PM
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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
use IEEE.NUMERIC_STD.all;

entity clock_divider is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is
  signal prescaler : unsigned(23 downto 0);
  signal clk_2Hz_i : std_logic;
  begin
  
  gen_clk : process (clk_in)
  begin  -- process gen_clk
    if rising_edge(clk_in) then   -- rising clock edge
      if prescaler = 12_500_000 then     -- 12 500 000 in hex
        prescaler   <= (others => '0');
        clk_out   <= not clk_2Hz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

  clk_out <= clk_2Hz_i;

end Behavioral;
