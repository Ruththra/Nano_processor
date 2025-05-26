----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2025 05:03:13
-- Design Name: 
-- Module Name: Reg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 4-bit register with an enable signal and reset.
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

entity Reg is
    Port ( 
           D : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit input data
           En : in STD_LOGIC;                   -- Enable signal
           Clk : in STD_LOGIC;                  -- Clock signal
           Reset : in STD_LOGIC;                -- Reset signal
           Q : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit output data
         );
end Reg;

architecture Behavioral of Reg is

begin
    process (Clk, Reset) 
    begin
        if rising_edge(Clk) then -- Respond on the rising edge of the clock
            if Reset = '1' then
                Q <= (others => '0'); -- Reset the output to all zeros
            elsif En = '1' then
                Q <= D; -- Load data when enabled
            end if;
        end if;
    end process;

end Behavioral;
