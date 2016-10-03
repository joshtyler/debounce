LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY debounce_test IS
END debounce_test;
 
ARCHITECTURE behavior OF debounce_test IS
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debounce
	Generic ( clock_frequency : integer; --Clock frequency in Hertz
	          settling_time : time); --Maximum signal settling time
    PORT(
			clk : IN std_logic;
         input : IN  std_logic;
         output : OUT  std_logic;
         change : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal output : std_logic;
	signal change : std_logic;

   -- Clock period definitions
	constant clock_frequency : integer := 40_000_000;
   constant clk_period : time := (1.0/Real(clock_frequency)) * 1 sec;
	
	--Setting time
	constant settling_time : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: debounce
		GENERIC MAP (
			clock_frequency => clock_frequency,
			settling_time => settling_time
		)
		PORT MAP (
			clk => clk,
			input => input,
			output => output,
			change => change
		);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 5ms;
		input <= '1';
		wait for 0.1ms;
		input <= '0';
		wait for 0.2ms;
		input <= '1';
		wait for 0.9ms;
		input <= '0';
		wait for 0.9ms;
		input <= '1';
		wait for 1.1ms;
		
		
		wait for 5ms;
		input <= '0';
		wait for 0.1ms;
		input <= '1';
		wait for 0.1ms;
		input <= '0';
		wait for 0.2ms;
		input <= '1';
		wait for 0.9ms;
		input <= '0';
		wait for 5ms;
		
		assert false report "Simulation Ended" severity failure;

      wait;
   end process;

END;
