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

entity traffic_light is port( 
	CLOCK_50_B5B: in std_logic;
	KEY:	        in std_logic_vector(3 downto 0);
	LEDG:	       out std_logic_vector(9 downto 0);
	LEDR:	       out std_logic_vector(9 downto 0);
	hex3:        out std_logic_Vector(6 downto 0);
	hex0:        out std_logic_Vector(6 downto 0) );
end traffic_light;

architecture main of traffic_light is
	component seven_segment is port(
		data_in:			in std_logic_vector(3 downto 0);
		blanking:		in std_logic;	
		segments_out: out std_logic_vector(6 downto 0) );
	end component;
	
   signal state:              integer range 0 to 7;
	signal seconds:            integer range 0 to 15;
	signal seconds_20:         integer range 0 to 20;
	signal counter:            integer range 0 to 25000000;
	signal NSG, NSR, EWG, EWR: std_logic;
	
begin
   process (CLOCK_50_B5B)
   begin
		-- Reset
      if KEY(0) = '1' then
         state <= 0;
		
		-- Each primary tick is 1/20th of a second, so lights flash at 10Hz
      elsif (rising_edge(CLOCK_50_B5B)) then
			if counter = to_unsigned(2499999, 25) then
				counter <= 0;
				seconds_20 <= seconds_20 + 1;
				
				case state is
					when 0 =>
						if seconds = 2 then
							seconds <= 0;
							state <= 1;
						else
							NSG <= not NSG;
							NSR <= '0';
							EWG <= '0';
							EWR <= '1';						
						end if;
					when 1 =>
						if seconds = 5 then
							seconds <= 0;
							state <= 2;
						else
							NSG <= '1';
							NSR <= '0';
							EWG <= '0';
							EWR <= '1';						
						end if;
					when 2 =>
						if seconds = 3 then
							seconds <= 0;
							state <= 3;
						else
							NSG <= '0';
							NSR <= not NSR;
							EWG <= '0';
							EWR <= '1';						
						end if;
					when 3 =>
						if seconds = 1 then
							seconds <= 0;
							state <= 4;
						else
							NSG <= '0';
							NSR <= '1';
							EWG <= '0';
							EWR <= '1';						
						end if;
					when 4 =>
						if seconds = 2 then
							seconds <= 0;
							state <= 5;
						else
							NSG <= '0';
							NSR <= '1';
							EWG <= not EWG;
							EWR <= '0';						
						end if;
					when 5 =>
						if seconds = 5 then
							seconds <= 0;
							state <= 6;
						else
							NSG <= '0';
							NSR <= '1';
							EWG <= '1';
							EWR <= '0';						
						end if;
					when 6 =>
						if seconds = 3 then
							seconds <= 0;
							state <= 7;
						else
							NSG <= '0';
							NSR <= '1';
							EWG <= '0';
							EWR <= not EWR;						
						end if;
					when 7 =>
						if seconds = 1 then
							seconds <= 0;
							state <= 0;
						else
							NSG <= '0';
							NSR <= '1';
							EWG <= '0';
							EWR <= '1';						
						end if;
				end case;
				
			else
				counter <= counter + 1;
			end if;
			
			if seconds_20 = 19 then
				seconds_20 <= 0;
				seconds <= seconds + 1;
			end if;
      end if;
   end process;
   
	LEDG(7) <= NSG;
	LEDR(0) <= NSR;
	LEDG(4) <= EWG;
	LEDR(4) <= EWR;
	
	hex3_inst:	entity work.seven_segment(behavioral) port map(std_logic_vector(to_unsigned(state, 4)), '0', hex3);
	hex0_inst:	entity work.seven_segment(behavioral) port map(std_logic_vector(to_unsigned(seconds, 4)), '0', hex0);

end architecture;