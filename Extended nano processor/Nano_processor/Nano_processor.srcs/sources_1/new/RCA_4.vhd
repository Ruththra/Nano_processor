----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2025 05:01:10
-- Design Name: 
-- Module Name: RCA_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 4-bit Ripple Carry Adder using full adders.
--   It supports both addition and subtraction based on the mode input.
-- 
-- Dependencies: 
--   Requires an FA (Full Adder) component.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_4 is
    Port ( 
           a0, a1, a2, a3 : in STD_LOGIC; -- 4-bit input A
           b0, b1, b2, b3 : in STD_LOGIC; -- 4-bit input B
           mode : in STD_LOGIC;           -- Add/Subtract mode (0 for add, 1 for subtract)
           s0, s1, s2, s3 : out STD_LOGIC; -- 4-bit sum output
           c_out : out STD_LOGIC;          -- Carry-out
           overflow : out STD_LOGIC        -- Overflow flag
         );
end RCA_4;

architecture Behavioral of RCA_4 is

    -- Component declaration for the Full Adder
    component FA
        Port ( 
               A : in STD_LOGIC;
               B : in STD_LOGIC;
               C_in : in STD_LOGIC;
               S : out STD_LOGIC;
               C_out : out STD_LOGIC
             );
    end component;

    -- Internal signals for carry propagation
    SIGNAL FA0_C, FA1_C, FA2_C : STD_LOGIC;
    signal b0_m, b1_m, b2_m, b3_m : std_logic;
    signal c_out_internal : std_logic;



begin

    -- FA_0: Full adder for the least significant bit
    FA_0 : FA
        port map (
            A => A0,
            B => b0_m, -- XOR with mode for subtraction
            C_in => mode, -- Carry-in is mode for subtraction
            S => S0,
            C_Out => FA0_C
        );

    -- FA_1: Full adder for the second bit
    FA_1 : FA
        port map (
            A => A1,
            B => b1_m, -- XOR with mode for subtraction
            C_in => FA0_C,
            S => S1,
            C_Out => FA1_C
        );

    -- FA_2: Full adder for the third bit
    FA_2 : FA
        port map (
            A => A2,
            B => b2_m, -- XOR with mode for subtraction
            C_in => FA1_C,
            S => S2,
            C_Out => FA2_C
        );

    -- FA_3: Full adder for the most significant bit
    FA_3 : FA
        port map (
            A => A3,
            B => b3_m, -- XOR with mode for subtraction
            C_in => FA2_C,
            S => S3,
            C_Out => c_out_internal
        );

    -- Overflow detection: Check if the carry-in and carry-out of the MSB are different
    c_out <= c_out_internal;
    overflow <= FA2_C xor c_out_internal;

    
    -- For mode selection
    b0_m <= b0 xor mode;
    b1_m <= b1 xor mode;
    b2_m <= b2 xor mode;
    b3_m <= b3 xor mode;

end Behavioral;
