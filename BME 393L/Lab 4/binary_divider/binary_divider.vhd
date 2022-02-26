library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_divider is port(
	CLOCK_50_B5B: in std_logic;
	LEDR:	       out std_logic_vector(9 downto 0) 
	);
end entity binary_divider;

architecture main of binary_divider is
	signal counter: unsigned(29 downto 0);

begin
	counter <= counter + 1 when rising_edge(CLOCK_50_B5B);
	LEDR(9 downto 0) <= std_logic_vector(counter(29 downto 20));
end architecture;