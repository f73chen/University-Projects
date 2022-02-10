library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity four_bit is
port(	a1: in std_logic_vector(3 downto 0);
		a2: in std_logic_vector(3 downto 0);
		b:  in std_logic;
		cout: out std_logic_vector(4 downto 0) );
end entity four_bit;

architecture main of four_bit is
signal new_a1: std_logic_vector(3 downto 0);
begin
	new_a1(0) <= a1(0) and b;
	new_a1(1) <= a1(1) and b;
	new_a1(2) <= a1(2) and b;
	new_a1(3) <= a1(3) and b;
	cout <= ('0' & new_a1) + ('0' & a2);
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
		num1: in  std_logic_vector(3 downto 0);
		num2: in  std_logic_vector(3 downto 0);
		band: in  std_logic;
		cout: out std_logic_vector(4 downto 0) );
	end component;
	
signal a: std_logic_vector(3 downto 0);
signal ap1, ap2, ap3: std_logic_vector(3 downto 0);
signal b: std_logic_vector(3 downto 0);
signal c1, c2, c3, c4: std_logic_vector(4 downto 0);

signal least1, least2, least3: std_logic;

begin
	a <= SW(9 downto 6);
	b <= SW(3 downto 0);
	
	adder0: entity work.four_bit(main) port map(a, "0000", b(0), c1);
	least1 <= a(0);
	ap1 <= c1(4 downto 1);
	
	adder1: entity work.four_bit(main) port map(a, ap1, b(1), c2);
	least2 <= c2(0);
	ap2 <= c2(4 downto 1);
	
	adder2: entity work.four_bit(main) port map(a, '0' & ap2(3 downto 1), b(2), c3);
	least3 <= c3(0);
	ap3 <= c3(4 downto 1);
	
	adder3: entity work.four_bit(main) port map(a, '0' & ap3(3 downto 1), b(3), c4);
	
	LEDG(7 downto 0) <= c4(4 downto 0) & least3 & least2 & least1;
end architecture;
