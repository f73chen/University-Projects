library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dot_scrolling is port( 
	CLOCK_50_B5B: in std_logic;
	GPIO:			 out std_logic_vector(35 downto 0) ); 
end entity dot_scrolling; 

Architecture main of dot_scrolling is 
	signal counter:        unsigned(21 downto 0); 
	signal scroll_counter: unsigned(2 downto 0);
	signal hz10:           std_logic;
	signal row_driver:     std_logic_vector(0 to 7) := "10000000"; 
	signal col_driver:     std_logic_vector(0 to 7) := "01111111"; 
	
begin 
	-- Extract a 10 Hz signal
	process (CLOCK_50_B5B) begin
		if counter = to_unsigned(2499999, 22) then
			counter <= to_unsigned(0, 22);
			hz10 <= not hz10;
		else
			counter <= counter + 1;
		end if;
	end process;
	
	-- Dot scrolling
	process (hz10) begin
		if rising_edge(hz10) then
			col_driver <= col_driver(7) & col_driver(0 to 6);
			if scroll_counter = "111" then
				scroll_counter <= "000";
				row_driver <= row_driver(7) & row_driver(0 to 6);
			else
				scroll_counter <= scroll_counter + 1;
			end if;
		end if;
	end process;

	GPIO( 1) <= row_driver(0);
	GPIO( 3) <= row_driver(1); 
	GPIO( 5) <= row_driver(2); 
	GPIO( 7) <= row_driver(3); 
	GPIO( 9) <= row_driver(4); 
	GPIO(11) <= row_driver(5); 
	GPIO(13) <= row_driver(6); 
	GPIO(15) <= row_driver(7); 

	GPIO(21) <= col_driver(0); 
	GPIO(23) <= col_driver(1); 
	GPIO(25) <= col_driver(2); 
	GPIO(27) <= col_driver(3); 
	GPIO(29) <= col_driver(4); 
	GPIO(31) <= col_driver(5); 
	GPIO(33) <= col_driver(6); 
	GPIO(35) <= col_driver(7);
end architecture; 