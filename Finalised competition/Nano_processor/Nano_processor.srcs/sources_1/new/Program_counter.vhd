----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 12:07:36 AM
-- Design Name: 
-- Module Name: Program_counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 3-bit program counter using a register.
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

entity Program_counter is
    Port ( 
           Mux_out : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0)
         );
end Program_counter;

architecture Behavioral of Program_counter is

    signal Reg : STD_LOGIC_VECTOR (2 downto 0) := "000";
    
begin

    -- Process to implement the program counter logic
    process (Clk, Res)
    begin
        if (Res = '1') then
            -- Reset the program counter to "000"
            Reg <= "000";
        elsif rising_edge(Clk) then
            -- Update the program counter with the input value
            Reg <= Mux_out;
        end if;
    end process;

    -- Assign the internal register value to the output port
    Q <= Reg;

end Behavioral;
