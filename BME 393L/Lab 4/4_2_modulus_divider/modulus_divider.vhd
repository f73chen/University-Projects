library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulus_divider is port(
	CLOCK_50_B5B: in std_logic;
	LEDG:	       out std_logic_vector(9 downto 0) 
	);
end entity modulus_divider;

architecture main of modulus_divider is
	signal clock_1_Hz: std_logic;
	signal counter: unsigned(24 downto 0);

begin
	divider: process (CLOCK_50_B5B)
	begin
		if rising_edge(CLOCK_50_B5B) then
			if counter = to_unsigned(24999999, 25) then
				counter <= to_unsigned(0, 25);
				clock_1_Hz <= not clock_1_Hz;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	LEDG(5) <= clock_1_Hz;
end architecture;