----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2023 04:52:59 PM
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (1 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0));
end test;

architecture Behavioral of test is
    component clock_divider
        port(clk_in : in std_logic; clk_out : out std_logic);
    end component;
    signal clock_divided : std_logic;
begin

clock_divider_instance : clock_divider port map (clk_in => clk, clk_out => clock_divided);

led(0) <= clock_divided;
led(1) <= not(clock_divided);
led(2) <= btn(0);
led(3) <= not(btn(1));

end Behavioral;
