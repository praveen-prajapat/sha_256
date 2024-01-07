library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity testbench is
end entity;

architecture sim of testbench is
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal enable : std_logic := '0';
    signal done : std_logic;
    signal hash_out : std_logic_vector(255 downto 0);
    
    constant clock_period : time := 20 ms;  -- Clock period for 50 Hz
	 
	 component controller is
  		
		 port(clk: in std_logic; 
				reset: in std_logic;
				enable: in std_logic;
				done: out std_logic;
				hash_out: out std_logic_vector(255 downto 0));
		 
	end component;
begin

    -- Instantiate the controller
    UUT : controller port map (
            clk => clk,
            reset => reset,
            enable => enable,
            done => done,
            hash_out => hash_out
        );

    -- Clock process
    clk_process: process
    begin
        while now < 50000 ms loop  -- Simulate for 1000 ms
            clk <= not clk;
            wait for clock_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize inputs
        reset <= '1';
        enable <= '1';

        wait for 5 ms;  -- Wait for 10 ms

        reset <= '0';
        enable <= '1';

        wait for 50000 ms;  -- Keep enable high for 500 ms

        enable <= '0';  -- Disable
        wait;

    end process;

end sim;
