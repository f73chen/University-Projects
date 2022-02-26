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

entity heart_bit is
port(	SW: 	in  std_logic_vector(9 downto 0);
		KEY:	in  std_logic_vector(3 downto 0);
		
		LEDG: out std_logic_vector(4 downto 0);
		hex1:	out std_logic_Vector(6 downto 0);
		hex0:	out std_logic_Vector(6 downto 0)
		);
end entity heart_bit;

architecture main of heart_bit is
	component seven_segment is port(
		data_in:			in std_logic_vector(3 downto 0);
		blanking:		in std_logic;	
		segments_out: 	out std_logic_vector(6 downto 0) );
	end component;
	
signal c: 	 std_logic_vector(4 downto 0);
signal out1: std_logic_vector(3 downto 0);
signal out2: std_logic_vector(3 downto 0);

begin
	c <= c + 1 when rising_edge(KEY(0));
	
	out1 <= "000" & c(4);
	out2 <= c(3 downto 0);
	
	LEDG(4 downto 0) <= std_logic_vector(c);
	hex1_inst: entity work.seven_segment(behavioral) port map(out1, not c(4), hex1);
	hex0_inst: entity work.seven_segment(behavioral) port map(out2, '0', hex0);
end architecture;