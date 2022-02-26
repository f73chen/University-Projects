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

-- DATE "02/26/2022 01:25:57"

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
	KEY : IN std_logic_vector(1 DOWNTO 0);
	hex3 : OUT std_logic_vector(6 DOWNTO 0);
	hex2 : OUT std_logic_vector(6 DOWNTO 0);
	hex1 : OUT std_logic_vector(6 DOWNTO 0);
	hex0 : OUT std_logic_vector(6 DOWNTO 0)
	);
END time_diff;

-- Design Ports Information
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
SIGNAL ww_KEY : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_hex3 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex2 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex1 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex0 : std_logic_vector(6 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50_B5B~input_o\ : std_logic;
SIGNAL \CLOCK_50_B5B~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \KEY[0]~input_o\ : std_logic;
SIGNAL \KEY[1]~input_o\ : std_logic;
SIGNAL \divider~0_combout\ : std_logic;
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
SIGNAL clock : std_logic_vector(30 DOWNTO 0);
SIGNAL diff : std_logic_vector(15 DOWNTO 0);
SIGNAL \ALT_INV_KEY[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_KEY[0]~input_o\ : std_logic;
SIGNAL \hex0_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_diff : std_logic_vector(15 DOWNTO 0);
SIGNAL \hex1_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex2_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex3_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_clock : std_logic_vector(15 DOWNTO 0);

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
\hex0_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex0_inst|Mux0~0_combout\;
ALT_INV_diff(3) <= NOT diff(3);
ALT_INV_diff(2) <= NOT diff(2);
ALT_INV_diff(1) <= NOT diff(1);
ALT_INV_diff(0) <= NOT diff(0);
\hex1_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex1_inst|Mux0~0_combout\;
ALT_INV_diff(7) <= NOT diff(7);
ALT_INV_diff(6) <= NOT diff(6);
ALT_INV_diff(5) <= NOT diff(5);
ALT_INV_diff(4) <= NOT diff(4);
\hex2_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex2_inst|Mux0~0_combout\;
ALT_INV_diff(11) <= NOT diff(11);
ALT_INV_diff(10) <= NOT diff(10);
ALT_INV_diff(9) <= NOT diff(9);
ALT_INV_diff(8) <= NOT diff(8);
\hex3_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex3_inst|Mux0~0_combout\;
ALT_INV_diff(15) <= NOT diff(15);
ALT_INV_diff(14) <= NOT diff(14);
ALT_INV_diff(13) <= NOT diff(13);
ALT_INV_diff(12) <= NOT diff(12);
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

-- Location: LABCELL_X27_Y4_N12
\divider~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \divider~0_combout\ = ( \KEY[1]~input_o\ & ( \KEY[0]~input_o\ ) ) # ( !\KEY[1]~input_o\ & ( !\KEY[0]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_KEY[0]~input_o\,
	dataf => \ALT_INV_KEY[1]~input_o\,
	combout => \divider~0_combout\);

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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
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
	sclr => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(13));

-- Location: FF_X65_Y4_N11
\diff[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(13),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(13));

-- Location: FF_X65_Y4_N53
\diff[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(12),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(12));

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
	sclr => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(14));

-- Location: FF_X65_Y4_N8
\diff[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(14),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(14));

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
	sclr => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(15));

-- Location: FF_X65_Y4_N14
\diff[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(15),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(15));

-- Location: LABCELL_X65_Y4_N42
\hex3_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux6~0_combout\ = ( diff(15) & ( (diff(12) & (!diff(13) $ (!diff(14)))) ) ) # ( !diff(15) & ( (!diff(13) & (!diff(12) $ (!diff(14)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110011000000000011001100000000000011000011000000001100001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(12),
	datad => ALT_INV_diff(14),
	dataf => ALT_INV_diff(15),
	combout => \hex3_inst|Mux6~0_combout\);

