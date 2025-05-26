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
use IEEE.NUMERIC_STD.ALL;

entity Nano_processor is
    Port ( 
           Reset : in STD_LOGIC;
           Program_mode : in STD_LOGIC; -- enabling program mode for program ROM
           new_instruction : in STD_LOGIC_VECTOR (12 downto 0);-- new instruction input
           load_instruction : in STD_LOGIC; -- load new instruction into ROM
           NextROM : in STD_LOGIC; -- next ROM trigger
           ROM_reset : in STD_LOGIC; -- reset signal for program ROM
           Reg_to_show : in STD_LOGIC_VECTOR (2 downto 0); -- register to show on 7-segment display
           clk : in STD_LOGIC;
           overflow_led : out STD_LOGIC;   
           zero_led : out STD_LOGIC;
           carry_led : out STD_LOGIC;
           reset_led : out STD_LOGIC;
           load_instruction_led : out STD_LOGIC;
           error_led : out STD_LOGIC;
           Reg_led : out std_logic_vector(3 downto 0);
           Seg7_digit : out std_logic_vector(6 downto 0);
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

-- Uncomment the following component declaration if using LUT_16_7
component LUT_16_7
    Port ( 
           address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0)
         );
end component;
component Program_Rom
    Port ( 
           address : in STD_LOGIC_VECTOR (2 downto 0);
           reset : in STD_LOGIC;
           input_instruction : in STD_LOGIC_VECTOR (12 downto 0);
           program_mode : in STD_LOGIC; -- 1 for program mode, 0 for data mode
           load : in STD_LOGIC; -- Load new instruction into ROM
           instruction : out STD_LOGIC_VECTOR (12 downto 0);
           clk : in STD_LOGIC; -- Clock signal
           p_signal : out STD_LOGIC; -- Program signal
           load_sig : out STD_LOGIC -- Load signal for external use
         );
end component;
component Instruction_decoder 
    Port ( 
           instruction : in STD_LOGIC_VECTOR (12 downto 0);
           val_MUX_0 : in std_logic_vector (3 downto 0);
           val_MUX_1 : in std_logic_vector (3 downto 0);
           reg_en : out STD_LOGIC_VECTOR (2 downto 0);
           load_sel : out STD_LOGIC;
           value : out STD_LOGIC_VECTOR (3 downto 0);
           reg_a : out STD_LOGIC_VECTOR (2 downto 0);
           reg_b : out STD_LOGIC_VECTOR (2 downto 0);
           addORsub : out STD_LOGIC;
           jump_flag : out STD_LOGIC;
           error : out STD_LOGIC;
           jump_address : out STD_LOGIC_VECTOR (2 downto 0)
         );
end component;
component RCA_3 
    Port ( 
           a0, a1, a2 : in STD_LOGIC; -- 3-bit input A
           b0, b1, b2 : in STD_LOGIC; -- 3-bit input B
           s0, s1, s2 : out STD_LOGIC -- 3-bit sum output
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
           a0, a1, a2, a3 : in STD_LOGIC; -- 4-bit input A
           b0, b1, b2, b3 : in STD_LOGIC; -- 4-bit input B
           mode : in STD_LOGIC;           -- Add/Subtract mode (0 for add, 1 for subtract)
           s0, s1, s2, s3 : out STD_LOGIC; -- 4-bit sum output
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
           reset_sig : out STD_LOGIC;            -- Reset signal for external use
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
           Stop : in STD_LOGIC;
           Clk_out : out STD_LOGIC
         );
