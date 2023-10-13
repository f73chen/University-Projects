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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "02/25/2022 23:54:11"

-- 
-- Device: Altera 5CGXFC5C6F27C7 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	random_gen IS
    PORT (
	CLOCK_50_B5B : IN std_logic;
	KEY : IN std_logic_vector(3 DOWNTO 0);
	hex3 : OUT std_logic_vector(6 DOWNTO 0);
	hex2 : OUT std_logic_vector(6 DOWNTO 0);
	hex1 : OUT std_logic_vector(6 DOWNTO 0);
	hex0 : OUT std_logic_vector(6 DOWNTO 0)
	);
END random_gen;

-- Design Ports Information
-- KEY[1]	=>  Location: PIN_P12,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- KEY[2]	=>  Location: PIN_Y15,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- KEY[3]	=>  Location: PIN_Y16,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex3[0]	=>  Location: PIN_Y24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[1]	=>  Location: PIN_Y23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[2]	=>  Location: PIN_AA23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[3]	=>  Location: PIN_AA22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[4]	=>  Location: PIN_AC24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[5]	=>  Location: PIN_AC23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[6]	=>  Location: PIN_AC22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex2[0]	=>  Location: PIN_AD7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex2[1]	=>  Location: PIN_AD6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex2[2]	=>  Location: PIN_U20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex2[3]	=>  Location: PIN_V22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex2[4]	=>  Location: PIN_V20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex2[5]	=>  Location: PIN_W21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex2[6]	=>  Location: PIN_W20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex1[0]	=>  Location: PIN_AA18,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex1[1]	=>  Location: PIN_AD26,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex1[2]	=>  Location: PIN_AB19,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex1[3]	=>  Location: PIN_AE26,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex1[4]	=>  Location: PIN_AE25,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex1[5]	=>  Location: PIN_AC19,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex1[6]	=>  Location: PIN_AF24,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[0]	=>  Location: PIN_V19,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[1]	=>  Location: PIN_V18,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[2]	=>  Location: PIN_V17,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[3]	=>  Location: PIN_W18,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[4]	=>  Location: PIN_Y20,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[5]	=>  Location: PIN_Y19,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[6]	=>  Location: PIN_Y18,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- KEY[0]	=>  Location: PIN_P11,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- CLOCK_50_B5B	=>  Location: PIN_R20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF random_gen IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLOCK_50_B5B : std_logic;
SIGNAL ww_KEY : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_hex3 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex2 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex1 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex0 : std_logic_vector(6 DOWNTO 0);
SIGNAL \KEY[1]~input_o\ : std_logic;
SIGNAL \KEY[2]~input_o\ : std_logic;
SIGNAL \KEY[3]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \KEY[0]~input_o\ : std_logic;
SIGNAL \KEY[0]~inputCLKENA0_outclk\ : std_logic;
SIGNAL \on1~feeder_combout\ : std_logic;
SIGNAL \on1~q\ : std_logic;
SIGNAL \on2~feeder_combout\ : std_logic;
SIGNAL \on2~q\ : std_logic;
SIGNAL \CLOCK_50_B5B~input_o\ : std_logic;
SIGNAL \CLOCK_50_B5B~inputCLKENA0_outclk\ : std_logic;
SIGNAL \rndm[0]~0_combout\ : std_logic;
SIGNAL \rndm[0]~feeder_combout\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \rndm[1]~feeder_combout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \rndm[2]~feeder_combout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \rndm[4]~feeder_combout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \rndm[7]~feeder_combout\ : std_logic;
SIGNAL \random1[5]~feeder_combout\ : std_logic;
SIGNAL \rndm[4]~DUPLICATE_q\ : std_logic;
SIGNAL \hex3_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux0~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux6~0_combout\ : std_logic;
SIGNAL \random2[1]~DUPLICATE_q\ : std_logic;
SIGNAL \hex2_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux0~0_combout\ : std_logic;
SIGNAL \on1~DUPLICATE_q\ : std_logic;
SIGNAL \hex1_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex1_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex1_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex1_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex1_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex1_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex1_inst|Mux0~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux0~0_combout\ : std_logic;
SIGNAL random2 : std_logic_vector(7 DOWNTO 0);
SIGNAL random1 : std_logic_vector(7 DOWNTO 0);
SIGNAL rndm : std_logic_vector(7 DOWNTO 0);
SIGNAL ALT_INV_rndm : std_logic_vector(7 DOWNTO 0);
SIGNAL ALT_INV_random1 : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_on1~q\ : std_logic;
SIGNAL ALT_INV_random2 : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_on2~q\ : std_logic;
SIGNAL \ALT_INV_Add0~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~1_sumout\ : std_logic;
SIGNAL \ALT_INV_on1~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_random2[1]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_rndm[0]~0_combout\ : std_logic;