-- Location: LABCELL_X65_Y4_N27
\hex3_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux5~0_combout\ = ( diff(12) & ( (!diff(13) & (!diff(15) & diff(14))) # (diff(13) & (diff(15))) ) ) # ( !diff(12) & ( (diff(14) & ((diff(15)) # (diff(13)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000111111000000000011111100000011110000110000001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(15),
	datad => ALT_INV_diff(14),
	dataf => ALT_INV_diff(12),
	combout => \hex3_inst|Mux5~0_combout\);

-- Location: LABCELL_X65_Y4_N15
\hex3_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux4~0_combout\ = ( diff(15) & ( (diff(14) & ((!diff(12)) # (diff(13)))) ) ) # ( !diff(15) & ( (!diff(12) & (diff(13) & !diff(14))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000100000001000000010000000001011000010110000101100001011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(12),
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(14),
	dataf => ALT_INV_diff(15),
	combout => \hex3_inst|Mux4~0_combout\);

-- Location: LABCELL_X65_Y4_N51
\hex3_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux3~0_combout\ = ( diff(12) & ( diff(15) & ( (diff(13) & diff(14)) ) ) ) # ( !diff(12) & ( diff(15) & ( (diff(13) & !diff(14)) ) ) ) # ( diff(12) & ( !diff(15) & ( !diff(13) $ (diff(14)) ) ) ) # ( !diff(12) & ( !diff(15) & ( (!diff(13) & 
-- diff(14)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100110000111100001100110000001100000000001100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(14),
	datae => ALT_INV_diff(12),
	dataf => ALT_INV_diff(15),
	combout => \hex3_inst|Mux3~0_combout\);

-- Location: LABCELL_X65_Y4_N9
\hex3_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux2~0_combout\ = (!diff(13) & ((!diff(14) & (diff(12))) # (diff(14) & ((!diff(15)))))) # (diff(13) & (diff(12) & (!diff(15))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101110001000100010111000100010001011100010001000101110001000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(12),
	datab => ALT_INV_diff(15),
	datac => ALT_INV_diff(14),
	datad => ALT_INV_diff(13),
	combout => \hex3_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y4_N6
\hex3_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux1~0_combout\ = ( diff(13) & ( (!diff(15) & ((!diff(14)) # (diff(12)))) ) ) # ( !diff(13) & ( (diff(12) & (!diff(15) $ (diff(14)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010000010001010001000001000111001100010001001100110001000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(12),
	datab => ALT_INV_diff(15),
	datad => ALT_INV_diff(14),
	dataf => ALT_INV_diff(13),
	combout => \hex3_inst|Mux1~0_combout\);

-- Location: LABCELL_X65_Y4_N12
\hex3_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux0~0_combout\ = ( diff(14) & ( (!diff(12) & ((!diff(15)) # (diff(13)))) # (diff(12) & ((!diff(13)) # (diff(15)))) ) ) # ( !diff(14) & ( (diff(15)) # (diff(13)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001111111111001100111111111111101110011101111110111001110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(12),
	datab => ALT_INV_diff(13),
	datad => ALT_INV_diff(15),
	dataf => ALT_INV_diff(14),
	combout => \hex3_inst|Mux0~0_combout\);

-- Location: FF_X65_Y4_N50
\diff[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(11),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(11));

-- Location: FF_X65_Y4_N41
\diff[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(10),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(10));

-- Location: FF_X65_Y4_N38
\diff[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(9),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(9));

-- Location: FF_X65_Y4_N20
\diff[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(8),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(8));

-- Location: LABCELL_X65_Y4_N21
\hex2_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux6~0_combout\ = ( diff(8) & ( (!diff(11) & (!diff(10) & !diff(9))) # (diff(11) & (!diff(10) $ (!diff(9)))) ) ) # ( !diff(8) & ( (!diff(11) & (diff(10) & !diff(9))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000100000001000000010000010010100100101001001010010010100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(11),
	datab => ALT_INV_diff(10),
	datac => ALT_INV_diff(9),
	dataf => ALT_INV_diff(8),
	combout => \hex2_inst|Mux6~0_combout\);

-- Location: LABCELL_X65_Y4_N30
\hex2_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux5~0_combout\ = ( diff(11) & ( (!diff(8) & (diff(10))) # (diff(8) & ((diff(9)))) ) ) # ( !diff(11) & ( (diff(10) & (!diff(8) $ (!diff(9)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100100010000100010010001000100010011101110010001001110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(8),
	datab => ALT_INV_diff(10),
	datad => ALT_INV_diff(9),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux5~0_combout\);

-- Location: LABCELL_X65_Y4_N33
\hex2_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux4~0_combout\ = ( diff(11) & ( (diff(10) & ((!diff(8)) # (diff(9)))) ) ) # ( !diff(11) & ( (!diff(8) & (!diff(10) & diff(9))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010001000000000001000100000100010001100110010001000110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(8),
	datab => ALT_INV_diff(10),
	datad => ALT_INV_diff(9),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux4~0_combout\);

-- Location: LABCELL_X65_Y4_N18
\hex2_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux3~0_combout\ = ( diff(11) & ( (diff(9) & (!diff(10) $ (diff(8)))) ) ) # ( !diff(11) & ( (!diff(10) & (!diff(9) & diff(8))) # (diff(10) & (!diff(9) $ (diff(8)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000011000011001100001100001100001100000000110000110000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(10),
	datac => ALT_INV_diff(9),
	datad => ALT_INV_diff(8),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux3~0_combout\);

-- Location: LABCELL_X65_Y4_N36
\hex2_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux2~0_combout\ = ( diff(10) & ( (!diff(11) & ((!diff(9)) # (diff(8)))) ) ) # ( !diff(10) & ( (diff(8) & ((!diff(11)) # (!diff(9)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001100000011110000110011001100000011001100110000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(11),
	datac => ALT_INV_diff(8),
	datad => ALT_INV_diff(9),
	dataf => ALT_INV_diff(10),
	combout => \hex2_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y4_N39
\hex2_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux1~0_combout\ = (!diff(8) & (!diff(11) & (diff(9) & !diff(10)))) # (diff(8) & (!diff(11) $ (((!diff(9) & diff(10))))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100110000010100010011000001010001001100000101000100110000010100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(8),
	datab => ALT_INV_diff(11),
	datac => ALT_INV_diff(9),
	datad => ALT_INV_diff(10),
	combout => \hex2_inst|Mux1~0_combout\);

-- Location: LABCELL_X65_Y4_N45
\hex2_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux0~0_combout\ = ( diff(8) & ( (!diff(10) $ (!diff(9))) # (diff(11)) ) ) # ( !diff(8) & ( (!diff(11) $ (!diff(10))) # (diff(9)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101101011111111010110101111111101011111111101010101111111110101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(11),
	datac => ALT_INV_diff(10),
	datad => ALT_INV_diff(9),
	dataf => ALT_INV_diff(8),
	combout => \hex2_inst|Mux0~0_combout\);

-- Location: FF_X64_Y4_N53
\diff[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(7),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(7));

-- Location: FF_X64_Y4_N50
\diff[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(4),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(4));

-- Location: FF_X64_Y4_N59
\diff[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(5),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(5));

-- Location: FF_X64_Y4_N56
\diff[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(6),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(6));

-- Location: LABCELL_X63_Y4_N15
\hex1_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux6~0_combout\ = ( diff(6) & ( (!diff(5) & (!diff(7) $ (diff(4)))) ) ) # ( !diff(6) & ( (diff(4) & (!diff(7) $ (diff(5)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000100100001100100001001000000100001001000011001000010010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(7),
	datab => ALT_INV_diff(4),
	datac => ALT_INV_diff(5),
	datae => ALT_INV_diff(6),
	combout => \hex1_inst|Mux6~0_combout\);

-- Location: LABCELL_X64_Y4_N57
\hex1_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux5~0_combout\ = (!diff(7) & (diff(6) & (!diff(4) $ (!diff(5))))) # (diff(7) & ((!diff(4) & (diff(6))) # (diff(4) & ((diff(5))))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011000011011000001100001101100000110000110110000011000011011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(4),
	datab => ALT_INV_diff(7),
	datac => ALT_INV_diff(6),
	datad => ALT_INV_diff(5),
	combout => \hex1_inst|Mux5~0_combout\);

-- Location: LABCELL_X64_Y4_N54
\hex1_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux4~0_combout\ = (!diff(7) & (!diff(4) & (diff(5) & !diff(6)))) # (diff(7) & (diff(6) & ((!diff(4)) # (diff(5)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100000100011000010000010001100001000001000110000100000100011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(4),
	datab => ALT_INV_diff(7),
	datac => ALT_INV_diff(5),
	datad => ALT_INV_diff(6),
	combout => \hex1_inst|Mux4~0_combout\);

-- Location: LABCELL_X64_Y4_N48
\hex1_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux3~0_combout\ = (!diff(5) & (!diff(7) & (!diff(6) $ (!diff(4))))) # (diff(5) & ((!diff(6) & (diff(7) & !diff(4))) # (diff(6) & ((diff(4))))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100001010010001010000101001000101000010100100010100001010010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(6),
	datab => ALT_INV_diff(5),
	datac => ALT_INV_diff(7),
	datad => ALT_INV_diff(4),
	combout => \hex1_inst|Mux3~0_combout\);

-- Location: LABCELL_X63_Y4_N57
\hex1_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux2~0_combout\ = ( diff(6) & ( (!diff(7) & ((!diff(5)) # (diff(4)))) ) ) # ( !diff(6) & ( (diff(4) & ((!diff(7)) # (!diff(5)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001000110010101000101010001000110010001100101010001010100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(7),
	datab => ALT_INV_diff(4),
	datac => ALT_INV_diff(5),
	datae => ALT_INV_diff(6),
	combout => \hex1_inst|Mux2~0_combout\);

-- Location: LABCELL_X64_Y4_N51
\hex1_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux1~0_combout\ = ( diff(4) & ( !diff(7) $ (((diff(6) & !diff(5)))) ) ) # ( !diff(4) & ( (!diff(6) & (diff(5) & !diff(7))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001000000000001000100000000010111011010001001011101101000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(6),
	datab => ALT_INV_diff(5),
	datad => ALT_INV_diff(7),
	dataf => ALT_INV_diff(4),
	combout => \hex1_inst|Mux1~0_combout\);

-- Location: LABCELL_X63_Y4_N24
\hex1_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux0~0_combout\ = ( diff(4) & ( (!diff(5) $ (!diff(6))) # (diff(7)) ) ) # ( !diff(4) & ( (!diff(7) $ (!diff(6))) # (diff(5)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111111110011001111111100111100111111111100110011111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(5),
	datac => ALT_INV_diff(7),
	datad => ALT_INV_diff(6),
	datae => ALT_INV_diff(4),
	combout => \hex1_inst|Mux0~0_combout\);

-- Location: FF_X65_Y4_N2
\diff[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(0),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(0));

-- Location: FF_X65_Y4_N56
\diff[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(3),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(3));

-- Location: FF_X65_Y4_N5
\diff[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(1),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(1));

-- Location: FF_X65_Y4_N26
\diff[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => clock(2),
	sload => VCC,
	ena => \divider~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(2));

-- Location: LABCELL_X65_Y4_N57
\hex0_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux6~0_combout\ = ( !diff(1) & ( diff(2) & ( !diff(0) $ (diff(3)) ) ) ) # ( diff(1) & ( !diff(2) & ( (diff(0) & diff(3)) ) ) ) # ( !diff(1) & ( !diff(2) & ( (diff(0) & !diff(3)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000001010000000001010000010110100101101001010000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(0),
	datac => ALT_INV_diff(3),
	datae => ALT_INV_diff(1),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux6~0_combout\);

-- Location: LABCELL_X63_Y4_N21
\hex0_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux5~0_combout\ = ( diff(3) & ( diff(0) & ( diff(1) ) ) ) # ( !diff(3) & ( diff(0) & ( (diff(2) & !diff(1)) ) ) ) # ( diff(3) & ( !diff(0) & ( diff(2) ) ) ) # ( !diff(3) & ( !diff(0) & ( (diff(2) & diff(1)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100000101010101010101010101010000010100000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(2),
	datac => ALT_INV_diff(1),
	datae => ALT_INV_diff(3),
	dataf => ALT_INV_diff(0),
	combout => \hex0_inst|Mux5~0_combout\);

-- Location: LABCELL_X63_Y4_N48
\hex0_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux4~0_combout\ = ( diff(3) & ( diff(0) & ( (diff(1) & diff(2)) ) ) ) # ( diff(3) & ( !diff(0) & ( diff(2) ) ) ) # ( !diff(3) & ( !diff(0) & ( (diff(1) & !diff(2)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000000110000000011110000111100000000000000000000001100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(1),
	datac => ALT_INV_diff(2),
	datae => ALT_INV_diff(3),
	dataf => ALT_INV_diff(0),
	combout => \hex0_inst|Mux4~0_combout\);

-- Location: LABCELL_X65_Y4_N0
\hex0_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux3~0_combout\ = ( diff(2) & ( (!diff(1) & (!diff(3) & !diff(0))) # (diff(1) & ((diff(0)))) ) ) # ( !diff(2) & ( (!diff(3) & (!diff(1) & diff(0))) # (diff(3) & (diff(1) & !diff(0))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001111000000000000111100000011000000000011111100000000001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(3),
	datac => ALT_INV_diff(1),
	datad => ALT_INV_diff(0),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux3~0_combout\);

-- Location: LABCELL_X65_Y4_N3
\hex0_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux2~0_combout\ = ( diff(2) & ( (!diff(3) & ((!diff(1)) # (diff(0)))) ) ) # ( !diff(2) & ( (diff(0) & ((!diff(3)) # (!diff(1)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101000100010101010100010011001100010001001100110001000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(0),
	datab => ALT_INV_diff(3),
	datad => ALT_INV_diff(1),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y4_N24
\hex0_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux1~0_combout\ = ( diff(3) & ( (!diff(1) & (diff(0) & diff(2))) ) ) # ( !diff(3) & ( (!diff(1) & (diff(0) & !diff(2))) # (diff(1) & ((!diff(2)) # (diff(0)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111100000101010111110000010100000000000010100000000000001010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(1),
	datac => ALT_INV_diff(0),
	datad => ALT_INV_diff(2),
	dataf => ALT_INV_diff(3),
	combout => \hex0_inst|Mux1~0_combout\);

-- Location: LABCELL_X63_Y4_N9
\hex0_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux0~0_combout\ = ( diff(3) & ( diff(0) ) ) # ( !diff(3) & ( diff(0) & ( !diff(2) $ (!diff(1)) ) ) ) # ( diff(3) & ( !diff(0) & ( (!diff(2)) # (diff(1)) ) ) ) # ( !diff(3) & ( !diff(0) & ( (diff(1)) # (diff(2)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111101011111101011111010111101011010010110101111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(2),
	datac => ALT_INV_diff(1),
	datae => ALT_INV_diff(3),
	dataf => ALT_INV_diff(0),
	combout => \hex0_inst|Mux0~0_combout\);

-- Location: MLABCELL_X42_Y31_N0
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