end component;
component Program_mode_reg
    Port ( 
        En    : in  STD_LOGIC;
        Clk   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end component;


-- For Clock
signal slow_clock : STD_LOGIC;
--To stop the clock when in program mode
signal Program_mode_sync : std_logic := '0';
signal Program_mode_sync2 : std_logic := '0';
signal Program_trig : std_logic := '0';

--For Program Counter
signal RomEn : STD_LOGIC_VECTOR (2 downto 0);
signal Mux_out : STD_LOGIC_VECTOR (2 downto 0);
signal PC_clock : STD_LOGIC;

-- Signal to store the previous state of NextROM
signal NextROM_prev : std_logic := '0';
signal NextROM_pulse : std_logic := '0';

--For Instruction Decoder
signal instruction : STD_LOGIC_VECTOR (12 downto 0);
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
signal reset_led_sig : STD_LOGIC:='0';
signal Out_0, Out_1, Out_2, Out_3, Out_4, Out_5, Out_6, Out_7 : STD_LOGIC_VECTOR (3 downto 0);
-- signal reset_led_sig : STD_LOGIC;

--For 7_seg 
signal refresh_counter : std_logic_vector(15 downto 0) := (others => '0');
signal digit_select : std_logic_vector(1 downto 0) := "00"; -- cycles 0 to 3
signal Reg_showed : std_logic_vector(3 downto 0) ; -- register to show on 7-segment display
signal P_signal_in : std_logic; -- program signal from program ROM

-- signal anode : std_logic_vector(3 downto 0);
-- signal digits : std_logic_vector(15 downto 0) := (others => '0'); -- 4 digits = 4x4 bits
signal address_7 : std_logic_vector(3 downto 0);
signal data_7 : std_logic_vector(6 downto 0);
signal seg_out : std_logic_vector(6 downto 0);

--For Rom
signal load_instruction_sig : std_logic:='0';

begin

-------------------------------------------------------------------------------------------
--slow_clk_out <= slow_clock;  -- Add this line to expose slow_clock externally
-------------------------------------------------------------------------------------------

    -- Instantiate the components
    Slow_Clk_inst : Slow_Clk
        port map (
            Clk_in => clk,
            Stop => Program_mode_sync2, -- stop the clock when in program mode
            Reset => Reset,
            Clk_out => slow_clock
        );

    Program_counter_inst : Program_counter
        port map (
            Mux_out => Mux_out,
            Clk => PC_clock, --If NextROM is high, the clock will be used to update the program counter
            Res => Reset,
            Q => RomEn
        );


-- 7 segmentation function added
    LUT_16_7_inst : LUT_16_7
        port map (
            address => address_7,
            data => data_7
        );

    Program_Rom_inst : Program_Rom
        port map (
            clk => clk, -- connect the clock
            address => RomEn,
            reset => ROM_reset,
            input_instruction => new_instruction,
            program_mode => Program_mode_sync2,
            load => load_instruction,
            instruction => instruction,
            p_signal => P_signal_in,
            load_sig => load_instruction_sig
        );

    Instruction_decoder_inst : Instruction_decoder
        port map (
            instruction => instruction,
            val_MUX_0 => RegVal_0,
            val_MUX_1 => RegVal_1,
            reg_en => reg_en,
            load_sel => load_sel,
            value => value,
            reg_a => reg_a,
            reg_b => reg_b,
            addORsub => addORsub,
            jump_flag => jump_flag,
            error => error_led,
            jump_address => jump_address
        );

    RCA_3_inst : RCA_3 
        port map (
            a0 => RomEn(0),
            a1 => RomEn(1),
            a2 => RomEn(2),
            b0 => '1',
            b1 => '0',
            b2 => '0', 
            s0 => Nxt_pc(0),
            s1 => Nxt_pc(1),
            s2 => Nxt_pc(2) 
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
              a0 => RegVal_0(0),
              a1 => RegVal_0(1), 
              a2 => RegVal_0(2),
              a3 => RegVal_0(3),
              b0 => RegVal_1(0),
              b1 => RegVal_1(1),
              b2 => RegVal_1(2),
              b3 => RegVal_1(3),
              mode => addORsub,
              s0 => ALUVal(0),
              s1 => ALUVal(1),
              s2 => ALUVal(2),
              s3 => ALUVal(3),
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
           Out_7 => Out_7,
           reset_sig => reset_led_sig
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

    Program_mode_reg_inst : Program_mode_reg
        port map (
            En => Program_mode,
            Clk => clk,
            Q => Program_trig
        );
--


-- Reset led
    reset_led <= reset_led_sig;

-- Process to synchronize the Program_mode signal
    process(clk)
    begin
        if rising_edge(clk) then
            Program_mode_sync <= Program_trig;
            Program_mode_sync2 <= Program_mode_sync;
        end if;
    end process;

-- Process to generate a clock pulse on the rising edge of NextROM
    process(clk)
    begin
        if rising_edge(clk) then
            -- Detect rising edge of NextROM
            if NextROM = '1' and NextROM_prev = '0' then
                NextROM_pulse <= '1'; -- Generate a pulse
            else
                NextROM_pulse <= '0'; -- Default state
            end if;

            -- Update the previous state of NextROM
            NextROM_prev <= NextROM;
        end if;
    end process;

--PC clock fix
    PC_clock <= slow_clock or NextROM_pulse;

-- For LED display
    zero_led <= '1' when (ALUVal = "0000") else '0';
    Reg_led <= Reg_showed;


--For Load instruction led
load_instruction_led <= load_instruction_sig;

--For 7_seg

    process(clk)
    begin
        if rising_edge(clk) then
            refresh_counter <= std_logic_vector(unsigned(refresh_counter) + 1);

            if refresh_counter = X"FFFF" then
                digit_select <= std_logic_vector(unsigned(digit_select) + 1);
            end if;
        end if;
    end process;

    -- Display the selected register on the 7-segment display
    process(Reg_to_show)
    begin
        case Reg_to_show is
            when "000" => Reg_showed <= Out_0; -- Display Reg0
            when "001" => Reg_showed <= Out_1; -- Display Reg1
            when "010" => Reg_showed <= Out_2; -- Display Reg2
            when "011" => Reg_showed <= Out_3; -- Display Reg3
            when "100" => Reg_showed <= Out_4; -- Display Reg4
            when "101" => Reg_showed <= Out_5; -- Display Reg5
            when "110" => Reg_showed <= Out_6; -- Display Reg6
            when others => Reg_showed <= Out_7; -- Display Reg7
        end case;
    end process;

    process(digit_select, P_signal_in, Reg_showed, data_7, RomEn)
    begin
        case digit_select is
            when "00" =>
                address_7 <= Reg_showed;
                seg_out <= data_7;
                Anode <= "1110";
            when "10" =>
                if P_signal_in = '1' then
                    seg_out <= "0001100"; -- "P"
                    Anode <= "1011";
                else 
                    Anode <= "1111";
                end if;
            when "11" =>
                address_7 <= ('0' & RomEn);
                seg_out <= data_7;
                Anode <= "0111";
            when others =>
                seg_out <= (others => '1');
                Anode <= "1111";
        end case;
    end process;

    -- Output ports
    Seg7_digit <= seg_out;




end Behavioral;
