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
use ieee.numeric_std.all;

entity random_gen is port(
	CLOCK_50_B5B: in std_logic;
	KEY: in std_logic_vector(3 downto 0);
	hex3:	out std_logic_Vector(6 downto 0);
	hex2:	out std_logic_Vector(6 downto 0);
	hex1:	out std_logic_Vector(6 downto 0);
	hex0:	out std_logic_Vector(6 downto 0) );
end entity random_gen;

architecture main of random_gen is
	component seven_segment is port(
		data_in:			in std_logic_vector(3 downto 0);
		blanking:		in std_logic;	
		segments_out: 	out std_logic_vector(6 downto 0) );
	end component;

	signal counter: unsigned(24 downto 0);
	signal rndm: unsigned(7 downto 0);
	signal random1, random2: std_logic_vector(7 downto 0);
	signal on1, on2: std_logic := '1';

begin
	rndm <= rndm + 1 when rising_edge(CLOCK_50_B5B);
	
	random2 <= random1 when rising_edge(KEY(0));
	random1 <= std_logic_vector(rndm) when rising_edge(KEY(0));
	on2 <= on1 when rising_edge(KEY(0));
	on1 <= '0' when rising_edge(KEY(0));
	
	hex3_inst:	entity work.seven_segment(behavioral) port map(random2(7 downto 4), on2, hex3);
	hex2_inst:	entity work.seven_segment(behavioral) port map(random2(3 downto 0), on2, hex2);
	hex1_inst:	entity work.seven_segment(behavioral) port map(random1(7 downto 4), on1, hex1);
	hex0_inst:	entity work.seven_segment(behavioral) port map(random1(3 downto 0), on1, hex0);
end architecture;