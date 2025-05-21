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
           reset_sig : out STD_LOGIC;            -- Reset signal for external use
           Q : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit output data
         );
end Reg;

architecture Behavioral of Reg is
begin
    -- Define the reset signal for external use
    -- reset_sig <= '0';

    process(Clk, Reset)
    begin
        if Reset = '1' then
            Q <= (others => '0');
            reset_sig <= '1'; -- Set the reset signal for external use
        elsif rising_edge(Clk) then
            reset_sig <= '0'; -- Clear the reset signal
            if En = '1' then
                Q <= D;
            end if;
        end if;
        -- reset_sig <= '0'; -- Clear the reset signal
    end process;
end Behavioral;
