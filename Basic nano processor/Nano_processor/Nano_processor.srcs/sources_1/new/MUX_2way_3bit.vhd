----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 06:36:57 PM
-- Design Name: 
-- Module Name: MUX_2way_3bit - Behavioral
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

entity MUX_2way_3bit is
    Port ( JumpFlag : in STD_LOGIC;
           JumpAdd : in STD_LOGIC_VECTOR (2 downto 0);
           SeqAdd : in STD_LOGIC_VECTOR (2 downto 0);
           NextPC : out STD_LOGIC_VECTOR (2 downto 0));
end MUX_2way_3bit;

architecture Behavioral of MUX_2way_3bit is

begin

-- JumpFlag=1 -> JumpAddress

NextPC <= JumpAdd when JumpFlag = '1' else SeqAdd;

end Behavioral;
