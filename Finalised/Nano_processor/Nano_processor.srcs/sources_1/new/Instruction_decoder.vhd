----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2025 05:44:11
-- Design Name: 
-- Module Name: Instruction_decoder - Behavioral
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

--Instruction Set
-- 000: ADD   -- 000 RaRaRa RbRbRb 0000    -- ADD Ra and Rb and store in Ra
-- 001: NEG   -- 001 RaRaRa 000 0000       -- Negate Ra
-- 010: MOVI  -- 010 RaRaRa 000 dddd       -- Move immediate value dddd to Ra
-- 011: JZR   -- 011 RaRaRa 000 dddd       -- Jump to address dddd if Ra is zero
-- 100: MOV   -- 100 RaRaRa RbRbRb 0000    -- Move value from Ra to Rb
-- 101: AND   -- 101 RaRaRa RbRbRb 0000    -- AND Ra and Rb and store in Ra
-- 110: OR    -- 110 RaRaRa RbRbRb 0000    -- OR Ra and Rb and store in Ra
-- 111: XOR   -- 111 RaRaRa RbRbRb 0000    -- XOR Ra and Rb and store in Ra

entity Instruction_decoder is
    Port ( instruction : in STD_LOGIC_VECTOR (12 downto 0);
           val_MUX_0 : in std_logic_vector (3 downto 0);
           val_MUX_1 : in STD_LOGIC_VECTOR (3 downto 0);
           reg_en : out STD_LOGIC_VECTOR (2 downto 0);
           load_sel : out STD_LOGIC;
           value : out STD_LOGIC_VECTOR (3 downto 0);
           reg_a : out STD_LOGIC_VECTOR (2 downto 0);
           reg_b : out STD_LOGIC_VECTOR (2 downto 0);
           addORsub : out STD_LOGIC;
           jump_flag : out STD_LOGIC;
           error : out STD_LOGIC;
           jump_address : out STD_LOGIC_VECTOR (2 downto 0));
end Instruction_decoder;

architecture Behavioral of Instruction_decoder is

signal processed_value : std_logic_vector (3 downto 0);

begin

    process (instruction, val_MUX_0)
    begin
        -- Default values for outputs
        reg_a <= (others => '0');
        reg_b <= (others => '0');
        reg_en <= (others => '0');
        load_sel <= '0';
        value <= (others => '0');
        addORsub <= '0';
        jump_flag <= '0';
        jump_address <= (others => '0');
        
        -- Decode the instruction
        if (instruction(12 downto 10) = "000") then
            -- Addition instruction
            reg_a <= instruction(9 downto 7);
            reg_b <= instruction(6 downto 4);
            load_sel <= '1';
            reg_en <= instruction(9 downto 7);
        elsif (instruction(12 downto 10) = "001") then
            -- Negation instruction
            reg_a <= "000"; -- In Reg6 must be contained '0000' otherwise the result will be wrong
            reg_b <= instruction(9 downto 7);
            load_sel <= '1';
            addORsub <= '1'; -- Changing mode to subtract to negate the value
            reg_en<=instruction(9 downto 7);
        elsif (instruction(12 downto 10) = "010") then
            -- Load instruction
            reg_en <= instruction(9 downto 7);
            load_sel <= '0';
            value <= instruction(3 downto 0);
        elsif (instruction(12 downto 10) = "011") then
            -- Jump instruction
            reg_a <= instruction(9 downto 7);
            if val_MUX_0 = "0000" then
                jump_flag <= '1';
                jump_address <= instruction(2 downto 0);
            else
                jump_flag <= '0';
            end if;
        elsif (instruction(12 downto 10) = "100") then
            -- Move instruction
            reg_a <= instruction(9 downto 7);
            reg_en <= instruction(6 downto 4);
            value <= val_MUX_0;

        elsif (instruction(12 downto 10) = "101") then
            -- AND instruction
            reg_a <= instruction(9 downto 7);
            reg_b <= instruction(6 downto 4);
            reg_en <= instruction(9 downto 7);

            processed_value <= val_MUX_0 and val_MUX_1;
            value <= processed_value;

        elsif (instruction(12 downto 10) = "110") then
            -- OR instruction
            reg_a <= instruction(9 downto 7);
            reg_b <= instruction(6 downto 4);
            reg_en <= instruction(9 downto 7);

            processed_value <= val_MUX_0 or val_MUX_1;
            value <= processed_value;
        elsif (instruction(12 downto 10) = "111") then
            -- XOR instruction
            reg_a <= instruction(9 downto 7);
            reg_b <= instruction(6 downto 4);
            reg_en <= instruction(9 downto 7);

            processed_value <= val_MUX_0 xor val_MUX_1;
            value <= processed_value;
        else
            -- Invalid instruction
            reg_a <= (others => '0');
            reg_b <= (others => '0');
            error <= '1'; -- Set error flag
        end if;

    end process;
        
end Behavioral;
