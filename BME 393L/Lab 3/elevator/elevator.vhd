library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elevator is
port(	SW: 	in  std_logic_vector(9 downto 0);		
		LEDR: out std_logic_vector(4 downto 0);
		LEDG: out std_logic_vector(4 downto 0)
		);
end entity elevator;

architecture main of elevator is
	
signal enable: 	std_logic;
signal direction: std_logic;
signal or1, or2, or3, xor1, xor2: std_logic; 
signal a, b, x, y: std_logic;

begin
	a <= SW(9);
	b <= SW(8);
	x <= SW(1);
	y <= SW(0);
	
	or1 <= a OR b;
	or2 <= x OR y;
	xor1 <= a XOR x;
	xor2 <= b XOR y;
	or3 <= xor1 OR xor2;
	enable <= or1 AND or2 AND or3;
	
	direction <= NOT a OR (x and y);
	
	LEDR(0) <= enable;
	LEDG(0) <= direction;
end architecture;
