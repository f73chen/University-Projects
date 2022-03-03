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

-- DATE "03/03/2022 10:59:32"

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

ENTITY 	time_diff IS
    PORT (
	CLOCK_50_B5B : IN std_logic;
	KEY : IN std_logic_vector(3 DOWNTO 0);
	hex3 : OUT std_logic_vector(6 DOWNTO 0);
	hex2 : OUT std_logic_vector(6 DOWNTO 0);
	hex1 : OUT std_logic_vector(6 DOWNTO 0);
	hex0 : OUT std_logic_vector(6 DOWNTO 0)
	);
END time_diff;

-- Design Ports Information
-- KEY[2]	=>  Location: PIN_Y15,	 I/O Standard: 1.2 V,	 Current Strength: Default
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
-- CLOCK_50_B5B	=>  Location: PIN_R20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[3]	=>  Location: PIN_Y16,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- KEY[0]	=>  Location: PIN_P11,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- KEY[1]	=>  Location: PIN_P12,	 I/O Standard: 1.2 V,	 Current Strength: Default


ARCHITECTURE structure OF time_diff IS
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
SIGNAL \KEY[2]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50_B5B~input_o\ : std_logic;
SIGNAL \CLOCK_50_B5B~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \KEY[0]~input_o\ : std_logic;
SIGNAL \KEY[1]~input_o\ : std_logic;
SIGNAL \process_0~0_combout\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \KEY[3]~input_o\ : std_logic;
SIGNAL \diff[14]~feeder_combout\ : std_logic;
SIGNAL \diff[13]~feeder_combout\ : std_logic;
SIGNAL \hex3_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux0~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex2_inst|Mux0~0_combout\ : std_logic;
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
SIGNAL diff : std_logic_vector(15 DOWNTO 0);
SIGNAL clock : std_logic_vector(30 DOWNTO 0);
SIGNAL \ALT_INV_KEY[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_KEY[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_KEY[3]~input_o\ : std_logic;
SIGNAL \hex0_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex1_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex2_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex3_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_clock : std_logic_vector(15 DOWNTO 0);
SIGNAL ALT_INV_diff : std_logic_vector(15 DOWNTO 0);

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
\ALT_INV_KEY[1]~input_o\ <= NOT \KEY[1]~input_o\;
\ALT_INV_KEY[0]~input_o\ <= NOT \KEY[0]~input_o\;
\ALT_INV_KEY[3]~input_o\ <= NOT \KEY[3]~input_o\;
\hex0_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex0_inst|Mux0~0_combout\;
\hex1_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex1_inst|Mux0~0_combout\;
\hex2_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex2_inst|Mux0~0_combout\;
\hex3_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex3_inst|Mux0~0_combout\;
ALT_INV_clock(3) <= NOT clock(3);
ALT_INV_clock(2) <= NOT clock(2);
ALT_INV_clock(1) <= NOT clock(1);
ALT_INV_clock(0) <= NOT clock(0);
ALT_INV_clock(7) <= NOT clock(7);
ALT_INV_clock(6) <= NOT clock(6);
ALT_INV_clock(5) <= NOT clock(5);
ALT_INV_clock(4) <= NOT clock(4);
ALT_INV_clock(11) <= NOT clock(11);
ALT_INV_clock(10) <= NOT clock(10);
ALT_INV_clock(9) <= NOT clock(9);
ALT_INV_clock(8) <= NOT clock(8);
ALT_INV_clock(15) <= NOT clock(15);
ALT_INV_clock(14) <= NOT clock(14);
ALT_INV_clock(13) <= NOT clock(13);
ALT_INV_clock(12) <= NOT clock(12);
ALT_INV_diff(3) <= NOT diff(3);
ALT_INV_diff(2) <= NOT diff(2);
ALT_INV_diff(1) <= NOT diff(1);
ALT_INV_diff(0) <= NOT diff(0);
ALT_INV_diff(7) <= NOT diff(7);
ALT_INV_diff(6) <= NOT diff(6);
ALT_INV_diff(5) <= NOT diff(5);
ALT_INV_diff(4) <= NOT diff(4);
ALT_INV_diff(11) <= NOT diff(11);
ALT_INV_diff(10) <= NOT diff(10);
ALT_INV_diff(9) <= NOT diff(9);
ALT_INV_diff(8) <= NOT diff(8);
ALT_INV_diff(15) <= NOT diff(15);
ALT_INV_diff(14) <= NOT diff(14);
ALT_INV_diff(13) <= NOT diff(13);
ALT_INV_diff(12) <= NOT diff(12);

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
	i => \hex3_inst|ALT_INV_Mux0~0_combout\,
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
	i => \hex2_inst|ALT_INV_Mux0~0_combout\,
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
	i => \hex1_inst|ALT_INV_Mux0~0_combout\,
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
	i => \hex0_inst|ALT_INV_Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_hex0(6));

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

-- Location: CLKCTRL_G10
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

-- Location: LABCELL_X64_Y4_N0
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( clock(0) ) + ( VCC ) + ( !VCC ))
-- \Add0~50\ = CARRY(( clock(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(0),
	cin => GND,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

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

-- Location: LABCELL_X21_Y2_N48
\process_0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \process_0~0_combout\ = ( \KEY[1]~input_o\ & ( \KEY[0]~input_o\ ) ) # ( !\KEY[1]~input_o\ & ( !\KEY[0]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110011001100110011001100110000110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_KEY[0]~input_o\,
	dataf => \ALT_INV_KEY[1]~input_o\,
	combout => \process_0~0_combout\);

-- Location: FF_X64_Y4_N2
\clock[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~49_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(0));

-- Location: LABCELL_X64_Y4_N3
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( clock(1) ) + ( GND ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( clock(1) ) + ( GND ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(1),
	cin => \Add0~50\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X64_Y4_N5
\clock[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(1));

-- Location: LABCELL_X64_Y4_N6
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( clock(2) ) + ( GND ) + ( \Add0~54\ ))
-- \Add0~58\ = CARRY(( clock(2) ) + ( GND ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(2),
	cin => \Add0~54\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X64_Y4_N8
\clock[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(2));

-- Location: LABCELL_X64_Y4_N9
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( clock(3) ) + ( GND ) + ( \Add0~58\ ))
-- \Add0~62\ = CARRY(( clock(3) ) + ( GND ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(3),
	cin => \Add0~58\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\);

-- Location: FF_X64_Y4_N11
\clock[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(3));

-- Location: LABCELL_X64_Y4_N12
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( clock(4) ) + ( GND ) + ( \Add0~62\ ))
-- \Add0~34\ = CARRY(( clock(4) ) + ( GND ) + ( \Add0~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(4),
	cin => \Add0~62\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X64_Y4_N14
\clock[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(4));

-- Location: LABCELL_X64_Y4_N15
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( clock(5) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( clock(5) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(5),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X64_Y4_N17
\clock[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(5));

-- Location: LABCELL_X64_Y4_N18
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( clock(6) ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~42\ = CARRY(( clock(6) ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(6),
	cin => \Add0~38\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: FF_X64_Y4_N20
\clock[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(6));

-- Location: LABCELL_X64_Y4_N21
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( clock(7) ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~46\ = CARRY(( clock(7) ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(7),
	cin => \Add0~42\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: FF_X64_Y4_N23
\clock[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(7));

-- Location: LABCELL_X64_Y4_N24
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( clock(8) ) + ( GND ) + ( \Add0~46\ ))
-- \Add0~18\ = CARRY(( clock(8) ) + ( GND ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(8),
	cin => \Add0~46\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X64_Y4_N26
\clock[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(8));

-- Location: LABCELL_X64_Y4_N27
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( clock(9) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( clock(9) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(9),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X64_Y4_N29
\clock[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(9));

-- Location: LABCELL_X64_Y4_N30
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( clock(10) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( clock(10) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(10),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X64_Y4_N32
\clock[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(10));

-- Location: LABCELL_X64_Y4_N33
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( clock(11) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( clock(11) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_clock(11),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X64_Y4_N35
\clock[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(11));

-- Location: LABCELL_X64_Y4_N36
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( clock(12) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~2\ = CARRY(( clock(12) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(12),
	cin => \Add0~30\,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: FF_X64_Y4_N38
\clock[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(12));

-- Location: LABCELL_X64_Y4_N39
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( clock(13) ) + ( GND ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( clock(13) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(13),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X64_Y4_N41
\clock[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(13));

-- Location: LABCELL_X64_Y4_N42
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( clock(14) ) + ( GND ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( clock(14) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(14),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X64_Y4_N44
\clock[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(14));

-- Location: LABCELL_X64_Y4_N45
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( clock(15) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(15),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\);

-- Location: FF_X64_Y4_N47
\clock[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(15));

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

-- Location: FF_X65_Y4_N2
\diff[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(15),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(15));

-- Location: LABCELL_X65_Y4_N45
\diff[14]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \diff[14]~feeder_combout\ = ( clock(14) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_clock(14),
	combout => \diff[14]~feeder_combout\);

-- Location: FF_X65_Y4_N47
\diff[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \diff[14]~feeder_combout\,
	sclr => \ALT_INV_KEY[3]~input_o\,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(14));

-- Location: FF_X65_Y4_N38
\diff[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(12),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(12));

-- Location: LABCELL_X65_Y4_N42
\diff[13]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \diff[13]~feeder_combout\ = ( clock(13) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_clock(13),
	combout => \diff[13]~feeder_combout\);

-- Location: FF_X65_Y4_N44
\diff[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \diff[13]~feeder_combout\,
	sclr => \ALT_INV_KEY[3]~input_o\,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(13));

-- Location: LABCELL_X65_Y4_N24
\hex3_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux6~0_combout\ = ( diff(13) & ( (diff(15) & (!diff(14) & diff(12))) ) ) # ( !diff(13) & ( (!diff(15) & (!diff(14) $ (!diff(12)))) # (diff(15) & (diff(14) & diff(12))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010100100101001001010010010100100000100000001000000010000000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datab => ALT_INV_diff(14),
	datac => ALT_INV_diff(12),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux6~0_combout\);

-- Location: LABCELL_X65_Y4_N27
\hex3_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux5~0_combout\ = ( diff(13) & ( (!diff(12) & ((diff(14)))) # (diff(12) & (diff(15))) ) ) # ( !diff(13) & ( (diff(14) & (!diff(15) $ (!diff(12)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100001010000001010000101000001111010101010000111101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datac => ALT_INV_diff(14),
	datad => ALT_INV_diff(12),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux5~0_combout\);

-- Location: LABCELL_X65_Y4_N6
\hex3_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux4~0_combout\ = ( diff(14) & ( diff(13) & ( diff(15) ) ) ) # ( !diff(14) & ( diff(13) & ( (!diff(12) & !diff(15)) ) ) ) # ( diff(14) & ( !diff(13) & ( (!diff(12) & diff(15)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000010100000101010100000101000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(12),
	datac => ALT_INV_diff(15),
	datae => ALT_INV_diff(14),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux4~0_combout\);

-- Location: LABCELL_X65_Y4_N18
\hex3_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux3~0_combout\ = ( diff(13) & ( (!diff(14) & (diff(15) & !diff(12))) # (diff(14) & ((diff(12)))) ) ) # ( !diff(13) & ( (!diff(15) & (!diff(14) $ (!diff(12)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010100000101000001010000010100001000011010000110100001101000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datab => ALT_INV_diff(14),
	datac => ALT_INV_diff(12),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux3~0_combout\);

-- Location: LABCELL_X65_Y4_N21
\hex3_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux2~0_combout\ = ( diff(13) & ( (!diff(15) & diff(12)) ) ) # ( !diff(13) & ( (!diff(14) & ((diff(12)))) # (diff(14) & (!diff(15))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101011111010000010101111101000000000101010100000000010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datac => ALT_INV_diff(14),
	datad => ALT_INV_diff(12),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y4_N15
\hex3_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux1~0_combout\ = ( diff(13) & ( (!diff(15) & ((!diff(14)) # (diff(12)))) ) ) # ( !diff(13) & ( (diff(12) & (!diff(15) $ (diff(14)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010011001000000001001100110001000101010101000100010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datab => ALT_INV_diff(14),
	datad => ALT_INV_diff(12),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux1~0_combout\);

-- Location: LABCELL_X65_Y4_N12
\hex3_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux0~0_combout\ = ( diff(13) & ( (!diff(14)) # ((!diff(12)) # (diff(15))) ) ) # ( !diff(13) & ( (!diff(14) & (diff(15))) # (diff(14) & ((!diff(15)) # (diff(12)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111111001111000011111111111111110011111111111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(14),
	datac => ALT_INV_diff(15),
	datad => ALT_INV_diff(12),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux0~0_combout\);

-- Location: FF_X65_Y4_N50
\diff[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(9),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(9));

-- Location: FF_X65_Y4_N11
\diff[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(8),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(8));

-- Location: FF_X65_Y4_N32
\diff[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(10),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(10));

-- Location: FF_X65_Y4_N53
\diff[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(11),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(11));

-- Location: LABCELL_X65_Y4_N33
\hex2_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux6~0_combout\ = ( diff(11) & ( (diff(8) & (!diff(9) $ (!diff(10)))) ) ) # ( !diff(11) & ( (!diff(9) & (!diff(8) $ (!diff(10)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010100000101000001010000010100000010010000100100001001000010010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(9),
	datab => ALT_INV_diff(8),
	datac => ALT_INV_diff(10),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux6~0_combout\);

-- Location: LABCELL_X65_Y4_N54
\hex2_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux5~0_combout\ = ( diff(10) & ( (!diff(9) & (!diff(8) $ (!diff(11)))) # (diff(9) & ((!diff(8)) # (diff(11)))) ) ) # ( !diff(10) & ( (diff(9) & (diff(8) & diff(11))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000000010000000101101101011011010110110101101101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(9),
	datab => ALT_INV_diff(8),
	datac => ALT_INV_diff(11),
	dataf => ALT_INV_diff(10),
	combout => \hex2_inst|Mux5~0_combout\);

-- Location: LABCELL_X65_Y4_N57
\hex2_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux4~0_combout\ = ( diff(11) & ( (diff(10) & ((!diff(8)) # (diff(9)))) ) ) # ( !diff(11) & ( (diff(9) & (!diff(8) & !diff(10))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100000001000000010000000100000000001101000011010000110100001101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(9),
	datab => ALT_INV_diff(8),
	datac => ALT_INV_diff(10),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux4~0_combout\);

-- Location: LABCELL_X65_Y4_N3
\hex2_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux3~0_combout\ = ( diff(11) & ( (diff(9) & (!diff(10) $ (diff(8)))) ) ) # ( !diff(11) & ( (!diff(9) & (!diff(10) $ (!diff(8)))) # (diff(9) & (diff(10) & diff(8))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010100100101001001010010010100101000001010000010100000101000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(9),
	datab => ALT_INV_diff(10),
	datac => ALT_INV_diff(8),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux3~0_combout\);

-- Location: LABCELL_X65_Y4_N39
\hex2_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux2~0_combout\ = ( diff(11) & ( (!diff(9) & (!diff(10) & diff(8))) ) ) # ( !diff(11) & ( ((!diff(9) & diff(10))) # (diff(8)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010111100101111001011110010111100001000000010000000100000001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(9),
	datab => ALT_INV_diff(10),
	datac => ALT_INV_diff(8),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y4_N30
\hex2_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux1~0_combout\ = ( diff(11) & ( (!diff(9) & (diff(8) & diff(10))) ) ) # ( !diff(11) & ( (!diff(9) & (diff(8) & !diff(10))) # (diff(9) & ((!diff(10)) # (diff(8)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011100010001011101110001000100000000001000100000000000100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(9),
	datab => ALT_INV_diff(8),
	datad => ALT_INV_diff(10),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux1~0_combout\);

-- Location: LABCELL_X65_Y4_N51
\hex2_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux0~0_combout\ = ( diff(11) & ( diff(8) ) ) # ( !diff(11) & ( diff(8) & ( !diff(9) $ (!diff(10)) ) ) ) # ( diff(11) & ( !diff(8) & ( (!diff(10)) # (diff(9)) ) ) ) # ( !diff(11) & ( !diff(8) & ( (diff(10)) # (diff(9)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111111101011111010101011010010110101111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(9),
	datac => ALT_INV_diff(10),
	datae => ALT_INV_diff(11),
	dataf => ALT_INV_diff(8),
	combout => \hex2_inst|Mux0~0_combout\);

-- Location: FF_X64_Y2_N35
\diff[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(5),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(5));

-- Location: FF_X64_Y2_N44
\diff[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(7),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(7));

-- Location: FF_X64_Y2_N5
\diff[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(6),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(6));

-- Location: FF_X64_Y2_N50
\diff[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(4),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(4));

-- Location: LABCELL_X64_Y2_N21
\hex1_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux6~0_combout\ = ( diff(4) & ( (!diff(5) & (!diff(7) $ (diff(6)))) # (diff(5) & (diff(7) & !diff(6))) ) ) # ( !diff(4) & ( (!diff(5) & (!diff(7) & diff(6))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010001000000000001000100010011001001000101001100100100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(5),
	datab => ALT_INV_diff(7),
	datad => ALT_INV_diff(6),
	dataf => ALT_INV_diff(4),
	combout => \hex1_inst|Mux6~0_combout\);

-- Location: LABCELL_X64_Y2_N39
\hex1_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux5~0_combout\ = ( diff(4) & ( (!diff(5) & (!diff(7) & diff(6))) # (diff(5) & (diff(7))) ) ) # ( !diff(4) & ( (diff(6) & ((diff(7)) # (diff(5)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001011111000000000101111100000101101001010000010110100101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(5),
	datac => ALT_INV_diff(7),
	datad => ALT_INV_diff(6),
	dataf => ALT_INV_diff(4),
	combout => \hex1_inst|Mux5~0_combout\);

-- Location: LABCELL_X64_Y2_N18
\hex1_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux4~0_combout\ = ( diff(4) & ( (diff(7) & (diff(5) & diff(6))) ) ) # ( !diff(4) & ( (!diff(7) & (diff(5) & !diff(6))) # (diff(7) & ((diff(6)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000110011000011000011001100000000000000110000000000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(7),
	datac => ALT_INV_diff(5),
	datad => ALT_INV_diff(6),
	dataf => ALT_INV_diff(4),
	combout => \hex1_inst|Mux4~0_combout\);

-- Location: LABCELL_X64_Y2_N0
\hex1_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux3~0_combout\ = ( diff(6) & ( (!diff(5) & (!diff(7) & !diff(4))) # (diff(5) & ((diff(4)))) ) ) # ( !diff(6) & ( (!diff(5) & (!diff(7) & diff(4))) # (diff(5) & (diff(7) & !diff(4))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001100000011000100001011000010100011000000110001000010110000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(5),
	datab => ALT_INV_diff(7),
	datac => ALT_INV_diff(4),
	datae => ALT_INV_diff(6),
	combout => \hex1_inst|Mux3~0_combout\);

-- Location: LABCELL_X64_Y2_N30
\hex1_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux2~0_combout\ = ( diff(6) & ( (!diff(7) & ((!diff(5)) # (diff(4)))) ) ) # ( !diff(6) & ( (diff(4) & ((!diff(5)) # (!diff(7)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111000001110100011001000110000001110000011101000110010001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(5),
	datab => ALT_INV_diff(7),
	datac => ALT_INV_diff(4),
	datae => ALT_INV_diff(6),
	combout => \hex1_inst|Mux2~0_combout\);

-- Location: LABCELL_X64_Y2_N15
\hex1_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux1~0_combout\ = ( diff(6) & ( (diff(4) & (!diff(7) $ (!diff(5)))) ) ) # ( !diff(6) & ( (!diff(7) & ((diff(5)) # (diff(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000011110000000001010101000001010000111100000000010101010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(4),
	datac => ALT_INV_diff(7),
	datad => ALT_INV_diff(5),
	datae => ALT_INV_diff(6),
	combout => \hex1_inst|Mux1~0_combout\);

-- Location: LABCELL_X64_Y2_N51
\hex1_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux0~0_combout\ = ( diff(5) & ( (!diff(4)) # ((!diff(6)) # (diff(7))) ) ) # ( !diff(5) & ( (!diff(7) & ((diff(6)))) # (diff(7) & ((!diff(6)) # (diff(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111111110101000011111111010111111111101011111111111110101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(4),
	datac => ALT_INV_diff(7),
	datad => ALT_INV_diff(6),
	dataf => ALT_INV_diff(5),
	combout => \hex1_inst|Mux0~0_combout\);

-- Location: FF_X64_Y2_N56
\diff[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(1),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(1));

-- Location: FF_X64_Y2_N59
\diff[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(2),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(2));

-- Location: FF_X64_Y2_N14
\diff[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(0),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(0));

-- Location: FF_X64_Y2_N26
\diff[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(3),
	sclr => \ALT_INV_KEY[3]~input_o\,
	sload => VCC,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(3));

-- Location: LABCELL_X64_Y2_N27
\hex0_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux6~0_combout\ = ( diff(3) & ( (diff(0) & (!diff(1) $ (!diff(2)))) ) ) # ( !diff(3) & ( (!diff(1) & (!diff(2) $ (!diff(0)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010100000101000001010000010100000000110000001100000011000000110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(1),
	datab => ALT_INV_diff(2),
	datac => ALT_INV_diff(0),
	dataf => ALT_INV_diff(3),
	combout => \hex0_inst|Mux6~0_combout\);

-- Location: LABCELL_X64_Y2_N6
\hex0_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux5~0_combout\ = ( diff(0) & ( (!diff(3) & (diff(2) & !diff(1))) # (diff(3) & ((diff(1)))) ) ) # ( !diff(0) & ( (diff(2) & ((diff(1)) # (diff(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001001100010011000100110001001100100101001001010010010100100101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(3),
	datab => ALT_INV_diff(2),
	datac => ALT_INV_diff(1),
	dataf => ALT_INV_diff(0),
	combout => \hex0_inst|Mux5~0_combout\);

-- Location: LABCELL_X64_Y2_N9
\hex0_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux4~0_combout\ = ( diff(3) & ( (diff(2) & ((!diff(0)) # (diff(1)))) ) ) # ( !diff(3) & ( (!diff(2) & (!diff(0) & diff(1))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011000000000000001100000000110000001100110011000000110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(2),
	datac => ALT_INV_diff(0),
	datad => ALT_INV_diff(1),
	dataf => ALT_INV_diff(3),
	combout => \hex0_inst|Mux4~0_combout\);

-- Location: LABCELL_X64_Y2_N45
\hex0_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux3~0_combout\ = ( diff(3) & ( (diff(1) & (!diff(0) $ (diff(2)))) ) ) # ( !diff(3) & ( (!diff(1) & (!diff(0) $ (!diff(2)))) # (diff(1) & (diff(0) & diff(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010100100101001001010010010100101000001010000010100000101000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(1),
	datab => ALT_INV_diff(0),
	datac => ALT_INV_diff(2),
	dataf => ALT_INV_diff(3),
	combout => \hex0_inst|Mux3~0_combout\);

-- Location: LABCELL_X64_Y2_N36
\hex0_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux2~0_combout\ = ( diff(3) & ( (diff(0) & (!diff(1) & !diff(2))) ) ) # ( !diff(3) & ( ((!diff(1) & diff(2))) # (diff(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001111110011001100111111001100110000000000000011000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(0),
	datac => ALT_INV_diff(1),
	datad => ALT_INV_diff(2),
	dataf => ALT_INV_diff(3),
	combout => \hex0_inst|Mux2~0_combout\);

-- Location: LABCELL_X64_Y2_N57
\hex0_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux1~0_combout\ = ( diff(2) & ( (diff(0) & (!diff(1) $ (!diff(3)))) ) ) # ( !diff(2) & ( (!diff(3) & ((diff(0)) # (diff(1)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000000000001010000101001011111000000000000010100001010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(1),
	datac => ALT_INV_diff(0),
	datad => ALT_INV_diff(3),
	datae => ALT_INV_diff(2),
	combout => \hex0_inst|Mux1~0_combout\);

-- Location: LABCELL_X64_Y2_N24
\hex0_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux0~0_combout\ = ( diff(0) & ( (!diff(2) $ (!diff(1))) # (diff(3)) ) ) # ( !diff(0) & ( (!diff(2) $ (!diff(3))) # (diff(1)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111111001111001111111100111100111100111111110011110011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(2),
	datac => ALT_INV_diff(1),
	datad => ALT_INV_diff(3),
	dataf => ALT_INV_diff(0),
	combout => \hex0_inst|Mux0~0_combout\);

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

-- Location: LABCELL_X7_Y5_N0
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


