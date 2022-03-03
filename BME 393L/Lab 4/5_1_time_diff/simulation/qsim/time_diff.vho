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

-- DATE "03/03/2022 11:46:36"

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
	hex0 : OUT std_logic_vector(6 DOWNTO 0);
	counter_out : OUT std_logic_vector(30 DOWNTO 0)
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
-- counter_out[0]	=>  Location: PIN_V24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[1]	=>  Location: PIN_T21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[2]	=>  Location: PIN_N25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[3]	=>  Location: PIN_T26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[4]	=>  Location: PIN_P22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[5]	=>  Location: PIN_R26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[6]	=>  Location: PIN_U26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[7]	=>  Location: PIN_V23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[8]	=>  Location: PIN_U25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[9]	=>  Location: PIN_Y26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[10]	=>  Location: PIN_P26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[11]	=>  Location: PIN_Y25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[12]	=>  Location: PIN_T22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[13]	=>  Location: PIN_P21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[14]	=>  Location: PIN_W26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[15]	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[16]	=>  Location: PIN_P23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[17]	=>  Location: PIN_AC25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[18]	=>  Location: PIN_AD25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[19]	=>  Location: PIN_R23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[20]	=>  Location: PIN_R24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[21]	=>  Location: PIN_T23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[22]	=>  Location: PIN_P20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[23]	=>  Location: PIN_AA24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[24]	=>  Location: PIN_AB25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[25]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[26]	=>  Location: PIN_R25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[27]	=>  Location: PIN_T24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[28]	=>  Location: PIN_AB26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[29]	=>  Location: PIN_U24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- counter_out[30]	=>  Location: PIN_AA26,	 I/O Standard: 2.5 V,	 Current Strength: Default
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
SIGNAL ww_counter_out : std_logic_vector(30 DOWNTO 0);
SIGNAL \KEY[2]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50_B5B~input_o\ : std_logic;
SIGNAL \CLOCK_50_B5B~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \KEY[0]~input_o\ : std_logic;
SIGNAL \KEY[1]~input_o\ : std_logic;
SIGNAL \process_0~0_combout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \diff[14]~feeder_combout\ : std_logic;
SIGNAL \KEY[3]~input_o\ : std_logic;
SIGNAL \diff[13]~feeder_combout\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \diff[12]~feeder_combout\ : std_logic;
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
SIGNAL \diff[0]~feeder_combout\ : std_logic;
SIGNAL \diff[1]~feeder_combout\ : std_logic;
SIGNAL \hex0_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux0~0_combout\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~65_sumout\ : std_logic;
SIGNAL \Add0~66\ : std_logic;
SIGNAL \Add0~69_sumout\ : std_logic;
SIGNAL \Add0~70\ : std_logic;
SIGNAL \Add0~73_sumout\ : std_logic;
SIGNAL \Add0~74\ : std_logic;
SIGNAL \Add0~77_sumout\ : std_logic;
SIGNAL \Add0~78\ : std_logic;
SIGNAL \Add0~81_sumout\ : std_logic;
SIGNAL \Add0~82\ : std_logic;
SIGNAL \Add0~85_sumout\ : std_logic;
SIGNAL \Add0~86\ : std_logic;
SIGNAL \Add0~89_sumout\ : std_logic;
SIGNAL \Add0~90\ : std_logic;
SIGNAL \Add0~93_sumout\ : std_logic;
SIGNAL \Add0~94\ : std_logic;
SIGNAL \Add0~97_sumout\ : std_logic;
SIGNAL \Add0~98\ : std_logic;
SIGNAL \Add0~101_sumout\ : std_logic;
SIGNAL \Add0~102\ : std_logic;
SIGNAL \Add0~105_sumout\ : std_logic;
SIGNAL \Add0~106\ : std_logic;
SIGNAL \Add0~109_sumout\ : std_logic;
SIGNAL \Add0~110\ : std_logic;
SIGNAL \Add0~113_sumout\ : std_logic;
SIGNAL \Add0~114\ : std_logic;
SIGNAL \Add0~117_sumout\ : std_logic;
SIGNAL \Add0~118\ : std_logic;
SIGNAL \Add0~121_sumout\ : std_logic;
SIGNAL diff : std_logic_vector(15 DOWNTO 0);
SIGNAL clock : std_logic_vector(30 DOWNTO 0);
SIGNAL ALT_INV_clock : std_logic_vector(30 DOWNTO 0);
SIGNAL ALT_INV_diff : std_logic_vector(15 DOWNTO 0);
SIGNAL \ALT_INV_KEY[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_KEY[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_KEY[3]~input_o\ : std_logic;
SIGNAL \hex0_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex1_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex2_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \hex3_inst|ALT_INV_Mux0~0_combout\ : std_logic;

BEGIN

ww_CLOCK_50_B5B <= CLOCK_50_B5B;
ww_KEY <= KEY;
hex3 <= ww_hex3;
hex2 <= ww_hex2;
hex1 <= ww_hex1;
hex0 <= ww_hex0;
counter_out <= ww_counter_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
ALT_INV_clock(30) <= NOT clock(30);
ALT_INV_clock(29) <= NOT clock(29);
ALT_INV_clock(28) <= NOT clock(28);
ALT_INV_clock(27) <= NOT clock(27);
ALT_INV_clock(26) <= NOT clock(26);
ALT_INV_clock(25) <= NOT clock(25);
ALT_INV_clock(24) <= NOT clock(24);
ALT_INV_clock(23) <= NOT clock(23);
ALT_INV_clock(22) <= NOT clock(22);
ALT_INV_clock(21) <= NOT clock(21);
ALT_INV_clock(20) <= NOT clock(20);
ALT_INV_clock(19) <= NOT clock(19);
ALT_INV_clock(18) <= NOT clock(18);
ALT_INV_clock(17) <= NOT clock(17);
ALT_INV_clock(16) <= NOT clock(16);
ALT_INV_clock(15) <= NOT clock(15);
ALT_INV_clock(14) <= NOT clock(14);
ALT_INV_clock(13) <= NOT clock(13);
ALT_INV_clock(12) <= NOT clock(12);
ALT_INV_clock(11) <= NOT clock(11);
ALT_INV_clock(10) <= NOT clock(10);
ALT_INV_clock(9) <= NOT clock(9);
ALT_INV_clock(8) <= NOT clock(8);
ALT_INV_clock(7) <= NOT clock(7);
ALT_INV_clock(6) <= NOT clock(6);
ALT_INV_clock(5) <= NOT clock(5);
ALT_INV_clock(4) <= NOT clock(4);
ALT_INV_clock(3) <= NOT clock(3);
ALT_INV_clock(2) <= NOT clock(2);
ALT_INV_clock(1) <= NOT clock(1);
ALT_INV_clock(0) <= NOT clock(0);
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
\ALT_INV_KEY[1]~input_o\ <= NOT \KEY[1]~input_o\;
\ALT_INV_KEY[0]~input_o\ <= NOT \KEY[0]~input_o\;
\ALT_INV_KEY[3]~input_o\ <= NOT \KEY[3]~input_o\;
\hex0_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex0_inst|Mux0~0_combout\;
\hex1_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex1_inst|Mux0~0_combout\;
\hex2_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex2_inst|Mux0~0_combout\;
\hex3_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex3_inst|Mux0~0_combout\;

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

-- Location: IOOBUF_X68_Y14_N96
\counter_out[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(0),
	devoe => ww_devoe,
	o => ww_counter_out(0));

-- Location: IOOBUF_X68_Y14_N45
\counter_out[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(1),
	devoe => ww_devoe,
	o => ww_counter_out(1));

-- Location: IOOBUF_X68_Y27_N5
\counter_out[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(2),
	devoe => ww_devoe,
	o => ww_counter_out(2));

-- Location: IOOBUF_X68_Y24_N5
\counter_out[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(3),
	devoe => ww_devoe,
	o => ww_counter_out(3));

-- Location: IOOBUF_X68_Y26_N22
\counter_out[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(4),
	devoe => ww_devoe,
	o => ww_counter_out(4));

-- Location: IOOBUF_X68_Y24_N22
\counter_out[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(5),
	devoe => ww_devoe,
	o => ww_counter_out(5));

-- Location: IOOBUF_X68_Y27_N56
\counter_out[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(6),
	devoe => ww_devoe,
	o => ww_counter_out(6));

-- Location: IOOBUF_X68_Y14_N79
\counter_out[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(7),
	devoe => ww_devoe,
	o => ww_counter_out(7));

-- Location: IOOBUF_X68_Y27_N39
\counter_out[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(8),
	devoe => ww_devoe,
	o => ww_counter_out(8));

-- Location: IOOBUF_X68_Y24_N56
\counter_out[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(9),
	devoe => ww_devoe,
	o => ww_counter_out(9));

-- Location: IOOBUF_X68_Y27_N22
\counter_out[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(10),
	devoe => ww_devoe,
	o => ww_counter_out(10));

-- Location: IOOBUF_X68_Y24_N39
\counter_out[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(11),
	devoe => ww_devoe,
	o => ww_counter_out(11));

-- Location: IOOBUF_X68_Y14_N62
\counter_out[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(12),
	devoe => ww_devoe,
	o => ww_counter_out(12));

-- Location: IOOBUF_X68_Y26_N5
\counter_out[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(13),
	devoe => ww_devoe,
	o => ww_counter_out(13));

-- Location: IOOBUF_X68_Y26_N56
\counter_out[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(14),
	devoe => ww_devoe,
	o => ww_counter_out(14));

-- Location: IOOBUF_X68_Y26_N39
\counter_out[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(15),
	devoe => ww_devoe,
	o => ww_counter_out(15));

-- Location: IOOBUF_X68_Y17_N22
\counter_out[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(16),
	devoe => ww_devoe,
	o => ww_counter_out(16));

-- Location: IOOBUF_X68_Y17_N56
\counter_out[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(17),
	devoe => ww_devoe,
	o => ww_counter_out(17));

-- Location: IOOBUF_X68_Y17_N39
\counter_out[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(18),
	devoe => ww_devoe,
	o => ww_counter_out(18));

-- Location: IOOBUF_X68_Y17_N5
\counter_out[19]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(19),
	devoe => ww_devoe,
	o => ww_counter_out(19));

-- Location: IOOBUF_X68_Y19_N5
\counter_out[20]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(20),
	devoe => ww_devoe,
	o => ww_counter_out(20));

