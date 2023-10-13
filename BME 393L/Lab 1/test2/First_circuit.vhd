-- First VHDL code for BME-393 Lab 
-- It implements three primitive gates of AND, OR, and NOT (inverter) 

library ieee;						-- Declare that you want to use IEEE libraries 
use ieee.std_logic_1164.all;	-- Library for standard logic circuits 
-- use ieee.numeric_std.all; 	-- Another useful library for UNSIGNED numbers 

entity First_circuit is 	-- entity definition 
	port( SW: 		in 	std_logic_vector(3 downto 0); 	-- Toggle switches 
			LEDG:		out 	std_logic_vector(2 downto 0)		-- Green LEDs 
			); 
end entity First_circuit; 

architecture main of First_circuit is 
signal xor1, xor2, xor3: 	std_logic;	-- AND gate output for reading by XOR gate  
signal and1, and2, and3: 	std_logic;	-- OR gate output for reading by XOR gate 
signal or1:						std_logic;

begin 

xor1 <= sw(0) xor sw(2);
and1 <= sw(0) and sw(2);

xor2 <= sw(1) xor sw(3);
and2 <= sw(1) and sw(3);

xor3 <= and1 xor xor2;
and3 <= and1 and xor2;

or1 <= and2 or and3;

LEDG(0) <= xor1;
LEDG(1) <= xor3;
LEDG(2) <= or1;

end architecture main; 
			
