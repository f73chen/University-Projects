library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment is port(
	data_in:			in std_logic_vector(3 downto 0);
	blanking:		in std_logic;	
	segments_out: 	out std_logic_vector(6 downto 0) );
end entity seven_segment;

architecture behavioral of seven_segment is
begin
	with blanking & data_in select
		segments_out(6 downto 0) <=	"1000000" when "00000",		-- 0
												"1111001" when "00001",		-- 1
												"0100100" when "00010",		-- 2
												"0110000" when "00011",		-- 3
												"0011001" when "00100",		-- 4
												"0010010" when "00101",		-- 5
												"0000010" when "00110",		-- 6
												"1111000" when "00111",		-- 7
												"0000000" when "01000",		-- 8
												"0010000" when "01001",		-- 9
												"0001000" when "01010",		-- A
												"0000011" when "01011",		-- B
												"1000110" when "01100",		-- C
												"0100001" when "01101",		-- D
												"0000110" when "01110",		-- E
												"0001110" when "01111",		-- F
												"1111111" when others;		-- Blanking
end architecture behavioral;



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
		LEDG: out std_logic_vector(7 downto 0);
		hex3:	out std_logic_Vector(6 downto 0);
		hex2:	out std_logic_Vector(6 downto 0);
		hex1:	out std_logic_Vector(6 downto 0);
		hex0:	out std_logic_Vector(6 downto 0)
		);
end entity multiplier;

architecture main of multiplier is
	component four_bit is port(
		a: in  std_logic_vector(3 downto 0);
		b: in  std_logic_vector(3 downto 0);
		c: out std_logic_vector(4 downto 0) );
	end component;
	
	component seven_segment is port(
		data_in:			in std_logic_vector(3 downto 0);
		blanking:		in std_logic;	
		segments_out: 	out std_logic_vector(6 downto 0) );
	end component;
	
signal num1: std_logic_vector(3 downto 0);
signal num2: std_logic_vector(3 downto 0);
signal and0, and1, and2, and3: std_logic_vector(3 downto 0);
signal disp0, disp1: std_logic_vector(3 downto 0);
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

	disp0 <= c2(4 downto 1);
	disp1 <= c2(0) & out3 & out2 & out1;
	LEDG(7 downto 0) <= disp0 & disp1;
	
	hex3_inst: entity work.seven_segment(behavioral) port map(num1, '0', hex3);
	hex2_inst: entity work.seven_segment(behavioral) port map(num2, '0', hex2);
	hex1_inst: entity work.seven_segment(behavioral) port map(disp0, '0', hex1);
	hex0_inst: entity work.seven_segment(behavioral) port map(disp1, '0', hex0);
end architecture;
