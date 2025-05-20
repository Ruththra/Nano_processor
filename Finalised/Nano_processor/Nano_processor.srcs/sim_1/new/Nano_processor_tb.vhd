library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Nano_processor_tb is
end Nano_processor_tb;

architecture Behavioral of Nano_processor_tb is

    -- Component Declaration
    component Nano_processor
        Port (
            Reset : in STD_LOGIC;
            Program_mode : in STD_LOGIC;
            new_instruction : in STD_LOGIC_VECTOR (11 downto 0);
            load_instruction : in STD_LOGIC;
            NextROM : in STD_LOGIC;
            clk : in STD_LOGIC;
            overflow_led : out STD_LOGIC;
            zero_led : out STD_LOGIC;
            carry_led : out STD_LOGIC;
            Reg7_led : out STD_LOGIC_VECTOR(3 downto 0);
            Seg7_digit : out STD_LOGIC_VECTOR(6 downto 0);
            Anode : out STD_LOGIC_VECTOR(3 downto 0)
            
--             slow_clk_out : out std_logic   -- <---- Add this line
        );
    end component;

    -- Testbench Signals
    signal clk_tb             : STD_LOGIC := '0';
    signal Reset_tb           : STD_LOGIC := '0';
    signal Program_mode_tb    : STD_LOGIC := '0';
    signal new_instruction_tb : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
    signal load_instruction_tb: STD_LOGIC := '0';
    signal NextROM_tb         : STD_LOGIC := '0';
    signal overflow_led_tb    : STD_LOGIC;
    signal zero_led_tb        : STD_LOGIC;
    signal carry_led_tb       : STD_LOGIC;
    signal Reg7_led_tb        : STD_LOGIC_VECTOR(3 downto 0);
    signal Seg7_digit_tb      : STD_LOGIC_VECTOR(6 downto 0);
    signal Anode_tb           : STD_LOGIC_VECTOR(3 downto 0);
    
--    signal slow_clk_tb : std_logic;


--    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Nano Processor
    UUT: Nano_processor
        port map (
            Reset => Reset_tb,
            Program_mode => Program_mode_tb,
            new_instruction => new_instruction_tb,
            load_instruction => load_instruction_tb,
            NextROM => NextROM_tb,
            clk => clk_tb,
            overflow_led => overflow_led_tb,
            zero_led => zero_led_tb,
            carry_led => carry_led_tb,
            Reg7_led => Reg7_led_tb,
            Seg7_digit => Seg7_digit_tb,
            Anode => Anode_tb
            
--            slow_clk_out => slow_clk_tb  -- connect slow clock here
        );

    -- Clock Process
--    clk_process : process
--    begin
--        while now < 2 ms loop
--            clk_tb <= '0';
--            wait for clk_period / 2;
--            clk_tb <= '1';
--            wait for clk_period / 2;
--        end loop;
--        wait;
--    end process;


process begin
clk_tb<='0';
wait for 5ns;
clk_tb<='1';
wait for 5ns;
end process;

process begin
Reset_tb<='1';
wait for 110ns;
Reset_tb<='0';
wait;
end process;


--    -- Stimulus Process
--    process
--    begin
    
--        -- Reset
--        Reset_tb <= '1';
--        wait for 50 ns;
--        Reset_tb <= '0';

--        -- Program Mode ON
--        Program_mode_tb <= '1';

--        -- Load a few instructions
--        -- Format: opcode_reg1_reg2/immed
--        -- MOVI R1, 4
--        new_instruction_tb <= "100010000100"; -- 100 = MOVI, 010 = R1, 000100 = 4
--        load_instruction_tb <= '1';
--        wait for clk_period;
--        load_instruction_tb <= '0';

--        NextROM_tb <= '1';
--        wait for clk_period;
--        NextROM_tb <= '0';

--        -- MOVI R2, 3
--        new_instruction_tb <= "100100000011"; -- 100 = MOVI, 100 = R2, 000011 = 3
--        load_instruction_tb <= '1';
--        wait for clk_period;
--        load_instruction_tb <= '0';

--        NextROM_tb <= '1';
--        wait for clk_period;
--        NextROM_tb <= '0';

--        -- ADD R1, R2
--        new_instruction_tb <= "000010100100"; -- 000 = ADD, 010 = R1, 100 = R2
--        load_instruction_tb <= '1';
--        wait for clk_period;
--        load_instruction_tb <= '0';

--        NextROM_tb <= '1';
--        wait for clk_period;
--        NextROM_tb <= '0';

--        -- Program Mode OFF
--        Program_mode_tb <= '0';

--        -- Allow execution to proceed
--        wait for 2 us;

--        -- Finish simulation
--        wait;
--    end process;

end Behavioral;
