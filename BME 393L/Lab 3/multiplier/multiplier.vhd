library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity four_bit is
port(	num1: in  std_logic_vector(3 downto 0);
		num2: in  std_logic_vector(3 downto 0);
		cout: out std_logic_vector(4 downto 0) );
end entity four_bit;

architecture main of four_bit is
begin
	cout <= ('0' & num1) + ('0' & num2);
end architecture main;



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplier is
port(	SW: in  std_logic_vector(9 downto 0));
end entity multiplier;

architecture main of multiplier is
	component four_bit is port(
		num1: in  std_logic_vector(3 downto 0);
		num2: in  std_logic_vector(3 downto 0);
		cout: out std_logic_vector(4 downto 0) );
	end component;
	
signal a: std_logic_vector(3 downto 0);
signal b: std_logic_vector(3 downto 0);

begin
	a <= SW(9 downto 6);
	b <= SW(3 downto 0);
end architecture;
