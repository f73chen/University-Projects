library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity four_bit is
port(	SW: 	in std_logic_vector(9 downto 0);
		LEDG: out std_logic_vector(4 downto 0)
		);
end entity four_bit;

architecture main of four_bit is

signal a: std_logic_vector(3 downto 0);
signal b: std_logic_vector(9 downto 6);
signal c: std_logic_vector(4 downto 0);

begin

a <= SW(3 downto 0);
b <= SW(9 downto 6);
c <= ('0' & a) + ('0' & b);
LEDG(4 downto 0) <= std_logic_vector(c);

end architecture main;
