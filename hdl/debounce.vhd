library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
	Generic ( clock_frequency : integer; --Clock frequency in Hertz
	          settling_time : time); --Maximum signal settling time
	Port ( clk : in std_logic;
	       input : in std_logic;
	       output : out std_logic;
			 change : out std_logic);
end debounce;

architecture Behavioral of debounce is
	constant clock_period : time := (1.0/Real(clock_frequency)) * 1 sec;
	constant max_count : integer := settling_time/clock_period;
	signal output_buf : std_logic; -- Allow readback of output
	signal counter : integer range 0 to max_count;
begin

	output <= output_buf;


	process(clk)
	begin
		if rising_edge(clk) then
			change <= '0';
			if input /= output_buf then
				if counter = max_count then
					output_buf <= input;
					change <= '1';
				else
					counter <= counter + 1;
				end if;
			else
				counter <= 0;
			end if;
		end if;
	end process;


end Behavioral;

