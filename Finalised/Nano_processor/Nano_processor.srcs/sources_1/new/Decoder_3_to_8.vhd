----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2025 01:38:47 PM
-- Design Name: 
-- Module Name: Decoder_3_to_8 - Behavioral (if-else implementation)
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 3-to-8 decoder using if-else conditional statements.
-- 
-- Dependencies: 
--   None.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_3_to_8 is
    Port ( 
           I : in STD_LOGIC_VECTOR (2 downto 0);                  
           Y : out STD_LOGIC_VECTOR (7 downto 0) 
         );
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is
begin
    process(I)
    begin
        -- Default output is all zeros
        Y <= (others => '0');
        
        -- Check the input and set the corresponding output bit
        if I = "000" then
            Y(0) <= '1';
        elsif I = "001" then
            Y(1) <= '1';
        elsif I = "010" then
            Y(2) <= '1';
        elsif I = "011" then
            Y(3) <= '1';
        elsif I = "100" then
            Y(4) <= '1';
        elsif I = "101" then
            Y(5) <= '1';
        elsif I = "110" then
            Y(6) <= '1';
        elsif I = "111" then
            Y(7) <= '1';
        end if;
    end process;
end Behavioral;