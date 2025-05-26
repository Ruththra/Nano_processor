----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 07:20:09 PM
-- Design Name: 
-- Module Name: Program_counter_Sim - Behavioral
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

entity Program_counter_Sim is
--  Port ( );
end Program_counter_Sim;

architecture Behavioral of Program_counter_Sim is
component Program_counter
port ( Mux_out : in STD_LOGIC_VECTOR (2 downto 0) := "000";
       Clk : in STD_LOGIC;
       Res : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal Clock : std_logic:='0';
signal Res : std_logic;
signal Mux_Out : std_logic_vector(2 downto 0) := "000";
signal Q : std_logic_vector(2 downto 0);

begin

UUT:Program_counter
port map(
Clk=>Clock,
Res=>Res,
Q=>Q,
Mux_out=>Mux_Out);

process begin
Clock<=not(Clock);
wait for ns;
end process;

process begin
Res<='1';
Mux_Out<="000";

wait for 100ns;
Mux_Out<="001";

wait for 100ns;
Mux_Out<="010";

wait for 100ns;
Mux_Out<="011";

wait for 100ns;
Mux_Out<="101";

wait for 100ns;
Mux_Out<="110";

wait for 100ns;
Mux_Out<="111";

wait for 100ns;
Res<='0';
Mux_Out<="000";

wait for 100ns;
Mux_Out<="001";
wait for 100ns;

Mux_Out<="010";
wait for 100ns;

Mux_Out<="011";
wait for 100ns;

Mux_Out<="101";
wait for 100ns;

Mux_Out<="110";
wait for 100ns;

Mux_Out<="111";

wait;
end process;
end Behavioral;

