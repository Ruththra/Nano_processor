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
--   4-bit Ripple Carry Adder/Subtractor without FA components.
-- 
-- Dependencies: 
--   None
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
           A : in STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input A
           B : in STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input B
           mode : in STD_LOGIC;           -- Add/Subtract mode (0 for add, 1 for subtract)
           S : out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit sum output
           c_out : out STD_LOGIC;          -- Carry-out
           overflow : out STD_LOGIC        -- Overflow flag
         );
end RCA_4;

architecture Behavioral of RCA_4 is

    signal b_m : STD_LOGIC_VECTOR(3 downto 0);
    signal c : STD_LOGIC_VECTOR(4 downto 0); -- c(0) is initial carry-in, c(4) is final carry-out

    begin

    -- Mode selection: XOR B with mode for subtraction
    b_m(0) <= B(0) xor mode;
    b_m(1) <= B(1) xor mode;
    b_m(2) <= B(2) xor mode;
    b_m(3) <= B(3) xor mode;

    -- Initial carry-in is mode (0 for add, 1 for subtract)
    c(0) <= mode;

    -- Full adder logic for each bit
    S(0) <= A(0) xor b_m(0) xor c(0);
    c(1) <= (A(0) and b_m(0)) or (A(0) and c(0)) or (b_m(0) and c(0));

    S(1) <= A(1) xor b_m(1) xor c(1);
    c(2) <= (A(1) and b_m(1)) or (A(1) and c(1)) or (b_m(1) and c(1));

    S(2) <= A(2) xor b_m(2) xor c(2);
    c(3) <= (A(2) and b_m(2)) or (A(2) and c(2)) or (b_m(2) and c(2));

    S(3) <= A(3) xor b_m(3) xor c(3);
    c(4) <= (A(3) and b_m(3)) or (A(3) and c(3)) or (b_m(3) and c(3));

    -- Carry-out and overflow
    c_out <= c(4);
    overflow <= c(3) xor c(4);

end Behavioral;
