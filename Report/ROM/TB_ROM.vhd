----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 12:34:41 PM
-- Design Name: 
-- Module Name: TB_ROM - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_ROM is
--  Port ( );
end TB_ROM;

architecture Behavioral of TB_ROM is

component Program_Rom 
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           instruction : out STD_LOGIC_VECTOR (11 downto 0));
end component;

signal mem_add:std_logic_vector(2 downto 0);
signal instr:std_logic_vector(11 downto 0);

begin

UUT:Program_Rom port map(
address=>mem_add,
instruction=>instr);

process begin
-- 230060M -> 111 000 001 010 101 100
mem_add<="100";
wait for 100ns;
mem_add<="101";
wait for 100ns;
mem_add<="010";
wait for 100ns;
mem_add<="001";
wait for 100ns;
mem_add<="000";
wait for 100ns;
mem_add<="111";

wait;

end process;


end Behavioral;
