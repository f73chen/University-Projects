-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "01/18/2022 12:07:19"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          First_circuit
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY First_circuit_vhd_vec_tst IS
END First_circuit_vhd_vec_tst;
ARCHITECTURE First_circuit_arch OF First_circuit_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL LEDG : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL SW : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT First_circuit
	PORT (
	LEDG : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : First_circuit
	PORT MAP (
-- list connections between master ports and signals
	LEDG => LEDG,
	SW => SW
	);

-- SW[0]
t_prcs_SW_0: PROCESS
BEGIN
LOOP
	SW(0) <= '0';
	WAIT FOR 5000 ps;
	SW(0) <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_SW_0;

-- SW[1]
t_prcs_SW_1: PROCESS
BEGIN
LOOP
	SW(1) <= '0';
	WAIT FOR 10000 ps;
	SW(1) <= '1';
	WAIT FOR 10000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_SW_1;

-- SW[2]
t_prcs_SW_2: PROCESS
BEGIN
	FOR i IN 1 TO 33
	LOOP
		SW(2) <= '0';
		WAIT FOR 15000 ps;
		SW(2) <= '1';
		WAIT FOR 15000 ps;
	END LOOP;
	SW(2) <= '0';
WAIT;
END PROCESS t_prcs_SW_2;

-- SW[3]
t_prcs_SW_3: PROCESS
BEGIN
LOOP
	SW(3) <= '0';
	WAIT FOR 20000 ps;
	SW(3) <= '1';
	WAIT FOR 20000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_SW_3;
END First_circuit_arch;
