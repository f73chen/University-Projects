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
-- Generated on "02/25/2022 23:24:48"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Lab4_Prelab
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Lab4_Prelab_vhd_vec_tst IS
END Lab4_Prelab_vhd_vec_tst;
ARCHITECTURE Lab4_Prelab_arch OF Lab4_Prelab_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLOCK_50_B5B : STD_LOGIC;
SIGNAL LEDG : STD_LOGIC_VECTOR(7 DOWNTO 0);
COMPONENT Lab4_Prelab
	PORT (
	CLOCK_50_B5B : IN STD_LOGIC;
	LEDG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Lab4_Prelab
	PORT MAP (
-- list connections between master ports and signals
	CLOCK_50_B5B => CLOCK_50_B5B,
	LEDG => LEDG
	);

-- CLOCK_50_B5B
t_prcs_CLOCK_50_B5B: PROCESS
BEGIN
LOOP
	CLOCK_50_B5B <= '0';
	WAIT FOR 5000 ps;
	CLOCK_50_B5B <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_CLOCK_50_B5B;
END Lab4_Prelab_arch;