BEGIN

ww_CLOCK_50_B5B <= CLOCK_50_B5B;
ww_KEY <= KEY;
hex3 <= ww_hex3;
hex2 <= ww_hex2;
hex1 <= ww_hex1;
hex0 <= ww_hex0;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
ALT_INV_rndm(3) <= NOT rndm(3);
ALT_INV_rndm(2) <= NOT rndm(2);
ALT_INV_rndm(1) <= NOT rndm(1);
ALT_INV_rndm(0) <= NOT rndm(0);
ALT_INV_rndm(7) <= NOT rndm(7);
ALT_INV_rndm(6) <= NOT rndm(6);
ALT_INV_rndm(5) <= NOT rndm(5);
ALT_INV_rndm(4) <= NOT rndm(4);
ALT_INV_random1(3) <= NOT random1(3);
ALT_INV_random1(2) <= NOT random1(2);
ALT_INV_random1(1) <= NOT random1(1);
ALT_INV_random1(0) <= NOT random1(0);
ALT_INV_random1(7) <= NOT random1(7);
ALT_INV_random1(6) <= NOT random1(6);
ALT_INV_random1(5) <= NOT random1(5);
ALT_INV_random1(4) <= NOT random1(4);
\ALT_INV_on1~q\ <= NOT \on1~q\;
ALT_INV_random2(3) <= NOT random2(3);
ALT_INV_random2(2) <= NOT random2(2);
ALT_INV_random2(1) <= NOT random2(1);
ALT_INV_random2(0) <= NOT random2(0);
ALT_INV_random2(7) <= NOT random2(7);
ALT_INV_random2(6) <= NOT random2(6);
ALT_INV_random2(5) <= NOT random2(5);
ALT_INV_random2(4) <= NOT random2(4);
\ALT_INV_on2~q\ <= NOT \on2~q\;
\ALT_INV_Add0~21_sumout\ <= NOT \Add0~21_sumout\;
\ALT_INV_Add0~17_sumout\ <= NOT \Add0~17_sumout\;
\ALT_INV_Add0~13_sumout\ <= NOT \Add0~13_sumout\;
\ALT_INV_Add0~1_sumout\ <= NOT \Add0~1_sumout\;
\ALT_INV_on1~DUPLICATE_q\ <= NOT \on1~DUPLICATE_q\;
\ALT_INV_random2[1]~DUPLICATE_q\ <= NOT \random2[1]~DUPLICATE_q\;
\ALT_INV_rndm[0]~0_combout\ <= NOT \rndm[0]~0_combout\;

-- Location: IOOBUF_X68_Y13_N56
\hex3[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex3_inst|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_hex3(0));

-- Location: IOOBUF_X68_Y13_N39
\hex3[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex3_inst|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_hex3(1));

-- Location: IOOBUF_X68_Y11_N56
\hex3[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex3_inst|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_hex3(2));

-- Location: IOOBUF_X68_Y11_N39
\hex3[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex3_inst|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_hex3(3));

-- Location: IOOBUF_X68_Y12_N39
\hex3[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex3_inst|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_hex3(4));

-- Location: IOOBUF_X68_Y10_N96
\hex3[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex3_inst|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_hex3(5));

-- Location: IOOBUF_X68_Y10_N79
\hex3[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex3_inst|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_hex3(6));

-- Location: IOOBUF_X7_Y0_N36
\hex2[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex2_inst|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_hex2(0));

-- Location: IOOBUF_X7_Y0_N53
\hex2[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex2_inst|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_hex2(1));

-- Location: IOOBUF_X68_Y13_N22
\hex2[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex2_inst|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_hex2(2));

-- Location: IOOBUF_X68_Y12_N5
\hex2[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex2_inst|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_hex2(3));

-- Location: IOOBUF_X68_Y10_N62
\hex2[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex2_inst|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_hex2(4));

-- Location: IOOBUF_X68_Y11_N22
\hex2[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex2_inst|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_hex2(5));

-- Location: IOOBUF_X68_Y11_N5
\hex2[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex2_inst|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_hex2(6));

-- Location: IOOBUF_X62_Y0_N59
\hex1[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex1_inst|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_hex1(0));

-- Location: IOOBUF_X64_Y0_N36
\hex1[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex1_inst|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_hex1(1));

-- Location: IOOBUF_X65_Y0_N36
\hex1[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex1_inst|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_hex1(2));

-- Location: IOOBUF_X64_Y0_N53
\hex1[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex1_inst|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_hex1(3));

