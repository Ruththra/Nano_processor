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
--   3-bit Ripple Carry Adder using only basic gates (no FA, HA, or built-in addition)
-- 
-- Dependencies: 
--   None.
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
        A : in  STD_LOGIC_VECTOR(2 downto 0);
        B : in  STD_LOGIC_VECTOR(2 downto 0);
        S : out STD_LOGIC_VECTOR(2 downto 0)
    );
end RCA_3;

architecture Behavioral of RCA_3 is
    signal c : STD_LOGIC_VECTOR(3 downto 0); -- c(0) is initial carry-in (0), c(3) is final carry-out
    begin
    c(0) <= '0';

    -- Bit 0
    S(0) <= A(0) xor B(0) xor c(0);
    c(1) <= (A(0) and B(0)) or (A(0) and c(0)) or (B(0) and c(0));

    -- Bit 1
    S(1) <= A(1) xor B(1) xor c(1);
    c(2) <= (A(1) and B(1)) or (A(1) and c(1)) or (B(1) and c(1));

    -- Bit 2
    S(2) <= A(2) xor B(2) xor c(2);
    c(3) <= (A(2) and B(2)) or (A(2) and c(2)) or (B(2) and c(2));

end Behavioral;
