-- This program blinks all LEDs on an 8x8 LED Dot Matrix Display 
-- Written by Rasoul Keshavarzi, Winter 2022 term 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALL_LEDs_flashing is 
	port( 
			CLOCK_50_B5B:	in  std_logic ;    -- 50MHz clock on the board 
			GPIO:			out std_logic_vector(35 downto 0)
		); 
end entity ALL_LEDs_flashing; 

Architecture main of ALL_LEDs_flashing is 
signal counter: unsigned(24 downto 0); 
signal row_driver: std_logic_vector(0 to 7); 
signal col_driver: std_logic_vector(0 to 7) := "01111111"; 
begin 
counter <= counter + 1 when rising_edge(clock_50_B5B); 
row_driver <= "11111111" when std_logic(counter(24)) = '1' else "00000000"; 
col_driver <= "00000000"; 

GPIO( 1) <= row_driver(0); 	-- Pin connections between GPIO port and the PCB 
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
end architecture main; 
