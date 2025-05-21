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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_decoder is
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
end Instruction_decoder;

architecture Behavioral of Instruction_decoder is

--     component Decoder_2_to_4
--         Port ( I : in STD_LOGIC_VECTOR (1 downto 0);
--             --    EN : in STD_LOGIC;
--                Y : out STD_LOGIC_VECTOR (3 downto 0));
--     end component;

-- signal Add, Neg, Jump : STD_LOGIC;
-- -- signal mov : STD_LOGIC;
-- signal decoder_out : STD_LOGIC_VECTOR (3 downto 0);
-- signal jump_check_reg : STD_LOGIC_VECTOR (3 downto 0);


begin
    -- -- Decoder_2_to_4_inst : Decoder_2_to_4
    -- Decoder_2_to_4_inst : Decoder_2_to_4
    --     port map (
    --         I => instruction(11 downto 10),
    --         -- EN => '1',
    --         Y => decoder_out
    --     );

    -- -- Assigning the decoder outputs to the respective signals
    -- Add <= decoder_out(0);
    -- Neg <= decoder_out(1);
    -- -- Mov <= decoder_out(2);
    -- Jump <= decoder_out(3);

    -- -- Assigning the signal based on the instruction
    -- load_sel <= Add or Neg;
    -- value <= instruction(3 downto 0);
    -- reg_en(0) <= instruction(7) and (not Jump);
    -- reg_en(1) <= instruction(8) and (not Jump);
    -- reg_en(2) <= instruction(9) and (not Jump);
    -- reg_a <= instruction(9 downto 7);
    -- reg_b <= instruction(6 downto 4);
    -- addORsub <= Neg;


    -- -- Jump logic
    -- jump_check_reg <= jump_check;
    -- jump_flag <= Jump and (not (jump_check_reg(3) or jump_check_reg(2) or jump_check_reg(1) or jump_check_reg(0)));
    -- jump_address <= instruction(2 downto 0);









    process (instruction, jump_check)
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
        if (instruction(11 downto 10) = "00") then
            -- Addition instruction
            reg_a <= instruction(9 downto 7);
            reg_b <= instruction(6 downto 4);
            load_sel <= '1';
            reg_en <= instruction(9 downto 7);
        elsif (instruction(11 downto 10) = "01") then
            -- Negation instruction
            reg_a <= "000"; -- In Reg6 must be contained '0000' otherwise the result will be wrong
            reg_b <= instruction(9 downto 7);
            load_sel <= '1';
            addORsub <= '1'; -- Changing mode to subtract to negate the value
            reg_en<=instruction(9 downto 7);
        elsif (instruction(11 downto 10) = "10") then
            -- Load instruction
            reg_en <= instruction(9 downto 7);
            load_sel <= '0';
            value <= instruction(3 downto 0);
        elsif (instruction(11 downto 10) = "11") then
            -- Jump instruction
            reg_a <= instruction(9 downto 7);
            if jump_check = "0000" then
                jump_flag <= '1';
                jump_address <= instruction(2 downto 0);
            else
                jump_flag <= '0';
            end if;
        end if;
    end process;
        
end Behavioral;
