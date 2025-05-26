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
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input_instruction : in STD_LOGIC_VECTOR (12 downto 0);
           program_mode : in STD_LOGIC; -- 1 for program mode, 0 for data mode
           load : in STD_LOGIC; -- Load new instruction into ROM
           load_sig : out STD_LOGIC; -- Load signal for external use
           p_signal : out STD_LOGIC; -- Program signal
           instruction : out STD_LOGIC_VECTOR (12 downto 0));


end Program_Rom;

architecture Behavioral of Program_Rom is
type rom_type is array (0 to 7) of std_logic_vector(12 downto 0);
signal program_ROM : rom_type :=(
--    "0101110000001",-- MOVI R7, 1 --0
--    "0100100000010",-- MOVI R2, 2 --1
--    "0100010000011",-- MOVI R1, 3 --2
--    "0001110100000",-- ADD R7, R2 --3
--    "0001110010000",-- ADD R7, R1 --4
--    "0000000000000",--            --5
--    "0000000000000",--            --6
--    "0000000000000"--             --7
    
    "0100010001010",-- MOVI R1, 10 --0
    "0100100000001",-- MOVI R2, 1  --1
    "0010100000000",-- NEG R2      --2
    "0000010100000",-- ADD R1, R2  --3
    "0110010000111",-- JZR R1, 7   --4
    "0110000000011",-- JZR R0, 3   --5
    "0000000000000",--             --6
    "0000000000000"--              --7	
);
begin

    --default values
    -- load_sig <= '0';
    process(clk, reset, load, program_mode, address, input_instruction)
    begin
        if rising_edge(clk) then
            if program_mode = '1' then
                p_signal <= '1'; -- Indicate that the program is in programming mode
                load_sig <= '0'; -- Clear load signal
                if reset = '1' then
                    program_ROM <= (others => (others => '0')); -- Clear all ROM contents
                    instruction <= (others => '0'); -- Reset instruction output to zero
                elsif load = '1' then
                    program_ROM(to_integer(unsigned(address))) <= input_instruction; -- Load new instruction
                    load_sig <= '1'; -- Indicate that a new instruction is being loaded

                end if;
            elsif program_mode = '0' then
                load_sig <= '0'; -- Clear load signal
                p_signal <= '0'; -- Indicate that the program is in data mode
                instruction <= program_ROM(to_integer(unsigned(address))); -- Read instruction from ROM
            end if;
        end if;
    end process;

end Behavioral;


