library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity scrolling_letter is port( 
	CLOCK_50_B5B: in std_logic;
	GPIO:			 out std_logic_vector(35 downto 0) ); 
end entity scrolling_letter; 

Architecture main of scrolling_letter is 
	signal counter:            unsigned(24 downto 0);
	signal fast, slow, index: integer range 0 to 56 := 0;
	signal fast_clk, slow_clk: std_logic;
	signal row_driver:        std_logic_vector(0 to 7);
	signal col_driver:        std_logic_vector(0 to 7) := "01111111"; 
	signal letter:            std_logic_vector(0 to 63) := "0111110010000010100010101000010001111010000000000000000000000000";
	
begin 
	-- Extract clock signals
	process (CLOCK_50_B5B) begin
		if rising_edge(CLOCK_50_B5B) then
			counter <= counter + 1;
			fast_clk <= counter(14);
			slow_clk <= counter(24);
		end if;
	end process;
	
	-- Scroll through row
	process (fast_clk) begin
		if rising_edge(fast_clk) then
			col_driver <= col_driver(7) & col_driver(0 to 6);
			if fast = 56 then
				fast <= 0;
			else
				fast <= fast + 8;
			end if;
			
			index <= (fast + slow) mod 64;
		end if;
	end process;
	
	-- Move the letter to the left
	-- In the full code, append the next character instead of letter(0 to 7)
	process (slow_clk) begin
		if rising_edge(slow_clk) then
			if slow = 56 then
				slow <= 0;
			else
				slow <= slow + 8;
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