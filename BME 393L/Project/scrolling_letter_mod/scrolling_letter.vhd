library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity scrolling_letter is port( 
	CLOCK_50_B5B: in std_logic;
	GPIO:			 out std_logic_vector(35 downto 0) ); 
end entity scrolling_letter; 

architecture main of scrolling_letter is 
	signal counter:    unsigned(24 downto 0);
	signal fast_clk:   std_logic; 
	signal slow_clk:   std_logic;
	signal row_driver: std_logic_vector(0 to 7);
	signal col_driver: std_logic_vector(0 to 7) := "01111111"; 
	signal letter:     std_logic_vector(0 to 63);
	signal index:      integer range 0 to 56;
	signal next_char:  std_logic_vector(0 to 47) := "011111001000001010001010100001000111101000000000";
	signal char_idx:   integer range 0 to 40;
	
begin 
	-- Extract clock signals
	process (CLOCK_50_B5B) begin
		if rising_edge(CLOCK_50_B5B) then
			counter <= counter + 1;
			fast_clk <= counter(14);
			slow_clk <= counter(24);
		end if;
	end process;
	
	-- Scroll through row index of the whole screen
	process (fast_clk) begin
		if rising_edge(fast_clk) then
			col_driver <= col_driver(7) & col_driver(0 to 6);
			if index = 56 then
				index <= 0;
			else
				index <= index + 8;
			end if;
		end if;
	end process;
	
	-- Assign 
	process (slow_clk) begin
		if rising_edge(slow_clk) then
			letter <= letter(8 to 63) & next_char(char_idx to char_idx+7);
			if char_idx = 40 then
				char_idx <= 0;
			else
				char_idx <= char_idx + 8;
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