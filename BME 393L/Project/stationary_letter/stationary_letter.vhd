library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stationary_letter is port( 
	CLOCK_50_B5B: in std_logic;
	GPIO:			 out std_logic_vector(35 downto 0) ); 
end entity stationary_letter; 

Architecture main of stationary_letter is 
	signal counter:    unsigned(14 downto 0);
	signal index:      integer range 0 to 56 := 0;
	signal hz1k:       std_logic;
	signal row_driver: std_logic_vector(0 to 7);
	signal col_driver: std_logic_vector(0 to 7) := "01111111"; 
	constant letter:   std_logic_vector(0 to 63) := "0111110010000010100010101000010001111010000000000000000000000000";
	
begin 
	-- Extract a 100 Hz signal
	process (CLOCK_50_B5B) begin
		if rising_edge(CLOCK_50_B5B) then
			if counter = to_unsigned(24999, 15) then
				counter <= to_unsigned(0, 15);
				hz1k <= not hz1k;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	-- Scroll through row
	process (hz1k) begin
		if rising_edge(hz1k) then
			col_driver <= col_driver(7) & col_driver(0 to 6);
			if index = 56 then
				index <= 0;
			else
				index <= index + 8;
			end if;
		end if;
	end process;
	
	row_driver <= letter(index to index+7);

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