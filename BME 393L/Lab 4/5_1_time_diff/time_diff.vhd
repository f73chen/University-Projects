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

entity time_diff is port(
	CLOCK_50_B5B: in std_logic;
	KEY:          in std_logic_vector(3 downto 0);
	hex3:	out std_logic_Vector(6 downto 0);
	hex2:	out std_logic_Vector(6 downto 0);
	hex1:	out std_logic_Vector(6 downto 0);
	hex0:	out std_logic_Vector(6 downto 0) );
end entity time_diff;

architecture main of time_diff is
	component seven_segment is port(
		data_in:			in std_logic_vector(3 downto 0);
		blanking:		in std_logic;	
		segments_out: 	out std_logic_vector(6 downto 0) );
	end component;
	
	signal counter:	unsigned(15 downto 0);
	signal hz1k:		std_logic;
	signal diff:		std_logic_vector(15 downto 0);

begin
	-- Process to get 1 ms from clock
	process (CLOCK_50_B5B) begin
		if rising_edge(CLOCK_50_B5B) then
			
			
		end if;
	end process;

	-- buttons high when up, low when pressed
	-- Calculate the time between one high one low and both high or both low
	-- aka start when xor(a, b) and end when xnor(a, b)

	divider: process (CLOCK_50_B5B)
	begin
		if rising_edge(CLOCK_50_B5B) then
			if (KEY(0) xor KEY(1)) = '1' then
				clock <= clock + 1;
			elsif key(3) = '1' then
				diff <= std_logic_vector(to_unsigned(0, 16));
			else
				-- clock(15) is closest to 1 ms --> 2^16 * 20 ns = 1.31 ms
				diff <= std_logic_vector(clock(30 downto 15));
				clock <= to_unsigned(0, 31);
			end if;
		end if;
	end process;
	
 	hex3_inst:	entity work.seven_segment(behavioral) port map(diff(15 downto 12), '0', hex3);
 	hex2_inst:	entity work.seven_segment(behavioral) port map(diff(11 downto 8), '0', hex2);
 	hex1_inst:	entity work.seven_segment(behavioral) port map(diff(7 downto 4), '0', hex1);
 	hex0_inst:	entity work.seven_segment(behavioral) port map(diff(3 downto 0), '0', hex0);
end architecture;