----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 11:41:09 AM
-- Design Name: 
-- Module Name: TB_Instruction_decoder - Behavioral
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

entity TB_Instruction_decoder is
--  Port ( );
end TB_Instruction_decoder;

architecture Behavioral of TB_Instruction_decoder is

component Instruction_decoder 
    Port ( instruction : in STD_LOGIC_VECTOR (11 downto 0);
           jump_check : in std_logic_vector (3 downto 0);
           reg_en : out STD_LOGIC_VECTOR (2 downto 0);
           load_sel : out STD_LOGIC;
           value : out STD_LOGIC_VECTOR (3 downto 0);
           reg_a : out STD_LOGIC_VECTOR (2 downto 0);
           reg_b : out STD_LOGIC_VECTOR (2 downto 0);
           addORsub : out STD_LOGIC;
           jump_flag : out STD_LOGIC;
           jump_address : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal instr:std_logic_vector(11 downto 0);
signal jmp_check,val:std_logic_vector(3 downto 0);
signal reg_en,reg_a,reg_b,jmp_add:std_logic_vector(2 downto 0);
signal load_sel,jmp_flag,addOsub:std_logic;

begin

UUT : Instruction_decoder port map(
 instruction=>instr,
 jump_check=>jmp_check,
 reg_en=>reg_en,
 load_sel=>load_sel,
 value=>val,
 reg_a=>reg_a,
 reg_b=>reg_b,
 addORsub=>addOsub,
 jump_flag=>jmp_flag,
 jump_address=>jmp_add);
 
process begin

jmp_check<="0000";

-- 230060M 000000111000 001010101100
instr<="001010101100";
wait for 100ns;
instr<="000000111000";
wait for 100ns;
instr<="010100000000";
wait for 100ns;
instr<="000010100000";
wait for 100ns;
instr<="110010000111";
jmp_check<="1001";
wait for 100ns;
instr<="110000000011";
jmp_check<="0000";
wait;


end process;


end Behavioral;
