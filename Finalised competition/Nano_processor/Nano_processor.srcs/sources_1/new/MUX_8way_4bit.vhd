----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 07:02:34 PM
-- Design Name: 
-- Module Name: MUX_8way_4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8-to-1 multiplexer, each input 4-bit wide
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

entity MUX_8way_4bit is
    Port ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
           R1 : in STD_LOGIC_VECTOR (3 downto 0);
           R2 : in STD_LOGIC_VECTOR (3 downto 0);
           R3 : in STD_LOGIC_VECTOR (3 downto 0);
           R4 : in STD_LOGIC_VECTOR (3 downto 0);
           R5 : in STD_LOGIC_VECTOR (3 downto 0);
           R6 : in STD_LOGIC_VECTOR (3 downto 0);
           R7 : in STD_LOGIC_VECTOR (3 downto 0);
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           RegVal : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_8way_4bit;

architecture Behavioral of MUX_8way_4bit is
begin

    process(R0, R1, R2, R3, R4, R5, R6, R7, RegSel)
    begin
        if RegSel = "000" then
            RegVal <= R0;
        elsif RegSel = "001" then
            RegVal <= R1;
        elsif RegSel = "010" then
            RegVal <= R2;
        elsif RegSel = "011" then
            RegVal <= R3;
        elsif RegSel = "100" then
            RegVal <= R4;
        elsif RegSel = "101" then
            RegVal <= R5;
        elsif RegSel = "110" then
            RegVal <= R6;
        elsif RegSel = "111" then
            RegVal <= R7;
        else
            RegVal <= (others => '0');
        end if;
    end process;

end Behavioral;
