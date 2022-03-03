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
	
	type state_names is	      (ns0, ns1, ns2, ns3, ew0, ew1, ew2, ew3);
   signal state, next_State:  state_names;
	signal state_counter:		unsigned(3 downto 0);
	
	signal counter:           	unsigned(24 downto 0);
	signal seconds:    			unsigned(3 downto 0);
	signal hz_counter:			unsigned(3 downto 0);
	signal hz1, hz10:				std_logic;
	signal NSG, NSR, EWG, EWR: std_logic;
	
begin
	-- Process to generate 10 Hz from 50 MHz
	process (CLOCK_50_B5B) begin
		if rising_edge(CLOCK_50_B5B) then
			if counter = to_unsigned(2499999, 25) then
				counter <= to_unsigned(0, 25);
				hz10 <= not hz10;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	-- Process to generate 1 Hz from 10 Hz
	process (hz10) begin
		if rising_edge(hz10) then
			if hz_counter = to_unsigned(9, 4) then
				hz_counter <= to_unsigned(0, 4);
				hz1 <= not hz1;
			else
				hz_counter <= hz_counter + 1;
			end if;
		end if;
	end process;
	
	-- Process that increments a counter every second and resets it
	process (hz1) begin
		if rising_edge(hz1) then
			seconds <= seconds + 1;			
			case state is
				when ns0 =>
					if seconds = "0001" then
						seconds <= "0000";
					end if;
				when ns1 =>
					if seconds = "0100" then
						seconds <= "0000";
					end if;
				when ns2 =>
					if seconds = "0010" then
						seconds <= "0000";
					end if;
				when ns3 =>
					if seconds = "0000" then
						seconds <= "0000";
					end if;
				when ew0 =>
					if seconds = "0001" then
						seconds <= "0000";
					end if;
				when ew1 =>
					if seconds = "0100" then
						seconds <= "0000";
					end if;
				when ew2 =>
					if seconds = "0010" then
						seconds <= "0000";
					end if;
				when ew3 =>
					if seconds = "0000" then
						seconds <= "0000";
					end if;
			end case;
		end if;
	end process;
	
	-- Combinational process to find next_state from current_state and counter
	process (hz10) begin
		case state is
			when ns0 =>
				if seconds = "0001" then
					next_state <= ns1;
					state_counter <= "0001";
				else
					NSG <= hz10;
					NSR <= '0';
					EWG <= '0';
					EWR <= '1';	
				end if;
			when ns1 =>
				if seconds = "0100" then
					next_state <= ns2;
					state_counter <= "0010";
				else
					NSG <= '1';
					NSR <= '0';
					EWG <= '0';
					EWR <= '1';
				end if;
			when ns2 =>
				if seconds = "0010" then
					next_state <= ns3;
					state_counter <= "0011";
				else
					NSG <= '0';
					NSR <= hz10;
					EWG <= '0';
					EWR <= '1';	
				end if;
			when ns3 =>
				if seconds = "0000" then
					next_state <= ew0;
					state_counter <= "0100";
				else
					NSG <= '0';
					NSR <= '1';
					EWG <= '0';
					EWR <= '1';	
				end if;
			when ew0 =>
				if seconds = "0001" then
					next_state <= ew1;
					state_counter <= "0101";
				else
					NSG <= '0';
					NSR <= '1';
					EWG <= hz10;
					EWR <= '0';	
				end if;
			when ew1 =>
				if seconds = "0100" then
					next_state <= ew2;
					state_counter <= "0110";
				else
					NSG <= '0';
					NSR <= '1';
					EWG <= '1';
					EWR <= '0';	
				end if;
			when ew2 =>
				if seconds = "0010" then
					next_state <= ew3;
					state_counter <= "0111";
				else
					NSG <= '0';
					NSR <= '1';
					EWG <= '0';
					EWR <= hz10;	
				end if;
			when ew3 =>
				if seconds = "0000" then
					next_state <= ns0;
					state_counter <= "0000";
				else
					NSG <= '0';
					NSR <= '1';
					EWG <= '0';
					EWR <= '1';	
				end if;
		end case;
	end process;
	
	-- Process to allocate next_state to current_state
	process (hz1) begin
		if rising_edge(hz1) then
			state <= next_state;
		end if;
	end process;

	LEDG(7) <= NSG;
	LEDR(0) <= NSR;
	LEDG(4) <= EWG;
	LEDR(4) <= EWR;
	
	hex3_inst:	entity work.seven_segment(behavioral) port map(std_logic_vector(state_counter), '0', hex3);
	hex0_inst:	entity work.seven_segment(behavioral) port map(std_logic_vector(seconds), '0', hex0);

end architecture;