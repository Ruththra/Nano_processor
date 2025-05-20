----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2025 05:03:13
-- Design Name: 
-- Module Name: Reg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 4-bit register with an enable signal and reset.
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

entity Reg_bank_8 is
    Port ( 
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;                  -- Clock signal
           Reset : in STD_LOGIC;                -- Reset signal
        --    reset_sig : out STD_LOGIC;            -- Reset signal for external use
           Input: in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit input data
           Out_0, Out_1, Out_2, Out_3, Out_4, Out_5, Out_6, Out_7 : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit output data
         );
end Reg_bank_8;

architecture Behavioral of Reg_bank_8 is

component Reg
    Port ( 
           D : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit input data
           En : in STD_LOGIC;                   -- Enable signal
           Clk : in STD_LOGIC;                  -- Clock signal
           Reset : in STD_LOGIC;                -- Reset signal
        --    reset_sig : out STD_LOGIC;            -- Reset signal for external use
           Q : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit output data
         );
end component;
component Decoder_3_to_8
    Port ( 
           I : in STD_LOGIC_VECTOR (2 downto 0);                  
           Y : out STD_LOGIC_VECTOR (7 downto 0) 
         );
end component;
-- Internal signals
signal RegEn : STD_LOGIC_VECTOR (7 downto 0); -- Enable signals for registers

begin
--Instantiate the 3-to-8 decoder
Decoder_3_to_8_0 : Decoder_3_to_8
    port map(
        I => RegSel,
        Y => RegEn
    );
-- Instantiate the registers
Reg_0 : Reg
    port map(
        D => "0000",
        En => RegEn(0),
        Clk => Clk,
        Reset => Reset,
        Q => Out_0
        -- reset_sig => reset_sig
    );
Reg_1 : Reg
    port map(
        D => Input,
        En => RegEn(1),
        Clk => Clk,
        Reset => Reset,
        Q => Out_1
        -- reset_sig => reset_sig
    );
Reg_2 : Reg
    port map(
        D => Input,
        En => RegEn(2),
        Clk => Clk,
        Reset => Reset,
        Q => Out_2
        -- reset_sig => reset_sig
    );
Reg_3 : Reg
    port map(
        D => Input,
        En => RegEn(3),
        Clk => Clk,
        Reset => Reset,
        Q => Out_3
        -- reset_sig => reset_sig
    );
Reg_4 : Reg
    port map(
        D => Input,
        En => RegEn(4),
        Clk => Clk,
        Reset => Reset,
        Q => Out_4
        -- reset_sig => reset_sig
    );
Reg_5 : Reg
    port map(
        D => Input,
        En => RegEn(5),
        Clk => Clk,
        Reset => Reset,
        Q => Out_5
        -- reset_sig => reset_sig
    );
Reg_6 : Reg
    port map(
        D => Input,
        En => RegEn(6),
        Clk => Clk,
        Reset => Reset,
        Q => Out_6
        -- reset_sig => reset_sig
    );
Reg_7 : Reg
    port map(
        D => Input,
        En => RegEn(7),
        Clk => Clk,
        Reset => Reset,
        Q => Out_7
        -- reset_sig => reset_sig
    );


end Behavioral;
