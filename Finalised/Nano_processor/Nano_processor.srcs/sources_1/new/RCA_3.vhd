----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2025 05:01:10
-- Design Name: 
-- Module Name: RCA_3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 4-bit Ripple Carry Adder using full adders.
--   It supports both addition and subtraction based on input.
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

entity RCA_3 is
    Port ( 
           a0, a1, a2 : in STD_LOGIC; -- 3-bit input A
           b0, b1, b2 : in STD_LOGIC; -- 3-bit input B
           s0, s1, s2 : out STD_LOGIC -- 3-bit sum output
         );
end RCA_3;

architecture Behavioral of RCA_3 is

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
    SIGNAL FA0_C, FA1_C, c_out : STD_LOGIC;

begin

    -- FA_0: Full adder for the least significant bit
    FA_0 : FA
        port map (
            A => A0,
            B => B0,
            C_in => '0', 
            S => S0,
            C_Out => FA0_C
        );

    -- FA_1: Full adder for the second bit
    FA_1 : FA
        port map (
            A => A1,
            B => B1,
            C_in => FA0_C,
            S => S1,
            C_Out => FA1_C
        );

    -- FA_2: Full adder for the third bit
    FA_2 : FA
        port map (
            A => A2,
            B => B2,
            C_in => FA1_C,
            S => S2,
            C_Out => c_out
        );



end Behavioral;