-- Location: IOOBUF_X68_Y16_N5
\counter_out[21]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(21),
	devoe => ww_devoe,
	o => ww_counter_out(21));

-- Location: IOOBUF_X68_Y22_N62
\counter_out[22]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(22),
	devoe => ww_devoe,
	o => ww_counter_out(22));

-- Location: IOOBUF_X68_Y16_N39
\counter_out[23]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(23),
	devoe => ww_devoe,
	o => ww_counter_out(23));

-- Location: IOOBUF_X68_Y16_N56
\counter_out[24]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(24),
	devoe => ww_devoe,
	o => ww_counter_out(24));

-- Location: IOOBUF_X68_Y19_N56
\counter_out[25]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(25),
	devoe => ww_devoe,
	o => ww_counter_out(25));

-- Location: IOOBUF_X68_Y19_N22
\counter_out[26]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(26),
	devoe => ww_devoe,
	o => ww_counter_out(26));

-- Location: IOOBUF_X68_Y16_N22
\counter_out[27]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(27),
	devoe => ww_devoe,
	o => ww_counter_out(27));

-- Location: IOOBUF_X68_Y22_N79
\counter_out[28]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(28),
	devoe => ww_devoe,
	o => ww_counter_out(28));

-- Location: IOOBUF_X68_Y19_N39
\counter_out[29]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(29),
	devoe => ww_devoe,
	o => ww_counter_out(29));

