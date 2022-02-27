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
	
   signal state:              unsigned(3 downto 0);
	signal counter:            unsigned(24 downto 0);
	signal seconds_20:         unsigned(4 downto 0);
	signal seconds:            unsigned(3 downto 0);
	signal NSG, NSR, EWG, EWR: std_logic;
	
begin
   process (CLOCK_50_B5B)
   begin
		-- Reset
      if KEY(0) = '1' then
         state <= 0;
		
		-- Increment 20ns, 1/20s, and 1s counters
      elsif (rising_edge(CLOCK_50_B5B)) then
			if counter = to_unsigned(2499999, 25) then
				counter <= to_unsigned(0, 25);
				seconds_20 <= seconds_20 + 1;
			else
				counter <= counter + 1;
			end if;
			
			if seconds_20 = to_unsigned(19, 5) then
				seconds_20 <= to_unsigned(0, 5);
				seconds <= seconds + 1;
			end if;
		
			-- @@@ FIX! Make everything operate on rising edge of s_20 instead
         case state is
            when '0000' =>
               if seconds = '0010' then
                  state <= '0001';
               else
                  NSG <= not NSG;
						NSR <= '0';
						EWG <= '0';
						EWR <= '1';						
               end if;
            when '0001' =>
               if seconds = '0101' then
                  state <= '0010';
               else
                  NSG <= '1';
						NSR <= '0';
						EWG <= '0';
						EWR <= '1';						
               end if;
            when '0010' =>
               if seconds = '0011' then
                  state <= '0011';
               else
                  NSG <= '0';
						NSR <= not NSR;
						EWG <= '0';
						EWR <= '1';						
               end if;
            when '0011' =>
               if seconds = '0001' then
                  state <= '0100';
               else
                  NSG <= '0';
						NSR <= '1';
						EWG <= '0';
						EWR <= '1';						
               end if;
            when '0100' =>
               if seconds = '0010' then
                  state <= '0101';
               else
                  NSG <= '0';
						NSR <= '1';
						EWG <= not EWG;
						EWR <= '0';						
               end if;
            when '0101' =>
               if seconds = '0101' then
                  state <= '0110';
               else
                  NSG <= '0';
						NSR <= '1';
						EWG <= '1';
						EWR <= '0';						
               end if;
            when '0110' =>
               if seconds = '0011' then
                  state <= '0111';
               else
                  NSG <= '0';
						NSR <= '1';
						EWG <= '0';
						EWR <= not EWR;						
               end if;
            when '0111' =>
               if seconds = '0001' then
                  state <= '0000';
               else
                  NSG <= '0';
						NSR <= '1';
						EWG <= '0';
						EWR <= '1';						
               end if;
         end case;
      end if;
   end process;
   
	LEDG(7) <= NSG;
	LEDR(0) <= NSR;
	LEDG(4) <= EWG;
	LEDR(4) <= EWR;
	
	hex3_inst:	entity work.seven_segment(behavioral) port map(std_logic_vector(state), '0', hex3);
	hex0_inst:	entity work.seven_segment(behavioral) port map(std_logic_vector(seconds), '0', hex0);

end architecture;