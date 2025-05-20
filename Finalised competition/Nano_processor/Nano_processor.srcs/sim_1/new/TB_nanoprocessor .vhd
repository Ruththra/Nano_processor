----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 11:45:22 AM
-- Design Name: 
-- Module Name: TB_nanoprocessor - Behavioral
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

entity TB_nanoprocessor is
--  Port ( );
end TB_nanoprocessor;

architecture Behavioral of TB_nanoprocessor is
component Nano_processor 
    Port ( 
           Reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           overflow_led : out STD_LOGIC;   
           zero_led : out STD_LOGIC;
           carry_led : out STD_LOGIC;
           Reg7_led : out std_logic_vector(3 downto 0);
           Reg7_digit : out std_logic_vector(6 downto 0);
           Anode : out std_logic_vector(3 downto 0)
         );
end component;

signal clk,Reset,overflow,zero,carry:std_logic;
signal reg7_led:std_logic_vector(3 downto 0);
signal reg7_dig:std_logic_vector(6 downto 0);
signal anode:std_logic_vector(3 downto 0):="1110";


begin

UUT : Nano_processor port map(
Reset=>Reset,
clk=>clk,
overflow_led=>overflow,
zero_led=>zero,
carry_led=>carry,
Reg7_led=>reg7_led,
Anode=>anode,
Reg7_digit=>reg7_dig);

process begin
clk<='0';
wait for 5ns;
clk<='1';
wait for 5ns;
end process;

process begin
Reset<='1';
wait for 110ns;
Reset<='0';
wait;
end process;



end Behavioral;
