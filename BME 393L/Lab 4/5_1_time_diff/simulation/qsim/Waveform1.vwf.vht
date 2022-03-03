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
-- Generated on "03/03/2022 10:48:50"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          time_diff
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY time_diff_vhd_vec_tst IS
END time_diff_vhd_vec_tst;
ARCHITECTURE time_diff_arch OF time_diff_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLOCK_50_B5B : STD_LOGIC;
SIGNAL hex0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL KEY : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT time_diff
	PORT (
	CLOCK_50_B5B : IN STD_LOGIC;
	hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : time_diff
	PORT MAP (
-- list connections between master ports and signals
	CLOCK_50_B5B => CLOCK_50_B5B,
	hex0 => hex0,
	hex1 => hex1,
	hex2 => hex2,
	hex3 => hex3,
	KEY => KEY
	);

-- CLOCK_50_B5B
t_prcs_CLOCK_50_B5B: PROCESS
BEGIN
LOOP
	CLOCK_50_B5B <= '0';
	WAIT FOR 2500 ps;
	CLOCK_50_B5B <= '1';
	WAIT FOR 2500 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_CLOCK_50_B5B;

-- KEY[0]
t_prcs_KEY_0: PROCESS
BEGIN
	KEY(0) <= '0';
	WAIT FOR 40000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 40000 ps;
	KEY(0) <= '1';
	WAIT FOR 60000 ps;
	KEY(0) <= '0';
	WAIT FOR 80000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 40000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 40000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 60000 ps;
	KEY(0) <= '1';
	WAIT FOR 40000 ps;
	KEY(0) <= '0';
	WAIT FOR 20000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 20000 ps;
	KEY(0) <= '1';
	WAIT FOR 120000 ps;
	KEY(0) <= '0';
	WAIT FOR 20000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 20000 ps;
	KEY(0) <= '1';
	WAIT FOR 40000 ps;
	KEY(0) <= '0';
	WAIT FOR 20000 ps;
	KEY(0) <= '1';
	WAIT FOR 80000 ps;
	KEY(0) <= '0';
	WAIT FOR 20000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 20000 ps;
	KEY(0) <= '1';
	WAIT FOR 20000 ps;
	KEY(0) <= '0';
	WAIT FOR 40000 ps;
	KEY(0) <= '1';
WAIT;
END PROCESS t_prcs_KEY_0;

-- KEY[1]
t_prcs_KEY_1: PROCESS
BEGIN
	KEY(1) <= '0';
	WAIT FOR 40000 ps;
	KEY(1) <= '1';
	WAIT FOR 240000 ps;
	KEY(1) <= '0';
	WAIT FOR 40000 ps;
	KEY(1) <= '1';
	WAIT FOR 120000 ps;
	KEY(1) <= '0';
	WAIT FOR 40000 ps;
	KEY(1) <= '1';
	WAIT FOR 40000 ps;
	KEY(1) <= '0';
	WAIT FOR 40000 ps;
	KEY(1) <= '1';
	WAIT FOR 120000 ps;
	KEY(1) <= '0';
	WAIT FOR 80000 ps;
	KEY(1) <= '1';
	WAIT FOR 40000 ps;
	KEY(1) <= '0';
	WAIT FOR 80000 ps;
	KEY(1) <= '1';
	WAIT FOR 40000 ps;
	KEY(1) <= '0';
	WAIT FOR 40000 ps;
	KEY(1) <= '1';
WAIT;
END PROCESS t_prcs_KEY_1;

-- KEY[3]
t_prcs_KEY_3: PROCESS
BEGIN
	KEY(3) <= '1';
	WAIT FOR 60000 ps;
	KEY(3) <= '0';
	WAIT FOR 60000 ps;
	KEY(3) <= '1';
	WAIT FOR 120000 ps;
	KEY(3) <= '0';
	WAIT FOR 180000 ps;
	KEY(3) <= '1';
	WAIT FOR 60000 ps;
	KEY(3) <= '0';
	WAIT FOR 120000 ps;
	KEY(3) <= '1';
	WAIT FOR 60000 ps;
	KEY(3) <= '0';
	WAIT FOR 60000 ps;
	KEY(3) <= '1';
WAIT;
END PROCESS t_prcs_KEY_3;
END time_diff_arch;
