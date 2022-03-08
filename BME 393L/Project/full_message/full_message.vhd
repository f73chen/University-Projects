library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_message is port( 
	CLOCK_50_B5B: in std_logic;
	GPIO:			 out std_logic_vector(35 downto 0) ); 
end entity full_message; 

architecture main of full_message is 
	signal counter:            unsigned(24 downto 0);
	signal fast, slow, index:  integer range 0 to 56 := 0;
	signal fast_clk, slow_clk: std_logic;
	signal row_driver:         std_logic_vector(0 to 7);
	signal col_driver:         std_logic_vector(0 to 7) := "01111111"; 
	signal letter:             std_logic_vector(0 to 63) := "0111110010000010100010101000010001111010000000000000000000000000";
	
	constant message_len:      integer := 29;
	constant message:          string(1 to message_len) := "BME-393L DIGITAL SYSTEMS LAB ";
	
	signal one_char:           character := ' ';
	signal int_one_char:       integer;
	signal row_bits:           std_logic_vector(47 downto 0);
	signal ascii, ascii2:      std_logic_vector(6 downto 0);
	signal pointer:            unsigned(5 downto 0) := "000001";
	
begin 
	one_char <= message(to_integer(pointer));
	int_one_char <= character'pos(one_char);
	ascii <= std_logic_vector(to_unsigned(int_one_char, 7));
	
--	ascii2 <= ascii when rising_edge(KEY(0));
--	pointer <= pointer + 1 when rising_edge(KEY(0));

--	if pointer = message_len then
--		pointer <= to_unsigned(1, 6);
--	else
--		pointer <= pointer + 1;
--	end if;

	row_bits <= "011111101001000010010000100100000111111000000000" when ascii = "1000001" else -- A (0x41)
					"111111101001001010010010100100100110110000000000"	when ascii = "1000010" else -- B (0x42)
					"011111001000001010000010100000100100010000000000"	when ascii = "1000011" else -- C (0x43)
					"111111101000001010000010100000100111110000000000"	when ascii = "1000100" else -- D (0x44)
					"111111101001001010010010100100101000001000000000"	when ascii = "1000101" else -- E (0x45)
					"111111101001000010010000100100001000000000000000"	when ascii = "1000110" else -- F (0x46)
					"011111001000001010001010100010100100111000000000"	when ascii = "1000111" else -- G (0x47)
					"111111100001000000010000000100001111111000000000"	when ascii = "1001000" else -- H (0x48)
					"000000001000001011111110100000100000000000000000"	when ascii = "1001001" else -- I (0x49)
					"000001000000001000000010000000101111110000000000"	when ascii = "1001010" else -- J (0x4A)
					"111111100001000000101000010001001000001000000000"	when ascii = "1001011" else -- K (0x4B)
					"111111100000001000000010000000100000001000000000"	when ascii = "1001100" else -- L (0x4C)
					"111111100100000000110000010000001111111000000000"	when ascii = "1001101" else -- M (0x4D)
					"111111100010000000010000000010001111111000000000"	when ascii = "1001110" else -- N (0x4E)
					"011111001000001010000010100000100111110000000000"	when ascii = "1001111" else -- O (0x4F)
					"111111101000100010001000100010000111000000000000"	when ascii = "1010000" else -- P (0x50)
					"011111001000001010001010100001000111101000000000"	when ascii = "1010001" else -- Q (0x51)
					"111111101001000010011000100101000110001000000000"	when ascii = "1010010" else -- R (0x52)
					"011001001001001010010010100100100100110000000000"	when ascii = "1010011" else -- S (0x53)
					"100000001000000011111110100000001000000000000000"	when ascii = "1010100" else -- T (0x54)
					"111111000000001000000010000000101111110000000000"	when ascii = "1010101" else -- U (0x55)
					"111110000000010000000010000001001111100000000000"	when ascii = "1010110" else -- V (0x56)
					"111111100000010000011000000001001111111000000000"	when ascii = "1010111" else -- W (0x57)
					"110001100010100000010000001010001100011000000000"	when ascii = "1011000" else -- X (0x58)
					"110000000010000000011110001000001100000000000000"	when ascii = "1011001" else -- Y (0x59)
					"100001101000101010010010101000101100001000000000"	when ascii = "1011010" else -- Z (0x5A)
					"011111001000101010010010101000100111110000000000"	when ascii = "0110000" else -- 0 (0x30)
					"000000000100001011111110000000100000000000000000"	when ascii = "0110001" else -- 1 (0x31)
					"010001101000101010010010100100100110000000000000"	when ascii = "0110010" else -- 2 (0x32)
					"010001001000001010010010100100100110110000000000"	when ascii = "0110011" else -- 3 (0x33)
					"000110000010100001001000111111100000100000000000"	when ascii = "0110100" else -- 4 (0x34)
					"111001001010001010100010101000101001110000000000"	when ascii = "0110101" else -- 5 (0x35)
					"001111000101001010010010100100101000110000000000"	when ascii = "0110110" else -- 6 (0x36)
					"100000001000111010010000101000001100000000000000"	when ascii = "0110111" else -- 7 (0x37)
					"011011001001001010010010100100100110110000000000"	when ascii = "0111000" else -- 8 (0x38)
					"011001001001001010010010100100100111110000000000"	when ascii = "0111001" else -- 9 (0x39)
					"000000000000000000000000000000000000000000000000"	when ascii = "0100000" else -- Blank (0x20)
					"000100000001000000010000000100000001000000000000"	when ascii = "0101101" else -- Dash (0x2D)
					"100100101001001010010010100100101001001000000000";                            -- Error 

	-- Extract clock signals
	process (CLOCK_50_B5B) begin
		if rising_edge(CLOCK_50_B5B) then
			counter <= counter + 1;
			fast_clk <= counter(14);
			slow_clk <= counter(24);
		end if;
	end process;
	
	-- Scroll through row
	process (fast_clk) begin
		if rising_edge(fast_clk) then
			col_driver <= col_driver(7) & col_driver(0 to 6);
			if fast = 56 then
				fast <= 0;
			else
				fast <= fast + 8;
			end if;
			
			index <= (fast + slow) mod 64;
		end if;
	end process;
	
	-- Move the letter to the left
	-- In the full code, append the next character instead of letter(0 to 7)
	process (slow_clk) begin
		if rising_edge(slow_clk) then
			if slow = 56 then
				slow <= 0;
			else
				slow <= slow + 8;
			end if;
		end if;
	end process;
	
	row_driver <= letter(index to index+7);

	GPIO( 1) <= row_driver(0);
	GPIO( 3) <= row_driver(1); 
	GPIO( 5) <= row_driver(2); 
	GPIO( 7) <= row_driver(3); 
	GPIO( 9) <= row_driver(4); 
	GPIO(11) <= row_driver(5); 
	GPIO(13) <= row_driver(6); 
	GPIO(15) <= row_driver(7); 

	GPIO(21) <= col_driver(0); 
	GPIO(23) <= col_driver(1); 
	GPIO(25) <= col_driver(2); 
	GPIO(27) <= col_driver(3); 
	GPIO(29) <= col_driver(4); 
	GPIO(31) <= col_driver(5); 
	GPIO(33) <= col_driver(6); 
	GPIO(35) <= col_driver(7);
end architecture; 