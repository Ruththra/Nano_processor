----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2025 05:01:10
-- Design Name: 
-- Module Name: Nano_processor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 4-bit Nano processor with a program counter,
--   instruction decoder, ALU, register bank, and LED display outputs.
-- 
-- Dependencies: 
--   Requires components: Slow_Clk, Program_counter, LUT_16_7, Program_Rom,
--   Instruction_decoder, RCA_3, RCA_4, Reg_bank_8, MUX_8way_4bit, MUX_2way_3bit, MUX_2way_4bit.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nano_processor is
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
end Nano_processor;

architecture Behavioral of Nano_processor is

component Program_counter
    Port ( 
           Mux_out : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0)
         );
end component;
component LUT_16_7
    Port ( 
           address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0)
         );
end component;
component Program_Rom
    Port ( 
           address : in STD_LOGIC_VECTOR (2 downto 0);
           instruction : out STD_LOGIC_VECTOR (11 downto 0)
         );
end component;
component Instruction_decoder 
    Port ( 
           instruction : in STD_LOGIC_VECTOR (11 downto 0);
           jump_check : in std_logic_vector (3 downto 0);
           reg_en : out STD_LOGIC_VECTOR (2 downto 0);
           load_sel : out STD_LOGIC;
           value : out STD_LOGIC_VECTOR (3 downto 0);
           reg_a : out STD_LOGIC_VECTOR (2 downto 0);
           reg_b : out STD_LOGIC_VECTOR (2 downto 0);
           addORsub : out STD_LOGIC;
           jump_flag : out STD_LOGIC;
           jump_address : out STD_LOGIC_VECTOR (2 downto 0)
         );
end component;
component RCA_3 
    Port ( 
           A      : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit input A
           B      : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit input B
           S      : out  STD_LOGIC_VECTOR(2 downto 0) -- 3-bit input C
         );
end component;
component MUX_2way_3bit
    Port ( 
           JumpFlag : in STD_LOGIC;
           JumpAdd : in STD_LOGIC_VECTOR (2 downto 0);
           SeqAdd : in STD_LOGIC_VECTOR (2 downto 0);
           NextPC : out STD_LOGIC_VECTOR (2 downto 0)
         );
end component;
component MUX_2way_4bit 
    Port ( 
           loadSel : in STD_LOGIC;
           ImmedVal : in STD_LOGIC_VECTOR (3 downto 0);
           ALUVal : in STD_LOGIC_VECTOR (3 downto 0);
           OutputVal : out STD_LOGIC_VECTOR (3 downto 0)
         );
end component;
component RCA_4 
    Port ( 
           A      : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input A
           B      : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input B
           mode : in STD_LOGIC;           -- Add/Subtract mode (0 for add, 1 for subtract)
           S      : out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit sum output
           c_out : out STD_LOGIC;          -- Carry-out
           overflow : out STD_LOGIC        -- Overflow flag
         );
end component;
component Reg_bank_8
    Port ( 
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;                  -- Clock signal
           Reset : in STD_LOGIC;                -- Reset signal
           Input: in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit input data
           Out_0, Out_1, Out_2, Out_3, Out_4, Out_5, Out_6, Out_7 : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit output data
         );
end component;
component MUX_8way_4bit 
    Port ( 
           R0 : in STD_LOGIC_VECTOR (3 downto 0);
           R1 : in STD_LOGIC_VECTOR (3 downto 0);
           R2 : in STD_LOGIC_VECTOR (3 downto 0);
           R3 : in STD_LOGIC_VECTOR (3 downto 0);
           R4 : in STD_LOGIC_VECTOR (3 downto 0);
           R5 : in STD_LOGIC_VECTOR (3 downto 0);
           R6 : in STD_LOGIC_VECTOR (3 downto 0);
           R7 : in STD_LOGIC_VECTOR (3 downto 0);
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           RegVal : out STD_LOGIC_VECTOR (3 downto 0)
         );
end component;
component Slow_Clk 
    Port ( 
           Clk_in : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk_out : out STD_LOGIC
         );
end component;
-- For Clock
signal slow_clock : STD_LOGIC;

--For Program Counter
signal RomEn : STD_LOGIC_VECTOR (2 downto 0);
signal Mux_out : STD_LOGIC_VECTOR (2 downto 0);

