----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2025 12:27:22 PM
-- Design Name: 
-- Module Name: Slow_Clk - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module generates a slower clock signal by dividing the input clock.
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

entity Slow_Clk is
    Port (
        Clk_in   : in  STD_LOGIC;
        Reset    : in  STD_LOGIC;
        Stop     : in  STD_LOGIC;
        Clk_out  : out STD_LOGIC
    );
end Slow_Clk;

architecture Behavioral of Slow_Clk is
    signal count      : std_logic_vector(25 downto 0) := (others => '0'); -- 26 bits
    signal Clk_status : STD_LOGIC := '0';
begin

    process (Clk_in, Reset)
    begin
        if (Reset = '1') then
            count <= (others => '0');
        elsif rising_edge(Clk_in) then
            if (Stop = '1') then
                count <= (others => '0');
            else
                count <= std_logic_vector(unsigned(count) + 1);
            end if;
        end if;
    end process;

    Clk_status <= count(25); -- 25th bit (index 24)
    Clk_out <= Clk_status;

end Behavioral;
