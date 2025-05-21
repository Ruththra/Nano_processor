----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2025 05:03:13
-- Design Name: 
-- Module Name: Program_mode_reg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 4-bit Program_mode_register with an enable signal.
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

entity Program_mode_reg is
    Port ( 
        En    : in  STD_LOGIC;
        Clk   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end Program_mode_reg;

architecture Behavioral of Program_mode_reg is
    signal Q_reg : STD_LOGIC := '0'; -- Initialize to '0'
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if En = '1' then
                Q_reg <= not Q_reg; -- Toggle Q_reg
            end if;
        end if;
    end process;

    Q <= Q_reg; -- Only assign Q here, outside the process
end Behavioral;