-- Location: IOOBUF_X62_Y0_N76
\hex1[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex1_inst|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_hex1(4));

-- Location: IOOBUF_X65_Y0_N53
\hex1[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex1_inst|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_hex1(5));

-- Location: IOOBUF_X62_Y0_N93
\hex1[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex1_inst|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_hex1(6));

-- Location: IOOBUF_X66_Y0_N2
\hex0[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex0_inst|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(0));

-- Location: IOOBUF_X64_Y0_N2
\hex0[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex0_inst|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(1));

-- Location: IOOBUF_X64_Y0_N19
\hex0[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex0_inst|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(2));

-- Location: IOOBUF_X66_Y0_N19
\hex0[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex0_inst|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(3));

-- Location: IOOBUF_X65_Y0_N2
\hex0[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex0_inst|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(4));

-- Location: IOOBUF_X65_Y0_N19
\hex0[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex0_inst|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(5));

-- Location: IOOBUF_X62_Y0_N42
\hex0[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \hex0_inst|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(6));

-- Location: IOIBUF_X21_Y0_N1
\KEY[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(0),
	o => \KEY[0]~input_o\);

-- Location: CLKCTRL_G6
\KEY[0]~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \KEY[0]~input_o\,
	outclk => \KEY[0]~inputCLKENA0_outclk\);

-- Location: LABCELL_X61_Y4_N33
\on1~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \on1~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	combout => \on1~feeder_combout\);

-- Location: FF_X61_Y4_N35
on1 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \on1~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \on1~q\);

-- Location: LABCELL_X61_Y4_N30
\on2~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \on2~feeder_combout\ = ( \on1~q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_on1~q\,
	combout => \on2~feeder_combout\);

-- Location: FF_X61_Y4_N31
on2 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \on2~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \on2~q\);

-- Location: IOIBUF_X68_Y22_N44
\CLOCK_50_B5B~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK_50_B5B,
	o => \CLOCK_50_B5B~input_o\);

-- Location: CLKCTRL_G9
\CLOCK_50_B5B~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK_50_B5B~input_o\,
	outclk => \CLOCK_50_B5B~inputCLKENA0_outclk\);

