----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2025 01:38:47 PM
-- Design Name: 
-- Module Name: Decoder_3_to_8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   This module implements a 3-to-8 decoder using two 2-to-4 decoders.
-- 
-- Dependencies: 
--   Requires a Decoder_2_to_4 component.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_3_to_8 is
    Port ( 
           I : in STD_LOGIC_VECTOR (2 downto 0);                  
           Y : out STD_LOGIC_VECTOR (7 downto 0) 
         );
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is
    -- Component declaration for the 2-to-4 decoder
    component Decoder_2_to_4
    port(
        I: in STD_LOGIC_VECTOR (1 downto 0); 
        EN: in STD_LOGIC;
        Y: out STD_LOGIC_VECTOR (3 downto 0) 
    );
    end component;

    -- Internal signals
    signal I0, I1 : STD_LOGIC_VECTOR (1 downto 0); 
    signal Y0, Y1 : STD_LOGIC_VECTOR (3 downto 0); 
    signal en0 : STD_LOGIC:='1';
    signal en1 : STD_LOGIC:='1';        
    signal En : STD_LOGIC:='1';  -- Default enable signal

begin
    -- Instantiate the first 2-to-4 decoder
    Decoder_2_to_4_0 : Decoder_2_to_4
    port map(
        I => I0,
        EN => en0,
        Y => Y0
    );

    -- Instantiate the second 2-to-4 decoder
    Decoder_2_to_4_1 : Decoder_2_to_4
    port map(
        I => I1,
        EN => en1,
        Y => Y1
    );

    -- Enable signals for the two decoders
    en0 <= NOT(I(2)) AND EN; -- Enable lower 4 outputs when I(2) = 0
    en1 <= I(2) AND EN;      -- Enable upper 4 outputs when I(2) = 1

    -- Assign the lower 2 bits of the input to both decoders
    I0 <= I(1 downto 0);
    I1 <= I(1 downto 0);

    -- Combine the outputs of the two decoders
    Y(3 downto 0) <= Y0; -- Lower 4 outputs
    Y(7 downto 4) <= Y1; -- Upper 4 outputs

end Behavioral;