-- Location: IOOBUF_X68_Y22_N96
\counter_out[30]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => clock(30),
	devoe => ww_devoe,
	o => ww_counter_out(30));

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

-- Location: LABCELL_X67_Y17_N0
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( clock(0) ) + ( VCC ) + ( !VCC ))
-- \Add0~2\ = CARRY(( clock(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(0),
	cin => GND,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

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

-- Location: LABCELL_X22_Y2_N0
\process_0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \process_0~0_combout\ = ( \KEY[0]~input_o\ & ( \KEY[1]~input_o\ ) ) # ( !\KEY[0]~input_o\ & ( !\KEY[1]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_KEY[0]~input_o\,
	dataf => \ALT_INV_KEY[1]~input_o\,
	combout => \process_0~0_combout\);

-- Location: FF_X67_Y17_N2
\clock[0]\ : dffeas
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
	q => clock(0));

-- Location: LABCELL_X67_Y17_N3
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( clock(1) ) + ( GND ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( clock(1) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(1),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X67_Y17_N5
\clock[1]\ : dffeas
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
	q => clock(1));

-- Location: LABCELL_X67_Y17_N6
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( clock(2) ) + ( GND ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( clock(2) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(2),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X67_Y17_N8
\clock[2]\ : dffeas
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
	q => clock(2));

-- Location: LABCELL_X67_Y17_N9
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( clock(3) ) + ( GND ) + ( \Add0~10\ ))
-- \Add0~14\ = CARRY(( clock(3) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(3),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X67_Y17_N11
\clock[3]\ : dffeas
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
	q => clock(3));

-- Location: LABCELL_X67_Y17_N12
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( clock(4) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~18\ = CARRY(( clock(4) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(4),
	cin => \Add0~14\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X67_Y17_N14
\clock[4]\ : dffeas
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
	q => clock(4));

-- Location: LABCELL_X67_Y17_N15
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( clock(5) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( clock(5) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(5),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X67_Y17_N17
\clock[5]\ : dffeas
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
	q => clock(5));

-- Location: LABCELL_X67_Y17_N18
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( clock(6) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( clock(6) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(6),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X67_Y17_N20
\clock[6]\ : dffeas
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
	q => clock(6));

-- Location: LABCELL_X67_Y17_N21
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( clock(7) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( clock(7) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(7),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X67_Y17_N23
\clock[7]\ : dffeas
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
	q => clock(7));

-- Location: LABCELL_X67_Y17_N24
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( clock(8) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~34\ = CARRY(( clock(8) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(8),
	cin => \Add0~30\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X67_Y17_N26
\clock[8]\ : dffeas
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
	q => clock(8));

-- Location: LABCELL_X67_Y17_N27
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( clock(9) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( clock(9) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(9),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X67_Y17_N29
\clock[9]\ : dffeas
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
	q => clock(9));

-- Location: LABCELL_X67_Y17_N30
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( clock(10) ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~42\ = CARRY(( clock(10) ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(10),
	cin => \Add0~38\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: FF_X67_Y17_N32
\clock[10]\ : dffeas
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
	q => clock(10));

-- Location: LABCELL_X67_Y17_N33
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( clock(11) ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~46\ = CARRY(( clock(11) ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_clock(11),
	cin => \Add0~42\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: FF_X67_Y17_N35
\clock[11]\ : dffeas
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
	q => clock(11));

-- Location: LABCELL_X67_Y17_N36
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( clock(12) ) + ( GND ) + ( \Add0~46\ ))
-- \Add0~50\ = CARRY(( clock(12) ) + ( GND ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(12),
	cin => \Add0~46\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

-- Location: FF_X67_Y17_N38
\clock[12]\ : dffeas
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
	q => clock(12));

-- Location: LABCELL_X67_Y17_N39
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( clock(13) ) + ( GND ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( clock(13) ) + ( GND ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(13),
	cin => \Add0~50\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X67_Y17_N41
\clock[13]\ : dffeas
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
	q => clock(13));

-- Location: LABCELL_X67_Y17_N42
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( clock(14) ) + ( GND ) + ( \Add0~54\ ))
-- \Add0~58\ = CARRY(( clock(14) ) + ( GND ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(14),
	cin => \Add0~54\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X67_Y17_N44
\clock[14]\ : dffeas
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
	q => clock(14));

-- Location: LABCELL_X64_Y12_N33
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

-- Location: FF_X64_Y12_N35
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

-- Location: LABCELL_X64_Y12_N30
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

-- Location: FF_X64_Y12_N32
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

-- Location: LABCELL_X67_Y17_N45
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( clock(15) ) + ( GND ) + ( \Add0~58\ ))
-- \Add0~62\ = CARRY(( clock(15) ) + ( GND ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(15),
	cin => \Add0~58\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\);

-- Location: FF_X67_Y17_N47
\clock[15]\ : dffeas
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
	q => clock(15));

-- Location: FF_X64_Y12_N14
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

-- Location: LABCELL_X64_Y12_N15
\diff[12]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \diff[12]~feeder_combout\ = ( clock(12) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_clock(12),
	combout => \diff[12]~feeder_combout\);

-- Location: FF_X64_Y12_N17
\diff[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \diff[12]~feeder_combout\,
	sclr => \ALT_INV_KEY[3]~input_o\,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(12));

-- Location: LABCELL_X65_Y12_N36
\hex3_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux6~0_combout\ = ( diff(12) & ( (!diff(14) & (!diff(13) $ (diff(15)))) # (diff(14) & (!diff(13) & diff(15))) ) ) # ( !diff(12) & ( (diff(14) & (!diff(13) & !diff(15))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100000001000000010000000100000010000110100001101000011010000110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(14),
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(15),
	dataf => ALT_INV_diff(12),
	combout => \hex3_inst|Mux6~0_combout\);

-- Location: LABCELL_X65_Y12_N39
\hex3_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux5~0_combout\ = (!diff(13) & (diff(14) & (!diff(12) $ (!diff(15))))) # (diff(13) & ((!diff(12) & (diff(14))) # (diff(12) & ((diff(15))))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001010001010011000101000101001100010100010100110001010001010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(14),
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(12),
	datad => ALT_INV_diff(15),
	combout => \hex3_inst|Mux5~0_combout\);

-- Location: LABCELL_X65_Y12_N30
\hex3_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux4~0_combout\ = ( diff(14) & ( (diff(15) & ((!diff(12)) # (diff(13)))) ) ) # ( !diff(14) & ( (!diff(12) & (!diff(15) & diff(13))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011000000000011000000111100000000110000000000110000001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(12),
	datac => ALT_INV_diff(15),
	datad => ALT_INV_diff(13),
	datae => ALT_INV_diff(14),
	combout => \hex3_inst|Mux4~0_combout\);

-- Location: LABCELL_X65_Y12_N15
\hex3_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux3~0_combout\ = ( diff(14) & ( (!diff(13) & (!diff(15) & !diff(12))) # (diff(13) & ((diff(12)))) ) ) # ( !diff(14) & ( (!diff(15) & (!diff(13) & diff(12))) # (diff(15) & (diff(13) & !diff(12))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001100000011000100000111000001100011000000110001000001110000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(12),
	datae => ALT_INV_diff(14),
	combout => \hex3_inst|Mux3~0_combout\);

-- Location: LABCELL_X65_Y12_N57
\hex3_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux2~0_combout\ = ( diff(12) & ( (!diff(15)) # ((!diff(13) & !diff(14))) ) ) # ( !diff(12) & ( (!diff(15) & (!diff(13) & diff(14))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010100000000000001010000011111010101010101111101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datac => ALT_INV_diff(13),
	datad => ALT_INV_diff(14),
	dataf => ALT_INV_diff(12),
	combout => \hex3_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y12_N48
\hex3_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux1~0_combout\ = ( diff(14) & ( (diff(12) & (!diff(15) $ (!diff(13)))) ) ) # ( !diff(14) & ( (!diff(15) & ((diff(13)) # (diff(12)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000011110000000000110011000000110000111100000000001100110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(12),
	datac => ALT_INV_diff(15),
	datad => ALT_INV_diff(13),
	datae => ALT_INV_diff(14),
	combout => \hex3_inst|Mux1~0_combout\);

-- Location: LABCELL_X65_Y12_N9
\hex3_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux0~0_combout\ = ( diff(14) & ( (!diff(15) & ((!diff(13)) # (!diff(12)))) # (diff(15) & ((diff(12)) # (diff(13)))) ) ) # ( !diff(14) & ( (diff(13)) # (diff(15)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011101110111101111011011110101110111011101111011110110111101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(15),
	datab => ALT_INV_diff(13),
	datac => ALT_INV_diff(12),
	datae => ALT_INV_diff(14),
	combout => \hex3_inst|Mux0~0_combout\);

-- Location: FF_X64_Y12_N29
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

-- Location: FF_X64_Y12_N44
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

-- Location: FF_X64_Y12_N5
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

-- Location: FF_X64_Y12_N26
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

-- Location: LABCELL_X63_Y12_N15
\hex2_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux6~0_combout\ = ( diff(8) & ( diff(11) & ( !diff(10) $ (!diff(9)) ) ) ) # ( diff(8) & ( !diff(11) & ( (!diff(10) & !diff(9)) ) ) ) # ( !diff(8) & ( !diff(11) & ( (diff(10) & !diff(9)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010001000100100010001000100000000000000000000110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(10),
	datab => ALT_INV_diff(9),
	datae => ALT_INV_diff(8),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux6~0_combout\);

-- Location: LABCELL_X63_Y12_N57
\hex2_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux5~0_combout\ = ( diff(8) & ( diff(11) & ( diff(9) ) ) ) # ( !diff(8) & ( diff(11) & ( diff(10) ) ) ) # ( diff(8) & ( !diff(11) & ( (diff(10) & !diff(9)) ) ) ) # ( !diff(8) & ( !diff(11) & ( (diff(10) & diff(9)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100010001010001000100010001010101010101010011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(10),
	datab => ALT_INV_diff(9),
	datae => ALT_INV_diff(8),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux5~0_combout\);

-- Location: LABCELL_X64_Y12_N27
\hex2_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux4~0_combout\ = ( diff(11) & ( (diff(10) & ((!diff(8)) # (diff(9)))) ) ) # ( !diff(11) & ( (!diff(8) & (diff(9) & !diff(10))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001000000000001000100000000000000000101110110000000010111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(8),
	datab => ALT_INV_diff(9),
	datad => ALT_INV_diff(10),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux4~0_combout\);

-- Location: LABCELL_X64_Y12_N3
\hex2_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux3~0_combout\ = ( diff(11) & ( (diff(9) & (!diff(10) $ (diff(8)))) ) ) # ( !diff(11) & ( (!diff(9) & (!diff(10) $ (!diff(8)))) # (diff(9) & (diff(10) & diff(8))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110011000011000011001100001100110000000000110011000000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(9),
	datac => ALT_INV_diff(10),
	datad => ALT_INV_diff(8),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux3~0_combout\);

-- Location: LABCELL_X64_Y12_N42
\hex2_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux2~0_combout\ = ( diff(11) & ( (diff(8) & (!diff(10) & !diff(9))) ) ) # ( !diff(11) & ( ((diff(10) & !diff(9))) # (diff(8)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011101010101011101110101010101000100000000000100010000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(8),
	datab => ALT_INV_diff(10),
	datad => ALT_INV_diff(9),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux2~0_combout\);

-- Location: LABCELL_X64_Y12_N45
\hex2_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux1~0_combout\ = ( diff(11) & ( (diff(8) & (diff(10) & !diff(9))) ) ) # ( !diff(11) & ( (!diff(8) & (!diff(10) & diff(9))) # (diff(8) & ((!diff(10)) # (diff(9)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100110101001101010011010100110100010000000100000001000000010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(8),
	datab => ALT_INV_diff(10),
	datac => ALT_INV_diff(9),
	dataf => ALT_INV_diff(11),
	combout => \hex2_inst|Mux1~0_combout\);

-- Location: LABCELL_X64_Y12_N24
\hex2_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex2_inst|Mux0~0_combout\ = (!diff(8) & ((!diff(10) $ (!diff(11))) # (diff(9)))) # (diff(8) & ((!diff(9) $ (!diff(10))) # (diff(11))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111011110111001111101111011100111110111101110011111011110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(8),
	datab => ALT_INV_diff(9),
	datac => ALT_INV_diff(10),
	datad => ALT_INV_diff(11),
	combout => \hex2_inst|Mux0~0_combout\);

-- Location: FF_X64_Y12_N56
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

-- Location: FF_X64_Y12_N47
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

-- Location: FF_X64_Y12_N41
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

-- Location: FF_X64_Y12_N38
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

-- Location: LABCELL_X64_Y12_N39
\hex1_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux6~0_combout\ = ( diff(7) & ( (diff(4) & (!diff(5) $ (!diff(6)))) ) ) # ( !diff(7) & ( (!diff(5) & (!diff(4) $ (!diff(6)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101010100000000010101010000000000101000010100000010100001010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(5),
	datac => ALT_INV_diff(4),
	datad => ALT_INV_diff(6),
	dataf => ALT_INV_diff(7),
	combout => \hex1_inst|Mux6~0_combout\);

-- Location: LABCELL_X64_Y12_N57
\hex1_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux5~0_combout\ = ( diff(6) & ( (!diff(7) & (!diff(4) $ (!diff(5)))) # (diff(7) & ((!diff(4)) # (diff(5)))) ) ) # ( !diff(6) & ( (diff(7) & (diff(4) & diff(5))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010001000000000001000101100110110111010110011011011101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(7),
	datab => ALT_INV_diff(4),
	datad => ALT_INV_diff(5),
	dataf => ALT_INV_diff(6),
	combout => \hex1_inst|Mux5~0_combout\);

-- Location: LABCELL_X65_Y12_N27
\hex1_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux4~0_combout\ = ( diff(6) & ( (diff(7) & ((!diff(4)) # (diff(5)))) ) ) # ( !diff(6) & ( (!diff(7) & (diff(5) & !diff(4))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000100000001000000010000001010001010100010101000101010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(7),
	datab => ALT_INV_diff(5),
	datac => ALT_INV_diff(4),
	dataf => ALT_INV_diff(6),
	combout => \hex1_inst|Mux4~0_combout\);

-- Location: LABCELL_X64_Y12_N0
\hex1_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux3~0_combout\ = ( diff(6) & ( (!diff(5) & (!diff(7) & !diff(4))) # (diff(5) & ((diff(4)))) ) ) # ( !diff(6) & ( (!diff(5) & (!diff(7) & diff(4))) # (diff(5) & (diff(7) & !diff(4))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010110100000000001011010000010100000010101011010000001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(5),
	datac => ALT_INV_diff(7),
	datad => ALT_INV_diff(4),
	dataf => ALT_INV_diff(6),
	combout => \hex1_inst|Mux3~0_combout\);

-- Location: LABCELL_X64_Y12_N54
\hex1_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux2~0_combout\ = ( diff(6) & ( (!diff(7) & ((!diff(5)) # (diff(4)))) ) ) # ( !diff(6) & ( (diff(4) & ((!diff(7)) # (!diff(5)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100100010001100110010001010101010001000101010101000100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(7),
	datab => ALT_INV_diff(4),
	datad => ALT_INV_diff(5),
	dataf => ALT_INV_diff(6),
	combout => \hex1_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y12_N24
\hex1_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux1~0_combout\ = ( diff(7) & ( (!diff(5) & (diff(6) & diff(4))) ) ) # ( !diff(7) & ( (!diff(5) & (!diff(6) & diff(4))) # (diff(5) & ((!diff(6)) # (diff(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000011110011001100001111001100000000000011000000000000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(5),
	datac => ALT_INV_diff(6),
	datad => ALT_INV_diff(4),
	dataf => ALT_INV_diff(7),
	combout => \hex1_inst|Mux1~0_combout\);

-- Location: LABCELL_X64_Y12_N36
\hex1_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex1_inst|Mux0~0_combout\ = (!diff(4) & ((!diff(6) $ (!diff(7))) # (diff(5)))) # (diff(4) & ((!diff(5) $ (!diff(6))) # (diff(7))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101111011110111010111101111011101011110111101110101111011110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(5),
	datab => ALT_INV_diff(4),
	datac => ALT_INV_diff(6),
	datad => ALT_INV_diff(7),
	combout => \hex1_inst|Mux0~0_combout\);

-- Location: LABCELL_X64_Y12_N21
\diff[0]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \diff[0]~feeder_combout\ = ( clock(0) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_clock(0),
	combout => \diff[0]~feeder_combout\);

-- Location: FF_X64_Y12_N23
\diff[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \diff[0]~feeder_combout\,
	sclr => \ALT_INV_KEY[3]~input_o\,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(0));

-- Location: LABCELL_X64_Y12_N18
\diff[1]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \diff[1]~feeder_combout\ = ( clock(1) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_clock(1),
	combout => \diff[1]~feeder_combout\);

-- Location: FF_X64_Y12_N20
\diff[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \diff[1]~feeder_combout\,
	sclr => \ALT_INV_KEY[3]~input_o\,
	ena => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => diff(1));

-- Location: FF_X64_Y12_N50
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

-- Location: FF_X64_Y12_N53
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

-- Location: LABCELL_X65_Y12_N21
\hex0_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux6~0_combout\ = ( diff(2) & ( (!diff(1) & (!diff(0) $ (diff(3)))) ) ) # ( !diff(2) & ( (diff(0) & (!diff(1) $ (diff(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000000000101010100000000010110100000010100001010000001010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(0),
	datac => ALT_INV_diff(1),
	datad => ALT_INV_diff(3),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux6~0_combout\);

-- Location: LABCELL_X64_Y12_N6
\hex0_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux5~0_combout\ = ( diff(2) & ( (!diff(3) & (!diff(1) $ (!diff(0)))) # (diff(3) & ((!diff(0)) # (diff(1)))) ) ) # ( !diff(2) & ( (diff(3) & (diff(1) & diff(0))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000011000000000000001100111111110000110011111111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(3),
	datac => ALT_INV_diff(1),
	datad => ALT_INV_diff(0),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux5~0_combout\);

-- Location: LABCELL_X64_Y12_N9
\hex0_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux4~0_combout\ = ( diff(2) & ( (diff(3) & ((!diff(0)) # (diff(1)))) ) ) # ( !diff(2) & ( (diff(1) & (!diff(3) & !diff(0))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010000000000010001000000000000110011000100010011001100010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(1),
	datab => ALT_INV_diff(3),
	datad => ALT_INV_diff(0),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux4~0_combout\);

-- Location: LABCELL_X65_Y12_N0
\hex0_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux3~0_combout\ = ( diff(2) & ( (!diff(1) & (!diff(3) & !diff(0))) # (diff(1) & ((diff(0)))) ) ) # ( !diff(2) & ( (!diff(3) & (!diff(1) & diff(0))) # (diff(3) & (diff(1) & !diff(0))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001100000011000000110000001100010000011100000111000001110000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(3),
	datab => ALT_INV_diff(1),
	datac => ALT_INV_diff(0),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux3~0_combout\);

-- Location: LABCELL_X65_Y12_N42
\hex0_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux2~0_combout\ = ( diff(2) & ( (!diff(3) & ((!diff(1)) # (diff(0)))) ) ) # ( !diff(2) & ( (diff(0) & ((!diff(3)) # (!diff(1)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111000001110000011100000111010001010100010101000101010001010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(3),
	datab => ALT_INV_diff(1),
	datac => ALT_INV_diff(0),
	dataf => ALT_INV_diff(2),
	combout => \hex0_inst|Mux2~0_combout\);

-- Location: LABCELL_X65_Y12_N54
\hex0_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux1~0_combout\ = ( diff(3) & ( (!diff(1) & (diff(0) & diff(2))) ) ) # ( !diff(3) & ( (!diff(1) & (diff(0) & !diff(2))) # (diff(1) & ((!diff(2)) # (diff(0)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100000011001111110000001100000000000011000000000000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_diff(1),
	datac => ALT_INV_diff(0),
	datad => ALT_INV_diff(2),
	dataf => ALT_INV_diff(3),
	combout => \hex0_inst|Mux1~0_combout\);

-- Location: LABCELL_X64_Y12_N48
\hex0_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux0~0_combout\ = ( diff(3) & ( diff(1) ) ) # ( !diff(3) & ( diff(1) & ( (!diff(0)) # (!diff(2)) ) ) ) # ( diff(3) & ( !diff(1) & ( (!diff(2)) # (diff(0)) ) ) ) # ( !diff(3) & ( !diff(1) & ( diff(2) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111111101011111010111111010111110101111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_diff(0),
	datac => ALT_INV_diff(2),
	datae => ALT_INV_diff(3),
	dataf => ALT_INV_diff(1),
	combout => \hex0_inst|Mux0~0_combout\);

-- Location: LABCELL_X67_Y17_N48
\Add0~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~65_sumout\ = SUM(( clock(16) ) + ( GND ) + ( \Add0~62\ ))
-- \Add0~66\ = CARRY(( clock(16) ) + ( GND ) + ( \Add0~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(16),
	cin => \Add0~62\,
	sumout => \Add0~65_sumout\,
	cout => \Add0~66\);

-- Location: FF_X67_Y17_N50
\clock[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~65_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(16));

-- Location: LABCELL_X67_Y17_N51
\Add0~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~69_sumout\ = SUM(( clock(17) ) + ( GND ) + ( \Add0~66\ ))
-- \Add0~70\ = CARRY(( clock(17) ) + ( GND ) + ( \Add0~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_clock(17),
	cin => \Add0~66\,
	sumout => \Add0~69_sumout\,
	cout => \Add0~70\);

-- Location: FF_X67_Y17_N53
\clock[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~69_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(17));

-- Location: LABCELL_X67_Y17_N54
\Add0~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~73_sumout\ = SUM(( clock(18) ) + ( GND ) + ( \Add0~70\ ))
-- \Add0~74\ = CARRY(( clock(18) ) + ( GND ) + ( \Add0~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(18),
	cin => \Add0~70\,
	sumout => \Add0~73_sumout\,
	cout => \Add0~74\);

-- Location: FF_X67_Y17_N56
\clock[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~73_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(18));

-- Location: LABCELL_X67_Y17_N57
\Add0~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~77_sumout\ = SUM(( clock(19) ) + ( GND ) + ( \Add0~74\ ))
-- \Add0~78\ = CARRY(( clock(19) ) + ( GND ) + ( \Add0~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(19),
	cin => \Add0~74\,
	sumout => \Add0~77_sumout\,
	cout => \Add0~78\);

-- Location: FF_X67_Y17_N59
\clock[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~77_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(19));

-- Location: LABCELL_X67_Y16_N0
\Add0~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~81_sumout\ = SUM(( clock(20) ) + ( GND ) + ( \Add0~78\ ))
-- \Add0~82\ = CARRY(( clock(20) ) + ( GND ) + ( \Add0~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(20),
	cin => \Add0~78\,
	sumout => \Add0~81_sumout\,
	cout => \Add0~82\);

-- Location: FF_X67_Y16_N2
\clock[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~81_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(20));

-- Location: LABCELL_X67_Y16_N3
\Add0~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~85_sumout\ = SUM(( clock(21) ) + ( GND ) + ( \Add0~82\ ))
-- \Add0~86\ = CARRY(( clock(21) ) + ( GND ) + ( \Add0~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(21),
	cin => \Add0~82\,
	sumout => \Add0~85_sumout\,
	cout => \Add0~86\);

-- Location: FF_X67_Y16_N5
\clock[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~85_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(21));

-- Location: LABCELL_X67_Y16_N6
\Add0~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~89_sumout\ = SUM(( clock(22) ) + ( GND ) + ( \Add0~86\ ))
-- \Add0~90\ = CARRY(( clock(22) ) + ( GND ) + ( \Add0~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(22),
	cin => \Add0~86\,
	sumout => \Add0~89_sumout\,
	cout => \Add0~90\);

-- Location: FF_X67_Y16_N8
\clock[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~89_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(22));

-- Location: LABCELL_X67_Y16_N9
\Add0~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~93_sumout\ = SUM(( clock(23) ) + ( GND ) + ( \Add0~90\ ))
-- \Add0~94\ = CARRY(( clock(23) ) + ( GND ) + ( \Add0~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(23),
	cin => \Add0~90\,
	sumout => \Add0~93_sumout\,
	cout => \Add0~94\);

-- Location: FF_X67_Y16_N11
\clock[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~93_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(23));

-- Location: LABCELL_X67_Y16_N12
\Add0~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~97_sumout\ = SUM(( clock(24) ) + ( GND ) + ( \Add0~94\ ))
-- \Add0~98\ = CARRY(( clock(24) ) + ( GND ) + ( \Add0~94\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(24),
	cin => \Add0~94\,
	sumout => \Add0~97_sumout\,
	cout => \Add0~98\);

-- Location: FF_X67_Y16_N14
\clock[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~97_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(24));

-- Location: LABCELL_X67_Y16_N15
\Add0~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~101_sumout\ = SUM(( clock(25) ) + ( GND ) + ( \Add0~98\ ))
-- \Add0~102\ = CARRY(( clock(25) ) + ( GND ) + ( \Add0~98\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(25),
	cin => \Add0~98\,
	sumout => \Add0~101_sumout\,
	cout => \Add0~102\);

-- Location: FF_X67_Y16_N17
\clock[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~101_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(25));

-- Location: LABCELL_X67_Y16_N18
\Add0~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~105_sumout\ = SUM(( clock(26) ) + ( GND ) + ( \Add0~102\ ))
-- \Add0~106\ = CARRY(( clock(26) ) + ( GND ) + ( \Add0~102\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(26),
	cin => \Add0~102\,
	sumout => \Add0~105_sumout\,
	cout => \Add0~106\);

-- Location: FF_X67_Y16_N20
\clock[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~105_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(26));

-- Location: LABCELL_X67_Y16_N21
\Add0~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~109_sumout\ = SUM(( clock(27) ) + ( GND ) + ( \Add0~106\ ))
-- \Add0~110\ = CARRY(( clock(27) ) + ( GND ) + ( \Add0~106\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(27),
	cin => \Add0~106\,
	sumout => \Add0~109_sumout\,
	cout => \Add0~110\);

-- Location: FF_X67_Y16_N23
\clock[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~109_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(27));

-- Location: LABCELL_X67_Y16_N24
\Add0~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~113_sumout\ = SUM(( clock(28) ) + ( GND ) + ( \Add0~110\ ))
-- \Add0~114\ = CARRY(( clock(28) ) + ( GND ) + ( \Add0~110\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_clock(28),
	cin => \Add0~110\,
	sumout => \Add0~113_sumout\,
	cout => \Add0~114\);

-- Location: FF_X67_Y16_N26
\clock[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~113_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(28));

-- Location: LABCELL_X67_Y16_N27
\Add0~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~117_sumout\ = SUM(( clock(29) ) + ( GND ) + ( \Add0~114\ ))
-- \Add0~118\ = CARRY(( clock(29) ) + ( GND ) + ( \Add0~114\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_clock(29),
	cin => \Add0~114\,
	sumout => \Add0~117_sumout\,
	cout => \Add0~118\);

-- Location: FF_X67_Y16_N29
\clock[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~117_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(29));

-- Location: LABCELL_X67_Y16_N30
\Add0~121\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~121_sumout\ = SUM(( clock(30) ) + ( GND ) + ( \Add0~118\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_clock(30),
	cin => \Add0~118\,
	sumout => \Add0~121_sumout\);

-- Location: FF_X67_Y16_N32
\clock[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~121_sumout\,
	sclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => clock(30));

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

-- Location: LABCELL_X15_Y37_N0
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