-- Location: MLABCELL_X60_Y4_N27
\rndm[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rndm[0]~0_combout\ = ( !rndm(0) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => ALT_INV_rndm(0),
	combout => \rndm[0]~0_combout\);

-- Location: MLABCELL_X60_Y4_N0
\rndm[0]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \rndm[0]~feeder_combout\ = ( \rndm[0]~0_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_rndm[0]~0_combout\,
	combout => \rndm[0]~feeder_combout\);

-- Location: FF_X60_Y4_N2
\rndm[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \rndm[0]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(0));

-- Location: MLABCELL_X60_Y4_N30
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( rndm(0) ) + ( rndm(1) ) + ( !VCC ))
-- \Add0~18\ = CARRY(( rndm(0) ) + ( rndm(1) ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_rndm(1),
	datad => ALT_INV_rndm(0),
	cin => GND,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: MLABCELL_X60_Y4_N12
\rndm[1]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \rndm[1]~feeder_combout\ = ( \Add0~17_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~17_sumout\,
	combout => \rndm[1]~feeder_combout\);

-- Location: FF_X60_Y4_N14
\rndm[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \rndm[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(1));

-- Location: MLABCELL_X60_Y4_N33
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( rndm(2) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( rndm(2) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_rndm(2),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: MLABCELL_X60_Y4_N9
\rndm[2]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \rndm[2]~feeder_combout\ = ( \Add0~21_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~21_sumout\,
	combout => \rndm[2]~feeder_combout\);

-- Location: FF_X60_Y4_N11
\rndm[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \rndm[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(2));

-- Location: MLABCELL_X60_Y4_N36
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( rndm(3) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( rndm(3) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_rndm(3),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X60_Y4_N56
\rndm[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => \Add0~25_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(3));

-- Location: MLABCELL_X60_Y4_N39
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( rndm(4) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~2\ = CARRY(( rndm(4) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_rndm(4),
	cin => \Add0~26\,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: MLABCELL_X60_Y4_N15
\rndm[4]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \rndm[4]~feeder_combout\ = ( \Add0~1_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~1_sumout\,
	combout => \rndm[4]~feeder_combout\);

-- Location: FF_X60_Y4_N17
\rndm[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \rndm[4]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(4));

-- Location: MLABCELL_X60_Y4_N42
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( rndm(5) ) + ( GND ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( rndm(5) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_rndm(5),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X60_Y4_N53
\rndm[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => \Add0~5_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(5));

-- Location: MLABCELL_X60_Y4_N45
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( rndm(6) ) + ( GND ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( rndm(6) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_rndm(6),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X60_Y4_N59
\rndm[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => \Add0~9_sumout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(6));

-- Location: MLABCELL_X60_Y4_N48
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( rndm(7) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_rndm(7),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\);

-- Location: MLABCELL_X60_Y4_N6
\rndm[7]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \rndm[7]~feeder_combout\ = ( \Add0~13_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~13_sumout\,
	combout => \rndm[7]~feeder_combout\);

-- Location: FF_X60_Y4_N8
\rndm[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \rndm[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rndm(7));

-- Location: FF_X61_Y4_N23
\random1[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => rndm(7),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(7));

-- Location: FF_X61_Y4_N41
\random2[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(7),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(7));

-- Location: FF_X60_Y4_N26
\random1[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => rndm(6),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(6));

-- Location: FF_X60_Y4_N38
\random2[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(6),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(6));

-- Location: MLABCELL_X60_Y4_N21
\random1[5]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \random1[5]~feeder_combout\ = ( rndm(5) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_rndm(5),
	combout => \random1[5]~feeder_combout\);

-- Location: FF_X60_Y4_N23
\random1[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \random1[5]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(5));

-- Location: FF_X60_Y4_N19
\random2[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(5),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(5));

-- Location: FF_X60_Y4_N16
\rndm[4]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \rndm[4]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rndm[4]~DUPLICATE_q\);

-- Location: FF_X61_Y4_N8
\random1[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => \rndm[4]~DUPLICATE_q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(4));

-- Location: FF_X61_Y4_N49
\random2[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(4),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(4));

-- Location: LABCELL_X61_Y4_N18
\hex3_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux6~0_combout\ = ( random2(4) & ( (!\on2~q\) # ((!random2(7) & (!random2(6) & !random2(5))) # (random2(7) & (!random2(6) $ (!random2(5))))) ) ) # ( !random2(4) & ( (!\on2~q\) # ((!random2(7) & (random2(6) & !random2(5)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010111010101010111010111011101010101110101010101110101110111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on2~q\,
	datab => ALT_INV_random2(7),
	datac => ALT_INV_random2(6),
	datad => ALT_INV_random2(5),
	datae => ALT_INV_random2(4),
	combout => \hex3_inst|Mux6~0_combout\);

-- Location: LABCELL_X61_Y4_N51
\hex3_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux5~0_combout\ = ( random2(5) & ( (!\on2~q\) # ((!random2(4) & (random2(6))) # (random2(4) & ((random2(7))))) ) ) # ( !random2(5) & ( (!\on2~q\) # ((random2(6) & (!random2(4) $ (!random2(7))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100010100111111110100011111111111000101001111111101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(6),
	datab => ALT_INV_random2(4),
	datac => ALT_INV_random2(7),
	datad => \ALT_INV_on2~q\,
	datae => ALT_INV_random2(5),
	combout => \hex3_inst|Mux5~0_combout\);

-- Location: LABCELL_X61_Y4_N3
\hex3_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux4~0_combout\ = ( random2(6) & ( (!\on2~q\) # ((random2(7) & ((!random2(4)) # (random2(5))))) ) ) # ( !random2(6) & ( (!\on2~q\) # ((!random2(7) & (!random2(4) & random2(5)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101011101010101010101110101010111010101110111011101010111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on2~q\,
	datab => ALT_INV_random2(7),
	datac => ALT_INV_random2(4),
	datad => ALT_INV_random2(5),
	dataf => ALT_INV_random2(6),
	combout => \hex3_inst|Mux4~0_combout\);

-- Location: LABCELL_X61_Y4_N0
\hex3_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux3~0_combout\ = ( random2(6) & ( (!\on2~q\) # ((!random2(5) & (!random2(7) & !random2(4))) # (random2(5) & ((random2(4))))) ) ) # ( !random2(6) & ( (!\on2~q\) # ((!random2(7) & (!random2(5) & random2(4))) # (random2(7) & (random2(5) & 
-- !random2(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101111101010101010111110101011101010101011111110101010101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on2~q\,
	datab => ALT_INV_random2(7),
	datac => ALT_INV_random2(5),
	datad => ALT_INV_random2(4),
	dataf => ALT_INV_random2(6),
	combout => \hex3_inst|Mux3~0_combout\);

-- Location: LABCELL_X61_Y4_N36
\hex3_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux2~0_combout\ = ( random2(4) & ( random2(7) & ( (!\on2~q\) # ((!random2(5) & !random2(6))) ) ) ) # ( !random2(4) & ( random2(7) & ( !\on2~q\ ) ) ) # ( random2(4) & ( !random2(7) ) ) # ( !random2(4) & ( !random2(7) & ( (!\on2~q\) # 
-- ((!random2(5) & random2(6))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010111010101110111111111111111110101010101010101110101011101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on2~q\,
	datab => ALT_INV_random2(5),
	datac => ALT_INV_random2(6),
	datae => ALT_INV_random2(4),
	dataf => ALT_INV_random2(7),
	combout => \hex3_inst|Mux2~0_combout\);

-- Location: LABCELL_X61_Y4_N15
\hex3_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux1~0_combout\ = ( random2(5) & ( (!\on2~q\) # ((!random2(7) & ((!random2(6)) # (random2(4))))) ) ) # ( !random2(5) & ( (!\on2~q\) # ((random2(4) & (!random2(6) $ (random2(7))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100100001111111110010000111111111101100001111111110110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(6),
	datab => ALT_INV_random2(4),
	datac => ALT_INV_random2(7),
	datad => \ALT_INV_on2~q\,
	dataf => ALT_INV_random2(5),
	combout => \hex3_inst|Mux1~0_combout\);

-- Location: LABCELL_X61_Y4_N12
\hex3_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux0~0_combout\ = ( random2(7) & ( (!\on2~q\) # ((random2(6) & (!random2(4) & !random2(5)))) ) ) # ( !random2(7) & ( (!\on2~q\) # ((!random2(6) & ((!random2(5)))) # (random2(6) & (random2(4) & random2(5)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111101011110001111110101111000111110100111100001111010011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(6),
	datab => ALT_INV_random2(4),
	datac => \ALT_INV_on2~q\,
	datad => ALT_INV_random2(5),
	dataf => ALT_INV_random2(7),
	combout => \hex3_inst|Mux0~0_combout\);

-- Location: FF_X59_Y4_N2
\random1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => rndm(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(3));

-- Location: FF_X59_Y4_N20
\random2[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(3));

-- Location: FF_X59_Y4_N59
\random1[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => rndm(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(2));

-- Location: FF_X59_Y4_N44
\random2[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(2));

-- Location: FF_X59_Y4_N41
\random1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => rndm(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(1));

-- Location: FF_X59_Y4_N56
\random2[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(1));

-- Location: FF_X59_Y4_N29
\random1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => rndm(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random1(0));

-- Location: FF_X59_Y4_N8
\random2[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => random2(0));

-- Location: LABCELL_X59_Y4_N9
\hex2_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux6~0_combout\ = ( random2(1) & ( random2(0) & ( (!\on2~q\) # ((random2(3) & !random2(2))) ) ) ) # ( !random2(1) & ( random2(0) & ( (!\on2~q\) # (!random2(3) $ (random2(2))) ) ) ) # ( random2(1) & ( !random2(0) & ( !\on2~q\ ) ) ) # ( 
-- !random2(1) & ( !random2(0) & ( (!\on2~q\) # ((!random2(3) & random2(2))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100111011001110110011001100110011101101111011011101110011011100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(3),
	datab => \ALT_INV_on2~q\,
	datac => ALT_INV_random2(2),
	datae => ALT_INV_random2(1),
	dataf => ALT_INV_random2(0),
	combout => \hex2_inst|Mux6~0_combout\);

-- Location: FF_X59_Y4_N55
\random2[1]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	asdata => random1(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \random2[1]~DUPLICATE_q\);

-- Location: LABCELL_X59_Y4_N30
\hex2_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux5~0_combout\ = ( random2(0) & ( (!\on2~q\) # ((!random2(3) & (random2(2) & !\random2[1]~DUPLICATE_q\)) # (random2(3) & ((\random2[1]~DUPLICATE_q\)))) ) ) # ( !random2(0) & ( (!\on2~q\) # ((random2(2) & ((\random2[1]~DUPLICATE_q\) # 
-- (random2(3))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000111110011111100011111001111110010111101011111001011110101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(3),
	datab => ALT_INV_random2(2),
	datac => \ALT_INV_on2~q\,
	datad => \ALT_INV_random2[1]~DUPLICATE_q\,
	dataf => ALT_INV_random2(0),
	combout => \hex2_inst|Mux5~0_combout\);

-- Location: LABCELL_X59_Y4_N33
\hex2_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux4~0_combout\ = ( random2(0) & ( (!\on2~q\) # ((random2(3) & (random2(2) & \random2[1]~DUPLICATE_q\))) ) ) # ( !random2(0) & ( (!\on2~q\) # ((!random2(3) & (!random2(2) & \random2[1]~DUPLICATE_q\)) # (random2(3) & (random2(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100011001111111110001100111111111000000011111111100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(3),
	datab => ALT_INV_random2(2),
	datac => \ALT_INV_random2[1]~DUPLICATE_q\,
	datad => \ALT_INV_on2~q\,
	dataf => ALT_INV_random2(0),
	combout => \hex2_inst|Mux4~0_combout\);

-- Location: LABCELL_X59_Y4_N36
\hex2_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux3~0_combout\ = ( \random2[1]~DUPLICATE_q\ & ( (!\on2~q\) # ((!random2(0) & (random2(3) & !random2(2))) # (random2(0) & ((random2(2))))) ) ) # ( !\random2[1]~DUPLICATE_q\ & ( (!\on2~q\) # ((!random2(3) & (!random2(0) $ (!random2(2))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011101011101010101011101011101110111010111010101010111010111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on2~q\,
	datab => ALT_INV_random2(0),
	datac => ALT_INV_random2(3),
	datad => ALT_INV_random2(2),
	datae => \ALT_INV_random2[1]~DUPLICATE_q\,
	combout => \hex2_inst|Mux3~0_combout\);

-- Location: LABCELL_X59_Y4_N24
\hex2_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux2~0_combout\ = ( \random2[1]~DUPLICATE_q\ & ( (!\on2~q\) # ((!random2(3) & random2(0))) ) ) # ( !\random2[1]~DUPLICATE_q\ & ( (!\on2~q\) # ((!random2(2) & ((random2(0)))) # (random2(2) & (!random2(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011101011111110101010101111101010111010111111101010101011111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on2~q\,
	datab => ALT_INV_random2(2),
	datac => ALT_INV_random2(3),
	datad => ALT_INV_random2(0),
	datae => \ALT_INV_random2[1]~DUPLICATE_q\,
	combout => \hex2_inst|Mux2~0_combout\);

-- Location: LABCELL_X59_Y4_N15
\hex2_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux1~0_combout\ = ( random2(0) & ( (!\on2~q\) # (!random2(3) $ (((random2(2) & !\random2[1]~DUPLICATE_q\)))) ) ) # ( !random2(0) & ( (!\on2~q\) # ((!random2(3) & (!random2(2) & \random2[1]~DUPLICATE_q\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011111000111100001111100011111001111110101111100111111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(3),
	datab => ALT_INV_random2(2),
	datac => \ALT_INV_on2~q\,
	datad => \ALT_INV_random2[1]~DUPLICATE_q\,
	dataf => ALT_INV_random2(0),
	combout => \hex2_inst|Mux1~0_combout\);

-- Location: LABCELL_X59_Y4_N12
\hex2_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux0~0_combout\ = ( random2(0) & ( (!\on2~q\) # ((!random2(3) & (!random2(2) $ (random2(1))))) ) ) # ( !random2(0) & ( (!\on2~q\) # ((!random2(1) & (!random2(3) $ (random2(2))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111110010000111111111001000011111111100000101111111110000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random2(3),
	datab => ALT_INV_random2(2),
	datac => ALT_INV_random2(1),
	datad => \ALT_INV_on2~q\,
	dataf => ALT_INV_random2(0),
	combout => \hex2_inst|Mux0~0_combout\);

-- Location: FF_X61_Y4_N34
\on1~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \KEY[0]~inputCLKENA0_outclk\,
	d => \on1~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \on1~DUPLICATE_q\);

-- Location: LABCELL_X61_Y4_N27
\hex1_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux6~0_combout\ = ( \on1~DUPLICATE_q\ & ( (!random1(6) & (random1(4) & (!random1(5) $ (random1(7))))) # (random1(6) & (!random1(5) & (!random1(4) $ (random1(7))))) ) ) # ( !\on1~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100101000000100100010100000010010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(5),
	datab => ALT_INV_random1(4),
	datac => ALT_INV_random1(6),
	datad => ALT_INV_random1(7),
	dataf => \ALT_INV_on1~DUPLICATE_q\,
	combout => \hex1_inst|Mux6~0_combout\);

-- Location: LABCELL_X61_Y4_N24
\hex1_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux5~0_combout\ = ( \on1~DUPLICATE_q\ & ( (!random1(5) & (random1(6) & (!random1(4) $ (!random1(7))))) # (random1(5) & ((!random1(4) & (random1(6))) # (random1(4) & ((random1(7)))))) ) ) # ( !\on1~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000110000111010000011000011101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(5),
	datab => ALT_INV_random1(4),
	datac => ALT_INV_random1(6),
	datad => ALT_INV_random1(7),
	dataf => \ALT_INV_on1~DUPLICATE_q\,
	combout => \hex1_inst|Mux5~0_combout\);

-- Location: LABCELL_X61_Y4_N9
\hex1_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux4~0_combout\ = ( random1(7) & ( random1(6) & ( (!\on1~DUPLICATE_q\) # ((!random1(4)) # (random1(5))) ) ) ) # ( !random1(7) & ( random1(6) & ( !\on1~DUPLICATE_q\ ) ) ) # ( random1(7) & ( !random1(6) & ( !\on1~DUPLICATE_q\ ) ) ) # ( 
-- !random1(7) & ( !random1(6) & ( (!\on1~DUPLICATE_q\) # ((random1(5) & !random1(4))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010111110101010101010101010101010101010101010101111111110101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on1~DUPLICATE_q\,
	datac => ALT_INV_random1(5),
	datad => ALT_INV_random1(4),
	datae => ALT_INV_random1(7),
	dataf => ALT_INV_random1(6),
	combout => \hex1_inst|Mux4~0_combout\);

-- Location: LABCELL_X61_Y4_N45
\hex1_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux3~0_combout\ = ( \on1~DUPLICATE_q\ & ( (!random1(5) & (!random1(7) & (!random1(6) $ (!random1(4))))) # (random1(5) & ((!random1(6) & (!random1(4) & random1(7))) # (random1(6) & (random1(4))))) ) ) # ( !\on1~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111101001001001000010100100100100001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(6),
	datab => ALT_INV_random1(5),
	datac => ALT_INV_random1(4),
	datad => ALT_INV_random1(7),
	dataf => \ALT_INV_on1~DUPLICATE_q\,
	combout => \hex1_inst|Mux3~0_combout\);

-- Location: LABCELL_X61_Y4_N42
\hex1_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux2~0_combout\ = ( random1(4) & ( (!\on1~DUPLICATE_q\) # ((!random1(7)) # ((!random1(6) & !random1(5)))) ) ) # ( !random1(4) & ( (!\on1~DUPLICATE_q\) # ((random1(6) & (!random1(5) & !random1(7)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111010011110000111101001111000011111111111110001111111111111000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(6),
	datab => ALT_INV_random1(5),
	datac => \ALT_INV_on1~DUPLICATE_q\,
	datad => ALT_INV_random1(7),
	dataf => ALT_INV_random1(4),
	combout => \hex1_inst|Mux2~0_combout\);

-- Location: LABCELL_X61_Y4_N54
\hex1_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux1~0_combout\ = ( random1(4) & ( (!\on1~DUPLICATE_q\) # (!random1(7) $ (((random1(6) & !random1(5))))) ) ) # ( !random1(4) & ( (!\on1~DUPLICATE_q\) # ((!random1(6) & (random1(5) & !random1(7)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111001011110000111100101111000011111011111101001111101111110100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(6),
	datab => ALT_INV_random1(5),
	datac => \ALT_INV_on1~DUPLICATE_q\,
	datad => ALT_INV_random1(7),
	dataf => ALT_INV_random1(4),
	combout => \hex1_inst|Mux1~0_combout\);

-- Location: LABCELL_X61_Y4_N57
\hex1_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux0~0_combout\ = ( \on1~DUPLICATE_q\ & ( (!random1(4) & (!random1(5) & (!random1(6) $ (random1(7))))) # (random1(4) & (!random1(7) & (!random1(6) $ (random1(5))))) ) ) # ( !\on1~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111110001001010000001000100101000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(6),
	datab => ALT_INV_random1(5),
	datac => ALT_INV_random1(4),
	datad => ALT_INV_random1(7),
	dataf => \ALT_INV_on1~DUPLICATE_q\,
	combout => \hex1_inst|Mux0~0_combout\);

-- Location: LABCELL_X59_Y4_N0
\hex0_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux6~0_combout\ = ( random1(2) & ( (!\on1~DUPLICATE_q\) # ((!random1(1) & (!random1(0) $ (random1(3))))) ) ) # ( !random1(2) & ( (!\on1~DUPLICATE_q\) # ((random1(0) & (!random1(1) $ (random1(3))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011101010101011101110101010101111101010101110101110101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on1~DUPLICATE_q\,
	datab => ALT_INV_random1(0),
	datac => ALT_INV_random1(1),
	datad => ALT_INV_random1(3),
	dataf => ALT_INV_random1(2),
	combout => \hex0_inst|Mux6~0_combout\);

-- Location: LABCELL_X59_Y4_N57
\hex0_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux5~0_combout\ = ( random1(2) & ( random1(1) & ( (!\on1~DUPLICATE_q\) # ((!random1(0)) # (random1(3))) ) ) ) # ( !random1(2) & ( random1(1) & ( (!\on1~DUPLICATE_q\) # ((random1(0) & random1(3))) ) ) ) # ( random1(2) & ( !random1(1) & ( 
-- (!\on1~DUPLICATE_q\) # (!random1(0) $ (!random1(3))) ) ) ) # ( !random1(2) & ( !random1(1) & ( !\on1~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101011111111101010101010101011111111101011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on1~DUPLICATE_q\,
	datac => ALT_INV_random1(0),
	datad => ALT_INV_random1(3),
	datae => ALT_INV_random1(2),
	dataf => ALT_INV_random1(1),
	combout => \hex0_inst|Mux5~0_combout\);

-- Location: LABCELL_X59_Y4_N21
\hex0_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux4~0_combout\ = ( random1(2) & ( random1(3) & ( (!\on1~DUPLICATE_q\) # ((!random1(0)) # (random1(1))) ) ) ) # ( !random1(2) & ( random1(3) & ( !\on1~DUPLICATE_q\ ) ) ) # ( random1(2) & ( !random1(3) & ( !\on1~DUPLICATE_q\ ) ) ) # ( 
-- !random1(2) & ( !random1(3) & ( (!\on1~DUPLICATE_q\) # ((!random1(0) & random1(1))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101011101110101010101010101010101010101010101110111011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on1~DUPLICATE_q\,
	datab => ALT_INV_random1(0),
	datad => ALT_INV_random1(1),
	datae => ALT_INV_random1(2),
	dataf => ALT_INV_random1(3),
	combout => \hex0_inst|Mux4~0_combout\);

-- Location: LABCELL_X59_Y4_N45
\hex0_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux3~0_combout\ = ( random1(2) & ( (!\on1~DUPLICATE_q\) # ((!random1(0) & (!random1(1) & !random1(3))) # (random1(0) & (random1(1)))) ) ) # ( !random1(2) & ( (!\on1~DUPLICATE_q\) # ((!random1(0) & (random1(1) & random1(3))) # (random1(0) & 
-- (!random1(1) & !random1(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011101010101110111010111010101110111010101011101110101110101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on1~DUPLICATE_q\,
	datab => ALT_INV_random1(0),
	datac => ALT_INV_random1(1),
	datad => ALT_INV_random1(3),
	datae => ALT_INV_random1(2),
	combout => \hex0_inst|Mux3~0_combout\);

-- Location: LABCELL_X59_Y4_N51
\hex0_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux2~0_combout\ = ( \on1~DUPLICATE_q\ & ( (!random1(1) & ((!random1(2) & ((random1(0)))) # (random1(2) & (!random1(3))))) # (random1(1) & (((!random1(3) & random1(0))))) ) ) # ( !\on1~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100100000111110000010000011111000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(1),
	datab => ALT_INV_random1(2),
	datac => ALT_INV_random1(3),
	datad => ALT_INV_random1(0),
	dataf => \ALT_INV_on1~DUPLICATE_q\,
	combout => \hex0_inst|Mux2~0_combout\);

-- Location: LABCELL_X59_Y4_N48
\hex0_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux1~0_combout\ = ( random1(3) & ( (!\on1~DUPLICATE_q\) # ((!random1(1) & (random1(2) & random1(0)))) ) ) # ( !random1(3) & ( (!\on1~DUPLICATE_q\) # ((!random1(1) & (!random1(2) & random1(0))) # (random1(1) & ((!random1(2)) # (random1(0))))) ) 
-- )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111010011111101111101001111110111110000111100101111000011110010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_random1(1),
	datab => ALT_INV_random1(2),
	datac => \ALT_INV_on1~DUPLICATE_q\,
	datad => ALT_INV_random1(0),
	dataf => ALT_INV_random1(3),
	combout => \hex0_inst|Mux1~0_combout\);

-- Location: LABCELL_X59_Y4_N3
\hex0_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux0~0_combout\ = ( random1(3) & ( (!\on1~DUPLICATE_q\) # ((!random1(0) & (!random1(1) & random1(2)))) ) ) # ( !random1(3) & ( (!\on1~DUPLICATE_q\) # ((!random1(1) & ((!random1(2)))) # (random1(1) & (random1(0) & random1(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111101010101011111110101010101110101010111010101010101011101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_on1~DUPLICATE_q\,
	datab => ALT_INV_random1(0),
	datac => ALT_INV_random1(1),
	datad => ALT_INV_random1(2),
	dataf => ALT_INV_random1(3),
	combout => \hex0_inst|Mux0~0_combout\);

-- Location: IOIBUF_X21_Y0_N18
\KEY[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(1),
	o => \KEY[1]~input_o\);

-- Location: IOIBUF_X46_Y0_N1
\KEY[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(2),
	o => \KEY[2]~input_o\);

-- Location: IOIBUF_X46_Y0_N18
\KEY[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY(3),
	o => \KEY[3]~input_o\);

-- Location: LABCELL_X54_Y6_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


