library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Lab4_Prelab is port(
	CLOCK_50_B5B: in std_logic;
	LEDG:	       out std_logic_vector(7 downto 0) 
	);
end entity Lab4_Prelab;

architecture main of Lab4_Prelab is
	signal clock_1_Hz: std_logic;
	signal counter: integer := 0;

begin
	divider: process (CLOCK_50_B5B)
	begin
		if rising_edge(CLOCK_50_B5B) then
			if counter = 24999999 then
				counter <= 0;
				clock_1_Hz <= not clock_1_Hz;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	LEDG(0) <= clock_1_Hz;
end architecture;