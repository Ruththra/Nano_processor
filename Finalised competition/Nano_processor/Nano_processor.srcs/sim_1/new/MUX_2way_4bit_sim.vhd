----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 06:50:39 PM
-- Design Name: 
-- Module Name: MUX_2way_4bit - Behavioral
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

entity MUX_2way_4bit is
    Port ( loadSel : in STD_LOGIC;
           ImmedVal : in STD_LOGIC_VECTOR (3 downto 0);
           ALUVal : in STD_LOGIC_VECTOR (3 downto 0);
           OutputVal : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_2way_4bit;

architecture Behavioral of MUX_2way_4bit is

begin

-- loadSel=1 -> Immediate value
OutputVal <= ImmedVal when loadSel = '0' else ALUVal;

-- OutputVal<=(ImmedVal and  (3 downto 0=>loadSel)) or (ALUVal and not (3 downto 0=>loadSel));

end Behavioral;
