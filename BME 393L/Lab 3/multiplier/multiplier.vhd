library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity four_bit is
port(	a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		c: out std_logic_vector(4 downto 0) );
end entity four_bit;

architecture main of four_bit is
begin
	c <= ('0' & a) + ('0' & b);
end architecture;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
port(	SW: in  std_logic_vector(9 downto 0);
		LEDG: out std_logic_vector(7 downto 0)
		);
end entity multiplier;

architecture main of multiplier is
	component four_bit is port(
		a: in  std_logic_vector(3 downto 0);
		b: in  std_logic_vector(3 downto 0);
		c: out std_logic_vector(4 downto 0) );
	end component;
	
signal num1: std_logic_vector(3 downto 0);
signal num2: std_logic_vector(3 downto 0);
signal and0, and1, and2, and3: std_logic_vector(3 downto 0);
signal c0, c1, c2: std_logic_vector(4 downto 0);
signal out1, out2, out3: std_logic;

begin
	num1 <= SW(9 downto 6);
	num2 <= SW(3 downto 0);
	
	out1 <= num1(0) and num2(0);
	and0 <= '0' & (num1(3) and num2(0)) & (num1(2) and num2(0)) & (num1(1) and num2(0));
	and1 <= (num1(3) and num2(1)) & (num1(2) and num2(1)) & (num1(1) and num2(1)) & (num1(0) and num2(1));
	adder1: entity work.four_bit(main) port map(and0, and1, c0);
	
	out2 <= c0(0);
	and2 <= (num1(3) and num2(2)) & (num1(2) and num2(2)) & (num1(1) and num2(2)) & (num1(0) and num2(2));
	adder2: entity work.four_bit(main) port map(c0(4 downto 1), and2, c1);
	
	out3 <= c1(0);
	and3 <= (num1(3) and num2(3)) & (num1(2) and num2(3)) & (num1(1) and num2(3)) & (num1(0) and num2(3));
	adder3: entity work.four_bit(main) port map(c1(4 downto 1), and3, c2);

	LEDG(7 downto 0) <= c2(4 downto 0) & out3 & out2 & out1;
end architecture;