--For Instruction Decoder
signal instruction : STD_LOGIC_VECTOR (11 downto 0);
signal reg_en : STD_LOGIC_VECTOR (2 downto 0);
signal load_sel : STD_LOGIC;
signal value : STD_LOGIC_VECTOR (3 downto 0);
signal reg_a : STD_LOGIC_VECTOR (2 downto 0);
signal reg_b : STD_LOGIC_VECTOR (2 downto 0);
signal addORsub : STD_LOGIC;
signal jump_flag : STD_LOGIC;
signal jump_address : STD_LOGIC_VECTOR (2 downto 0);

-- For RCA_3
signal Nxt_pc : std_logic_vector (2 downto 0);

--For RCA_4
signal ALUVal : STD_LOGIC_VECTOR (3 downto 0);
signal RegVal_0, RegVal_1 : STD_LOGIC_VECTOR (3 downto 0);

--For Reg Bank
signal OutputVal : STD_LOGIC_VECTOR (3 downto 0);
signal Out_0, Out_1, Out_2, Out_3, Out_4, Out_5, Out_6, Out_7 : STD_LOGIC_VECTOR (3 downto 0);


begin

    -- Instantiate the components
    Slow_Clk_inst : Slow_Clk
        port map (
            Clk_in => clk,
            Reset => Reset,
            Clk_out => slow_clock
        );

    Program_counter_inst : Program_counter
        port map (
            Mux_out => Mux_out,
            Clk => slow_clock,
            Res => Reset,
            Q => RomEn
        );

    LUT_16_7_inst : LUT_16_7
        port map (
            address => Out_7,
            data => Reg7_digit
        );

    Program_Rom_inst : Program_Rom
        port map (
            address => RomEn,
            instruction => instruction
        );

    Instruction_decoder_inst : Instruction_decoder
        port map (
            instruction => instruction,
            jump_check => RegVal_0,
            reg_en => reg_en,
            load_sel => load_sel,
            value => value,
            reg_a => reg_a,
            reg_b => reg_b,
            addORsub => addORsub,
            jump_flag => jump_flag,
            jump_address => jump_address
        );

    RCA_3_inst : RCA_3 
        port map (
            A => RomEn,
            B => "001",
            S => Nxt_pc
        );

    MUX_2way_3bit_inst : MUX_2way_3bit
        port map (
           JumpFlag => jump_flag,
           JumpAdd => jump_address,
           SeqAdd => Nxt_pc,
           NextPC => Mux_out
         );

    MUX_2way_4bit_inst : MUX_2way_4bit
        port map (
           loadSel => load_sel,
           ImmedVal => value,
           ALUVal => ALUVal,
           OutputVal => OutputVal
         );

    RCA_4_inst : RCA_4 
        port map (
              A => RegVal_0,
              B => RegVal_1,
              mode => addORsub,
              S => ALUVal,
              c_out => carry_led,
              overflow => overflow_led
         );

    Reg_bank_8_inst : Reg_bank_8
        port map (
           RegSel => reg_en,
           Clk => slow_clock,
           Reset => Reset,
           Input => OutputVal,
           Out_0 => Out_0,
           Out_1 => Out_1,
           Out_2 => Out_2,
           Out_3 => Out_3,
           Out_4 => Out_4,
           Out_5 => Out_5,
           Out_6 => Out_6,
           Out_7 => Out_7
         );
    MUX_8way_4bit_0 : MUX_8way_4bit
        port map (
              R0 => Out_0,
              R1 => Out_1,
              R2 => Out_2,
              R3 => Out_3,
              R4 => Out_4,
              R5 => Out_5,
              R6 => Out_6,
              R7 => Out_7,
              RegSel => reg_a,
              RegVal => RegVal_0
         );
    MUX_8way_4bit_1 : MUX_8way_4bit
        port map (
           R0 => Out_0,
           R1 => Out_1,
           R2 => Out_2,
           R3 => Out_3,
           R4 => Out_4,
           R5 => Out_5,
           R6 => Out_6,
           R7 => Out_7,
           RegSel => reg_b,
           RegVal => RegVal_1
         );


-- For LED display
    zero_led <= '1' when (ALUVal = "0000") else '0';
    Reg7_led <= Out_7;

--For 7_seg
    Anode <= "1110";

end Behavioral;
