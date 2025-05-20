----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2025 02:31:33
-- Design Name: 
-- Module Name: Program_Rom - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_Rom is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           instruction : out STD_LOGIC_VECTOR (11 downto 0));
end Program_Rom;

architecture Behavioral of Program_Rom is
type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
signal program_ROM : rom_type :=(
    "100010001010",-- MOVI R1, 10 --0
    "100100000001",-- MOVI R2, 1  --1
    "010100000000",-- NEG R2      --2
    "000010100000",-- ADD R1, R2  --3
    "110010000111",-- JZR R1, 7   --4
    "110000000011",-- JZR R0, 3   --5
    "000000000000",--             --6
    "000000000000"--              --7

--    "101110000001",-- MOVI R7, 1 --0
--    "100100000010",-- MOVI R2, 2 --1
--    "100010000011",-- MOVI R1, 3 --2
--    "001110100000",-- ADD R7, R2 --3
--    "001110010000",-- ADD R7, R1 --4
--    "000000000000",--            --5
--    "000000000000",--            --6
--    "000000000000"--             --7

-- "000000000000",-- MOVI R0, 0 --0
-- "000000000000",-- MOVI R0, 0 --0
-- "000000000000",-- MOVI R0, 0 --0
-- "000000000000",-- MOVI R0, 0 --0
-- "000000000000",-- MOVI R0, 0 --0
-- "000000000000",-- MOVI R0, 0 --0
-- "000000000000",-- MOVI R0, 0 --0
-- "000000000000"-- MOVI R0, 0 --0

    );
    
begin
    instruction <= program_ROM(to_integer(unsigned(address))); 

end Behavioral;
