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

-- DATE "02/27/2022 18:33:01"

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

ENTITY 	traffic_light IS
    PORT (
	CLOCK_50_B5B : IN std_logic;
	KEY : IN std_logic_vector(3 DOWNTO 0);
	LEDG : OUT std_logic_vector(9 DOWNTO 0);
	LEDR : OUT std_logic_vector(9 DOWNTO 0);
	hex3 : OUT std_logic_vector(6 DOWNTO 0);
	hex0 : OUT std_logic_vector(6 DOWNTO 0)
	);
END traffic_light;

-- Design Ports Information
-- KEY[1]	=>  Location: PIN_P12,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- KEY[2]	=>  Location: PIN_Y15,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- KEY[3]	=>  Location: PIN_Y16,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- LEDG[0]	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[1]	=>  Location: PIN_K6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[2]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[3]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[4]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[5]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[6]	=>  Location: PIN_H8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[7]	=>  Location: PIN_H9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[8]	=>  Location: PIN_AD7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[9]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[0]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[1]	=>  Location: PIN_F6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[2]	=>  Location: PIN_G6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[3]	=>  Location: PIN_G7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[4]	=>  Location: PIN_J8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[5]	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[6]	=>  Location: PIN_K10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[7]	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[8]	=>  Location: PIN_H7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[9]	=>  Location: PIN_J10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[0]	=>  Location: PIN_Y24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[1]	=>  Location: PIN_Y23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[2]	=>  Location: PIN_AA23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[3]	=>  Location: PIN_AA22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[4]	=>  Location: PIN_AC24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[5]	=>  Location: PIN_AC23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex3[6]	=>  Location: PIN_AC22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- hex0[0]	=>  Location: PIN_V19,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[1]	=>  Location: PIN_V18,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[2]	=>  Location: PIN_V17,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[3]	=>  Location: PIN_W18,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[4]	=>  Location: PIN_Y20,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[5]	=>  Location: PIN_Y19,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- hex0[6]	=>  Location: PIN_Y18,	 I/O Standard: 1.2 V,	 Current Strength: Default
-- CLOCK_50_B5B	=>  Location: PIN_R20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[0]	=>  Location: PIN_P11,	 I/O Standard: 1.2 V,	 Current Strength: Default


ARCHITECTURE structure OF traffic_light IS
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
SIGNAL ww_LEDG : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_LEDR : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_hex3 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex0 : std_logic_vector(6 DOWNTO 0);
SIGNAL \KEY[1]~input_o\ : std_logic;
SIGNAL \KEY[2]~input_o\ : std_logic;
SIGNAL \KEY[3]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50_B5B~input_o\ : std_logic;
SIGNAL \CLOCK_50_B5B~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add1~25_sumout\ : std_logic;
SIGNAL \KEY[0]~input_o\ : std_logic;
SIGNAL \Add1~26\ : std_logic;
SIGNAL \Add1~45_sumout\ : std_logic;
SIGNAL \Add1~46\ : std_logic;
SIGNAL \Add1~41_sumout\ : std_logic;
SIGNAL \Add1~42\ : std_logic;
SIGNAL \Add1~37_sumout\ : std_logic;
SIGNAL \Add1~38\ : std_logic;
SIGNAL \Add1~33_sumout\ : std_logic;
SIGNAL \Add1~34\ : std_logic;
SIGNAL \Add1~29_sumout\ : std_logic;
SIGNAL \Add1~30\ : std_logic;
SIGNAL \Add1~97_sumout\ : std_logic;
SIGNAL \Add1~98\ : std_logic;
SIGNAL \Add1~93_sumout\ : std_logic;
SIGNAL \Add1~94\ : std_logic;
SIGNAL \Add1~89_sumout\ : std_logic;
SIGNAL \Add1~90\ : std_logic;
SIGNAL \Add1~85_sumout\ : std_logic;
SIGNAL \Add1~86\ : std_logic;
SIGNAL \Add1~81_sumout\ : std_logic;
SIGNAL \Add1~82\ : std_logic;
SIGNAL \Add1~77_sumout\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Add1~78\ : std_logic;
SIGNAL \Add1~69_sumout\ : std_logic;
SIGNAL \Add1~70\ : std_logic;
SIGNAL \Add1~65_sumout\ : std_logic;
SIGNAL \Add1~66\ : std_logic;
SIGNAL \Add1~61_sumout\ : std_logic;
SIGNAL \Add1~62\ : std_logic;
SIGNAL \Add1~57_sumout\ : std_logic;
SIGNAL \Add1~58\ : std_logic;
SIGNAL \Add1~53_sumout\ : std_logic;
SIGNAL \Add1~54\ : std_logic;
SIGNAL \Add1~1_sumout\ : std_logic;
SIGNAL \Add1~2\ : std_logic;
SIGNAL \Add1~73_sumout\ : std_logic;
SIGNAL \Add1~74\ : std_logic;
SIGNAL \Add1~21_sumout\ : std_logic;
SIGNAL \Add1~22\ : std_logic;
SIGNAL \Add1~17_sumout\ : std_logic;
SIGNAL \Add1~18\ : std_logic;
SIGNAL \Add1~13_sumout\ : std_logic;
SIGNAL \Add1~14\ : std_logic;
SIGNAL \Add1~9_sumout\ : std_logic;
SIGNAL \Add1~10\ : std_logic;
SIGNAL \Add1~5_sumout\ : std_logic;
SIGNAL \Add1~6\ : std_logic;
SIGNAL \Add1~49_sumout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \seconds_20[1]~3_combout\ : std_logic;
SIGNAL \seconds_20[2]~2_combout\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \seconds_20[3]~1_combout\ : std_logic;
SIGNAL \seconds_20[4]~0_combout\ : std_logic;
SIGNAL \Equal5~0_combout\ : std_logic;
SIGNAL \seconds_20[0]~4_combout\ : std_logic;
SIGNAL \seconds~0_combout\ : std_logic;
SIGNAL \state[1]~1_combout\ : std_logic;
SIGNAL \state[1]~DUPLICATE_q\ : std_logic;
SIGNAL \seconds~4_combout\ : std_logic;
SIGNAL \seconds~5_combout\ : std_logic;
SIGNAL \seconds[0]~1_combout\ : std_logic;
SIGNAL \seconds[0]~2_combout\ : std_logic;
SIGNAL \seconds~3_combout\ : std_logic;
SIGNAL \state[0]~0_combout\ : std_logic;
SIGNAL \state[0]~3_combout\ : std_logic;
SIGNAL \state[0]~DUPLICATE_q\ : std_logic;
SIGNAL \Equal4~0_combout\ : std_logic;
SIGNAL \state[2]~2_combout\ : std_logic;
SIGNAL \Equal2~0_combout\ : std_logic;
SIGNAL \Mux7~0_combout\ : std_logic;
SIGNAL \Equal1~0_combout\ : std_logic;
SIGNAL \Mux9~0_combout\ : std_logic;
SIGNAL \EWR~0_combout\ : std_logic;
SIGNAL \EWG~q\ : std_logic;
SIGNAL \Mux7~1_combout\ : std_logic;
SIGNAL \NSG~q\ : std_logic;
SIGNAL \Mux8~0_combout\ : std_logic;
SIGNAL \Mux8~1_combout\ : std_logic;
SIGNAL \Mux8~2_combout\ : std_logic;
SIGNAL \NSR~q\ : std_logic;
SIGNAL \Mux10~0_combout\ : std_logic;
SIGNAL \Mux10~1_combout\ : std_logic;
SIGNAL \EWR~q\ : std_logic;
SIGNAL \hex3_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex3_inst|Mux0~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux6~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux5~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux4~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux3~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux2~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux1~0_combout\ : std_logic;
SIGNAL \hex0_inst|Mux0~0_combout\ : std_logic;
SIGNAL counter : std_logic_vector(24 DOWNTO 0);
SIGNAL state : std_logic_vector(2 DOWNTO 0);
SIGNAL seconds : std_logic_vector(3 DOWNTO 0);
SIGNAL seconds_20 : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_state[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_state[1]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_KEY[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_Add0~0_combout\ : std_logic;
SIGNAL \ALT_INV_seconds[0]~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal5~0_combout\ : std_logic;
SIGNAL ALT_INV_seconds_20 : std_logic_vector(4 DOWNTO 0);
SIGNAL \ALT_INV_state[0]~0_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~4_combout\ : std_logic;
SIGNAL \ALT_INV_Mux10~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux8~1_combout\ : std_logic;
SIGNAL \ALT_INV_Mux8~0_combout\ : std_logic;
SIGNAL \ALT_INV_Equal4~0_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~3_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~2_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_Equal1~0_combout\ : std_logic;
SIGNAL \ALT_INV_Equal2~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux7~0_combout\ : std_logic;
SIGNAL \hex0_inst|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_seconds : std_logic_vector(3 DOWNTO 0);
SIGNAL ALT_INV_state : std_logic_vector(2 DOWNTO 0);
SIGNAL \ALT_INV_EWR~q\ : std_logic;
SIGNAL \ALT_INV_NSR~q\ : std_logic;
SIGNAL \ALT_INV_NSG~q\ : std_logic;
SIGNAL \ALT_INV_EWG~q\ : std_logic;
SIGNAL ALT_INV_counter : std_logic_vector(24 DOWNTO 0);

BEGIN

ww_CLOCK_50_B5B <= CLOCK_50_B5B;
ww_KEY <= KEY;
LEDG <= ww_LEDG;
LEDR <= ww_LEDR;
hex3 <= ww_hex3;
hex0 <= ww_hex0;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_state[0]~DUPLICATE_q\ <= NOT \state[0]~DUPLICATE_q\;
\ALT_INV_state[1]~DUPLICATE_q\ <= NOT \state[1]~DUPLICATE_q\;
\ALT_INV_KEY[0]~input_o\ <= NOT \KEY[0]~input_o\;
\ALT_INV_Add0~0_combout\ <= NOT \Add0~0_combout\;
\ALT_INV_seconds[0]~1_combout\ <= NOT \seconds[0]~1_combout\;
\ALT_INV_Equal5~0_combout\ <= NOT \Equal5~0_combout\;
ALT_INV_seconds_20(0) <= NOT seconds_20(0);
ALT_INV_seconds_20(1) <= NOT seconds_20(1);
ALT_INV_seconds_20(2) <= NOT seconds_20(2);
ALT_INV_seconds_20(3) <= NOT seconds_20(3);
ALT_INV_seconds_20(4) <= NOT seconds_20(4);
\ALT_INV_state[0]~0_combout\ <= NOT \state[0]~0_combout\;
\ALT_INV_Equal0~4_combout\ <= NOT \Equal0~4_combout\;
\ALT_INV_Mux10~0_combout\ <= NOT \Mux10~0_combout\;
\ALT_INV_Mux8~1_combout\ <= NOT \Mux8~1_combout\;
\ALT_INV_Mux8~0_combout\ <= NOT \Mux8~0_combout\;
\ALT_INV_Equal4~0_combout\ <= NOT \Equal4~0_combout\;
\ALT_INV_Equal0~3_combout\ <= NOT \Equal0~3_combout\;
\ALT_INV_Equal0~2_combout\ <= NOT \Equal0~2_combout\;
\ALT_INV_Equal0~1_combout\ <= NOT \Equal0~1_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_Equal1~0_combout\ <= NOT \Equal1~0_combout\;
\ALT_INV_Equal2~0_combout\ <= NOT \Equal2~0_combout\;
\ALT_INV_Mux7~0_combout\ <= NOT \Mux7~0_combout\;
\hex0_inst|ALT_INV_Mux0~0_combout\ <= NOT \hex0_inst|Mux0~0_combout\;
ALT_INV_seconds(3) <= NOT seconds(3);
ALT_INV_seconds(2) <= NOT seconds(2);
ALT_INV_seconds(1) <= NOT seconds(1);
ALT_INV_seconds(0) <= NOT seconds(0);
ALT_INV_state(0) <= NOT state(0);
ALT_INV_state(2) <= NOT state(2);
ALT_INV_state(1) <= NOT state(1);
\ALT_INV_EWR~q\ <= NOT \EWR~q\;
\ALT_INV_NSR~q\ <= NOT \NSR~q\;
\ALT_INV_NSG~q\ <= NOT \NSG~q\;
\ALT_INV_EWG~q\ <= NOT \EWG~q\;
ALT_INV_counter(6) <= NOT counter(6);
ALT_INV_counter(7) <= NOT counter(7);
ALT_INV_counter(8) <= NOT counter(8);
ALT_INV_counter(9) <= NOT counter(9);
ALT_INV_counter(10) <= NOT counter(10);
ALT_INV_counter(11) <= NOT counter(11);
ALT_INV_counter(18) <= NOT counter(18);
ALT_INV_counter(12) <= NOT counter(12);
ALT_INV_counter(13) <= NOT counter(13);
ALT_INV_counter(14) <= NOT counter(14);
ALT_INV_counter(15) <= NOT counter(15);
ALT_INV_counter(16) <= NOT counter(16);
ALT_INV_counter(24) <= NOT counter(24);
ALT_INV_counter(1) <= NOT counter(1);
ALT_INV_counter(2) <= NOT counter(2);
ALT_INV_counter(3) <= NOT counter(3);
ALT_INV_counter(4) <= NOT counter(4);
ALT_INV_counter(5) <= NOT counter(5);
ALT_INV_counter(0) <= NOT counter(0);
ALT_INV_counter(19) <= NOT counter(19);
ALT_INV_counter(20) <= NOT counter(20);
ALT_INV_counter(21) <= NOT counter(21);
ALT_INV_counter(22) <= NOT counter(22);
ALT_INV_counter(23) <= NOT counter(23);
ALT_INV_counter(17) <= NOT counter(17);

-- Location: IOOBUF_X10_Y61_N42
\LEDG[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(0));

-- Location: IOOBUF_X10_Y61_N59
\LEDG[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(1));

-- Location: IOOBUF_X10_Y61_N76
\LEDG[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(2));

-- Location: IOOBUF_X10_Y61_N93
\LEDG[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(3));

-- Location: IOOBUF_X21_Y61_N36
\LEDG[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \EWG~q\,
	devoe => ww_devoe,
	o => ww_LEDG(4));

-- Location: IOOBUF_X21_Y61_N53
\LEDG[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(5));

-- Location: IOOBUF_X19_Y61_N2
\LEDG[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(6));

-- Location: IOOBUF_X19_Y61_N19
\LEDG[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \NSG~q\,
	devoe => ww_devoe,
	o => ww_LEDG(7));

-- Location: IOOBUF_X7_Y0_N36
\LEDG[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(8));

-- Location: IOOBUF_X55_Y61_N59
\LEDG[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(9));

-- Location: IOOBUF_X14_Y61_N53
\LEDR[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \NSR~q\,
	devoe => ww_devoe,
	o => ww_LEDR(0));

-- Location: IOOBUF_X15_Y61_N36
\LEDR[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(1));

-- Location: IOOBUF_X15_Y61_N53
\LEDR[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(2));

-- Location: IOOBUF_X14_Y61_N36
\LEDR[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(3));

-- Location: IOOBUF_X14_Y61_N19
\LEDR[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \EWR~q\,
	devoe => ww_devoe,
	o => ww_LEDR(4));

-- Location: IOOBUF_X12_Y61_N53
\LEDR[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(5));

-- Location: IOOBUF_X12_Y61_N2
\LEDR[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(6));

-- Location: IOOBUF_X14_Y61_N2
\LEDR[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(7));

-- Location: IOOBUF_X12_Y61_N36
\LEDR[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(8));

-- Location: IOOBUF_X12_Y61_N19
\LEDR[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(9));

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

-- Location: LABCELL_X46_Y6_N30
\Add1~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~25_sumout\ = SUM(( counter(0) ) + ( VCC ) + ( !VCC ))
-- \Add1~26\ = CARRY(( counter(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(0),
	cin => GND,
	sumout => \Add1~25_sumout\,
	cout => \Add1~26\);

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

-- Location: FF_X46_Y6_N32
\counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~25_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(0));

-- Location: LABCELL_X46_Y6_N33
\Add1~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~45_sumout\ = SUM(( counter(1) ) + ( GND ) + ( \Add1~26\ ))
-- \Add1~46\ = CARRY(( counter(1) ) + ( GND ) + ( \Add1~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(1),
	cin => \Add1~26\,
	sumout => \Add1~45_sumout\,
	cout => \Add1~46\);

-- Location: FF_X46_Y6_N35
\counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~45_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(1));

-- Location: LABCELL_X46_Y6_N36
\Add1~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~41_sumout\ = SUM(( counter(2) ) + ( GND ) + ( \Add1~46\ ))
-- \Add1~42\ = CARRY(( counter(2) ) + ( GND ) + ( \Add1~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(2),
	cin => \Add1~46\,
	sumout => \Add1~41_sumout\,
	cout => \Add1~42\);

-- Location: FF_X46_Y6_N38
\counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~41_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(2));

-- Location: LABCELL_X46_Y6_N39
\Add1~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~37_sumout\ = SUM(( counter(3) ) + ( GND ) + ( \Add1~42\ ))
-- \Add1~38\ = CARRY(( counter(3) ) + ( GND ) + ( \Add1~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(3),
	cin => \Add1~42\,
	sumout => \Add1~37_sumout\,
	cout => \Add1~38\);

-- Location: FF_X46_Y6_N41
\counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~37_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(3));

-- Location: LABCELL_X46_Y6_N42
\Add1~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~33_sumout\ = SUM(( counter(4) ) + ( GND ) + ( \Add1~38\ ))
-- \Add1~34\ = CARRY(( counter(4) ) + ( GND ) + ( \Add1~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(4),
	cin => \Add1~38\,
	sumout => \Add1~33_sumout\,
	cout => \Add1~34\);

-- Location: FF_X46_Y6_N44
\counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~33_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(4));

-- Location: LABCELL_X46_Y6_N45
\Add1~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~29_sumout\ = SUM(( counter(5) ) + ( GND ) + ( \Add1~34\ ))
-- \Add1~30\ = CARRY(( counter(5) ) + ( GND ) + ( \Add1~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(5),
	cin => \Add1~34\,
	sumout => \Add1~29_sumout\,
	cout => \Add1~30\);

-- Location: FF_X46_Y6_N47
\counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~29_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(5));

-- Location: LABCELL_X46_Y6_N48
\Add1~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~97_sumout\ = SUM(( counter(6) ) + ( GND ) + ( \Add1~30\ ))
-- \Add1~98\ = CARRY(( counter(6) ) + ( GND ) + ( \Add1~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(6),
	cin => \Add1~30\,
	sumout => \Add1~97_sumout\,
	cout => \Add1~98\);

-- Location: FF_X46_Y6_N50
\counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~97_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(6));

-- Location: LABCELL_X46_Y6_N51
\Add1~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~93_sumout\ = SUM(( counter(7) ) + ( GND ) + ( \Add1~98\ ))
-- \Add1~94\ = CARRY(( counter(7) ) + ( GND ) + ( \Add1~98\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(7),
	cin => \Add1~98\,
	sumout => \Add1~93_sumout\,
	cout => \Add1~94\);

-- Location: FF_X46_Y6_N53
\counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~93_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(7));

-- Location: LABCELL_X46_Y6_N54
\Add1~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~89_sumout\ = SUM(( counter(8) ) + ( GND ) + ( \Add1~94\ ))
-- \Add1~90\ = CARRY(( counter(8) ) + ( GND ) + ( \Add1~94\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(8),
	cin => \Add1~94\,
	sumout => \Add1~89_sumout\,
	cout => \Add1~90\);

-- Location: FF_X46_Y6_N56
\counter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~89_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(8));

-- Location: LABCELL_X46_Y6_N57
\Add1~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~85_sumout\ = SUM(( counter(9) ) + ( GND ) + ( \Add1~90\ ))
-- \Add1~86\ = CARRY(( counter(9) ) + ( GND ) + ( \Add1~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(9),
	cin => \Add1~90\,
	sumout => \Add1~85_sumout\,
	cout => \Add1~86\);

-- Location: FF_X46_Y6_N59
\counter[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~85_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(9));

-- Location: LABCELL_X46_Y5_N0
\Add1~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~81_sumout\ = SUM(( counter(10) ) + ( GND ) + ( \Add1~86\ ))
-- \Add1~82\ = CARRY(( counter(10) ) + ( GND ) + ( \Add1~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(10),
	cin => \Add1~86\,
	sumout => \Add1~81_sumout\,
	cout => \Add1~82\);

-- Location: FF_X46_Y5_N2
\counter[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~81_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(10));

-- Location: LABCELL_X46_Y5_N3
\Add1~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~77_sumout\ = SUM(( counter(11) ) + ( GND ) + ( \Add1~82\ ))
-- \Add1~78\ = CARRY(( counter(11) ) + ( GND ) + ( \Add1~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(11),
	cin => \Add1~82\,
	sumout => \Add1~77_sumout\,
	cout => \Add1~78\);

-- Location: FF_X46_Y6_N14
\counter[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => \Add1~77_sumout\,
	sclr => \Equal0~4_combout\,
	sload => VCC,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(11));

-- Location: LABCELL_X46_Y6_N0
\Equal0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = ( !counter(8) & ( !counter(11) & ( (!counter(6) & (!counter(9) & (!counter(7) & !counter(10)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(6),
	datab => ALT_INV_counter(9),
	datac => ALT_INV_counter(7),
	datad => ALT_INV_counter(10),
	datae => ALT_INV_counter(8),
	dataf => ALT_INV_counter(11),
	combout => \Equal0~3_combout\);

-- Location: LABCELL_X46_Y5_N6
\Add1~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~69_sumout\ = SUM(( counter(12) ) + ( GND ) + ( \Add1~78\ ))
-- \Add1~70\ = CARRY(( counter(12) ) + ( GND ) + ( \Add1~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(12),
	cin => \Add1~78\,
	sumout => \Add1~69_sumout\,
	cout => \Add1~70\);

-- Location: FF_X46_Y5_N8
\counter[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~69_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(12));

-- Location: LABCELL_X46_Y5_N9
\Add1~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~65_sumout\ = SUM(( counter(13) ) + ( GND ) + ( \Add1~70\ ))
-- \Add1~66\ = CARRY(( counter(13) ) + ( GND ) + ( \Add1~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(13),
	cin => \Add1~70\,
	sumout => \Add1~65_sumout\,
	cout => \Add1~66\);

-- Location: FF_X46_Y5_N11
\counter[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~65_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(13));

-- Location: LABCELL_X46_Y5_N12
\Add1~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~61_sumout\ = SUM(( counter(14) ) + ( GND ) + ( \Add1~66\ ))
-- \Add1~62\ = CARRY(( counter(14) ) + ( GND ) + ( \Add1~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(14),
	cin => \Add1~66\,
	sumout => \Add1~61_sumout\,
	cout => \Add1~62\);

-- Location: FF_X46_Y5_N14
\counter[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~61_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(14));

-- Location: LABCELL_X46_Y5_N15
\Add1~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~57_sumout\ = SUM(( counter(15) ) + ( GND ) + ( \Add1~62\ ))
-- \Add1~58\ = CARRY(( counter(15) ) + ( GND ) + ( \Add1~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(15),
	cin => \Add1~62\,
	sumout => \Add1~57_sumout\,
	cout => \Add1~58\);

-- Location: FF_X46_Y5_N17
\counter[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~57_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(15));

-- Location: LABCELL_X46_Y5_N18
\Add1~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~53_sumout\ = SUM(( counter(16) ) + ( GND ) + ( \Add1~58\ ))
-- \Add1~54\ = CARRY(( counter(16) ) + ( GND ) + ( \Add1~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(16),
	cin => \Add1~58\,
	sumout => \Add1~53_sumout\,
	cout => \Add1~54\);

-- Location: FF_X46_Y5_N20
\counter[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~53_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(16));

-- Location: LABCELL_X46_Y5_N21
\Add1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~1_sumout\ = SUM(( counter(17) ) + ( GND ) + ( \Add1~54\ ))
-- \Add1~2\ = CARRY(( counter(17) ) + ( GND ) + ( \Add1~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(17),
	cin => \Add1~54\,
	sumout => \Add1~1_sumout\,
	cout => \Add1~2\);

-- Location: FF_X46_Y5_N23
\counter[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~1_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(17));

-- Location: LABCELL_X46_Y5_N24
\Add1~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~73_sumout\ = SUM(( counter(18) ) + ( GND ) + ( \Add1~2\ ))
-- \Add1~74\ = CARRY(( counter(18) ) + ( GND ) + ( \Add1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(18),
	cin => \Add1~2\,
	sumout => \Add1~73_sumout\,
	cout => \Add1~74\);

-- Location: FF_X46_Y5_N26
\counter[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~73_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(18));

-- Location: LABCELL_X46_Y5_N27
\Add1~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~21_sumout\ = SUM(( counter(19) ) + ( GND ) + ( \Add1~74\ ))
-- \Add1~22\ = CARRY(( counter(19) ) + ( GND ) + ( \Add1~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(19),
	cin => \Add1~74\,
	sumout => \Add1~21_sumout\,
	cout => \Add1~22\);

-- Location: FF_X46_Y5_N29
\counter[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~21_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(19));

-- Location: LABCELL_X46_Y5_N30
\Add1~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~17_sumout\ = SUM(( counter(20) ) + ( GND ) + ( \Add1~22\ ))
-- \Add1~18\ = CARRY(( counter(20) ) + ( GND ) + ( \Add1~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(20),
	cin => \Add1~22\,
	sumout => \Add1~17_sumout\,
	cout => \Add1~18\);

-- Location: FF_X46_Y5_N32
\counter[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~17_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(20));

-- Location: LABCELL_X46_Y5_N33
\Add1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~13_sumout\ = SUM(( counter(21) ) + ( GND ) + ( \Add1~18\ ))
-- \Add1~14\ = CARRY(( counter(21) ) + ( GND ) + ( \Add1~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(21),
	cin => \Add1~18\,
	sumout => \Add1~13_sumout\,
	cout => \Add1~14\);

-- Location: FF_X46_Y5_N35
\counter[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~13_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(21));

-- Location: LABCELL_X46_Y5_N36
\Add1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~9_sumout\ = SUM(( counter(22) ) + ( GND ) + ( \Add1~14\ ))
-- \Add1~10\ = CARRY(( counter(22) ) + ( GND ) + ( \Add1~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(22),
	cin => \Add1~14\,
	sumout => \Add1~9_sumout\,
	cout => \Add1~10\);

-- Location: FF_X46_Y5_N38
\counter[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~9_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(22));

-- Location: LABCELL_X46_Y5_N39
\Add1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~5_sumout\ = SUM(( counter(23) ) + ( GND ) + ( \Add1~10\ ))
-- \Add1~6\ = CARRY(( counter(23) ) + ( GND ) + ( \Add1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(23),
	cin => \Add1~10\,
	sumout => \Add1~5_sumout\,
	cout => \Add1~6\);

-- Location: FF_X46_Y5_N41
\counter[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~5_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(23));

-- Location: LABCELL_X46_Y5_N42
\Add1~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~49_sumout\ = SUM(( counter(24) ) + ( GND ) + ( \Add1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(24),
	cin => \Add1~6\,
	sumout => \Add1~49_sumout\);

-- Location: FF_X46_Y5_N44
\counter[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add1~49_sumout\,
	sclr => \Equal0~4_combout\,
	ena => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(24));

-- Location: LABCELL_X46_Y6_N9
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( !counter(24) & ( !counter(4) & ( (!counter(1) & (!counter(5) & (!counter(3) & !counter(2)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(1),
	datab => ALT_INV_counter(5),
	datac => ALT_INV_counter(3),
	datad => ALT_INV_counter(2),
	datae => ALT_INV_counter(24),
	dataf => ALT_INV_counter(4),
	combout => \Equal0~1_combout\);

-- Location: LABCELL_X46_Y5_N54
\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ( !counter(12) & ( !counter(15) & ( (!counter(16) & (!counter(13) & (!counter(18) & !counter(14)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(16),
	datab => ALT_INV_counter(13),
	datac => ALT_INV_counter(18),
	datad => ALT_INV_counter(14),
	datae => ALT_INV_counter(12),
	dataf => ALT_INV_counter(15),
	combout => \Equal0~2_combout\);

-- Location: LABCELL_X46_Y5_N48
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( !counter(22) & ( !counter(0) & ( (!counter(19) & (!counter(20) & (!counter(21) & !counter(23)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(19),
	datab => ALT_INV_counter(20),
	datac => ALT_INV_counter(21),
	datad => ALT_INV_counter(23),
	datae => ALT_INV_counter(22),
	dataf => ALT_INV_counter(0),
	combout => \Equal0~0_combout\);

-- Location: LABCELL_X46_Y6_N18
\Equal0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = ( \Equal0~0_combout\ & ( (\Equal0~3_combout\ & (\Equal0~1_combout\ & (\Equal0~2_combout\ & !counter(17)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000001000000000000000100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~3_combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_Equal0~2_combout\,
	datad => ALT_INV_counter(17),
	dataf => \ALT_INV_Equal0~0_combout\,
	combout => \Equal0~4_combout\);

-- Location: LABCELL_X45_Y6_N27
\seconds_20[1]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds_20[1]~3_combout\ = ( \Equal5~0_combout\ & ( !seconds_20(1) $ (((!seconds_20(0)) # (\KEY[0]~input_o\))) ) ) # ( !\Equal5~0_combout\ & ( !seconds_20(1) $ (((!seconds_20(0)) # ((!\Equal0~4_combout\) # (\KEY[0]~input_o\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011011000110011001101100011001101100110001100110110011000110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds_20(0),
	datab => ALT_INV_seconds_20(1),
	datac => \ALT_INV_Equal0~4_combout\,
	datad => \ALT_INV_KEY[0]~input_o\,
	dataf => \ALT_INV_Equal5~0_combout\,
	combout => \seconds_20[1]~3_combout\);

-- Location: FF_X45_Y6_N29
\seconds_20[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds_20[1]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds_20(1));

-- Location: LABCELL_X45_Y6_N42
\seconds_20[2]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds_20[2]~2_combout\ = ( seconds_20(2) & ( seconds_20(1) & ( ((!\Equal5~0_combout\ & ((!seconds_20(0)) # (!\Equal0~4_combout\)))) # (\KEY[0]~input_o\) ) ) ) # ( !seconds_20(2) & ( seconds_20(1) & ( (!\Equal5~0_combout\ & (!\KEY[0]~input_o\ & 
-- (seconds_20(0) & \Equal0~4_combout\))) ) ) ) # ( seconds_20(2) & ( !seconds_20(1) & ( (!\Equal5~0_combout\) # (\KEY[0]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101110111011101100000000000010001011101110110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal5~0_combout\,
	datab => \ALT_INV_KEY[0]~input_o\,
	datac => ALT_INV_seconds_20(0),
	datad => \ALT_INV_Equal0~4_combout\,
	datae => ALT_INV_seconds_20(2),
	dataf => ALT_INV_seconds_20(1),
	combout => \seconds_20[2]~2_combout\);

-- Location: FF_X45_Y6_N44
\seconds_20[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds_20[2]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds_20(2));

-- Location: LABCELL_X45_Y6_N57
\Add0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~0_combout\ = ( seconds_20(1) & ( (seconds_20(2) & seconds_20(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000011110000000000001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_seconds_20(2),
	datad => ALT_INV_seconds_20(0),
	dataf => ALT_INV_seconds_20(1),
	combout => \Add0~0_combout\);

-- Location: LABCELL_X45_Y6_N0
\seconds_20[3]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds_20[3]~1_combout\ = ( \Equal0~4_combout\ & ( !seconds_20(3) $ (((!\Add0~0_combout\) # (\KEY[0]~input_o\))) ) ) # ( !\Equal0~4_combout\ & ( !seconds_20(3) $ (((!\Equal5~0_combout\) # ((!\Add0~0_combout\) # (\KEY[0]~input_o\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000011101111000100001110111100110000110011110011000011001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal5~0_combout\,
	datab => \ALT_INV_Add0~0_combout\,
	datac => \ALT_INV_KEY[0]~input_o\,
	datad => ALT_INV_seconds_20(3),
	dataf => \ALT_INV_Equal0~4_combout\,
	combout => \seconds_20[3]~1_combout\);

-- Location: FF_X45_Y6_N2
\seconds_20[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds_20[3]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds_20(3));

-- Location: LABCELL_X45_Y6_N18
\seconds_20[4]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds_20[4]~0_combout\ = ( seconds_20(4) & ( \Equal5~0_combout\ & ( \KEY[0]~input_o\ ) ) ) # ( seconds_20(4) & ( !\Equal5~0_combout\ & ( ((!\Add0~0_combout\) # ((!seconds_20(3)) # (!\Equal0~4_combout\))) # (\KEY[0]~input_o\) ) ) ) # ( !seconds_20(4) & 
-- ( !\Equal5~0_combout\ & ( (!\KEY[0]~input_o\ & (\Add0~0_combout\ & (seconds_20(3) & \Equal0~4_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010111111111111110100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_KEY[0]~input_o\,
	datab => \ALT_INV_Add0~0_combout\,
	datac => ALT_INV_seconds_20(3),
	datad => \ALT_INV_Equal0~4_combout\,
	datae => ALT_INV_seconds_20(4),
	dataf => \ALT_INV_Equal5~0_combout\,
	combout => \seconds_20[4]~0_combout\);

-- Location: FF_X45_Y6_N20
\seconds_20[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds_20[4]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds_20(4));

-- Location: LABCELL_X45_Y6_N24
\Equal5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal5~0_combout\ = ( !seconds_20(2) & ( (seconds_20(0) & (seconds_20(1) & (seconds_20(4) & !seconds_20(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000000000000010000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds_20(0),
	datab => ALT_INV_seconds_20(1),
	datac => ALT_INV_seconds_20(4),
	datad => ALT_INV_seconds_20(3),
	dataf => ALT_INV_seconds_20(2),
	combout => \Equal5~0_combout\);

-- Location: LABCELL_X45_Y6_N3
\seconds_20[0]~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds_20[0]~4_combout\ = ( \Equal0~4_combout\ & ( !\KEY[0]~input_o\ $ (seconds_20(0)) ) ) # ( !\Equal0~4_combout\ & ( !seconds_20(0) $ (((!\Equal5~0_combout\) # (\KEY[0]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000010101111010100001010111111110000000011111111000000001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal5~0_combout\,
	datac => \ALT_INV_KEY[0]~input_o\,
	datad => ALT_INV_seconds_20(0),
	dataf => \ALT_INV_Equal0~4_combout\,
	combout => \seconds_20[0]~4_combout\);

-- Location: FF_X45_Y6_N5
\seconds_20[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds_20[0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds_20(0));

-- Location: LABCELL_X45_Y6_N30
\seconds~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds~0_combout\ = ( !seconds(0) & ( seconds_20(4) & ( (seconds_20(0) & (seconds_20(1) & (!seconds_20(3) & !seconds_20(2)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000010000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds_20(0),
	datab => ALT_INV_seconds_20(1),
	datac => ALT_INV_seconds_20(3),
	datad => ALT_INV_seconds_20(2),
	datae => ALT_INV_seconds(0),
	dataf => ALT_INV_seconds_20(4),
	combout => \seconds~0_combout\);

-- Location: FF_X45_Y6_N41
\state[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \state[1]~1_combout\,
	clrn => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => state(1));

-- Location: LABCELL_X45_Y6_N39
\state[1]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \state[1]~1_combout\ = ( \state[0]~0_combout\ & ( !state(1) $ (((!\state[0]~DUPLICATE_q\) # (!\Equal0~4_combout\))) ) ) # ( !\state[0]~0_combout\ & ( state(1) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100010001111011100001000111101110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state[0]~DUPLICATE_q\,
	datab => \ALT_INV_Equal0~4_combout\,
	datad => ALT_INV_state(1),
	dataf => \ALT_INV_state[0]~0_combout\,
	combout => \state[1]~1_combout\);

-- Location: FF_X45_Y6_N40
\state[1]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \state[1]~1_combout\,
	clrn => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state[1]~DUPLICATE_q\);

-- Location: LABCELL_X45_Y6_N6
\seconds~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds~4_combout\ = ( seconds(1) & ( (\Equal5~0_combout\ & (!seconds(0) $ (!seconds(2)))) ) ) # ( !seconds(1) & ( (\Equal5~0_combout\ & seconds(2)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001010101000000000101010100010001010001000001000101000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal5~0_combout\,
	datab => ALT_INV_seconds(0),
	datad => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(1),
	combout => \seconds~4_combout\);

-- Location: FF_X45_Y6_N8
\seconds[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds~4_combout\,
	ena => \seconds[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds(2));

-- Location: LABCELL_X45_Y6_N9
\seconds~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds~5_combout\ = ( seconds(1) & ( (\Equal5~0_combout\ & (!seconds(3) $ (((!seconds(0)) # (!seconds(2)))))) ) ) # ( !seconds(1) & ( (\Equal5~0_combout\ & seconds(3)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001010101000000000101010100000001010101000000000101010100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal5~0_combout\,
	datab => ALT_INV_seconds(0),
	datac => ALT_INV_seconds(2),
	datad => ALT_INV_seconds(3),
	dataf => ALT_INV_seconds(1),
	combout => \seconds~5_combout\);

-- Location: FF_X45_Y6_N11
\seconds[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds~5_combout\,
	ena => \seconds[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds(3));

-- Location: LABCELL_X45_Y6_N12
\seconds[0]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds[0]~1_combout\ = ( seconds(2) & ( !seconds(3) & ( (!seconds(1) & (!\state[1]~DUPLICATE_q\ & (\state[0]~DUPLICATE_q\ & seconds(0)))) ) ) ) # ( !seconds(2) & ( !seconds(3) & ( (!seconds(1) & (\state[1]~DUPLICATE_q\ & (\state[0]~DUPLICATE_q\ & 
-- seconds(0)))) # (seconds(1) & (!\state[0]~DUPLICATE_q\ & (!\state[1]~DUPLICATE_q\ $ (seconds(0))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100000000010010000000000000100000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datab => \ALT_INV_state[1]~DUPLICATE_q\,
	datac => \ALT_INV_state[0]~DUPLICATE_q\,
	datad => ALT_INV_seconds(0),
	datae => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(3),
	combout => \seconds[0]~1_combout\);

-- Location: LABCELL_X45_Y6_N54
\seconds[0]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds[0]~2_combout\ = ( \Equal0~4_combout\ & ( (!\KEY[0]~input_o\ & ((\seconds[0]~1_combout\) # (\Equal5~0_combout\))) ) ) # ( !\Equal0~4_combout\ & ( (\Equal5~0_combout\ & !\KEY[0]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000001010000010100000101000001110000011100000111000001110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal5~0_combout\,
	datab => \ALT_INV_seconds[0]~1_combout\,
	datac => \ALT_INV_KEY[0]~input_o\,
	dataf => \ALT_INV_Equal0~4_combout\,
	combout => \seconds[0]~2_combout\);

-- Location: FF_X45_Y6_N32
\seconds[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds~0_combout\,
	ena => \seconds[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds(0));

-- Location: LABCELL_X45_Y6_N48
\seconds~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \seconds~3_combout\ = ( \Equal5~0_combout\ & ( !seconds(0) $ (!seconds(1)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000110011110011000011001111001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_seconds(0),
	datad => ALT_INV_seconds(1),
	dataf => \ALT_INV_Equal5~0_combout\,
	combout => \seconds~3_combout\);

-- Location: FF_X45_Y6_N50
\seconds[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \seconds~3_combout\,
	ena => \seconds[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => seconds(1));

-- Location: LABCELL_X45_Y6_N15
\state[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \state[0]~0_combout\ = ( seconds(2) & ( !seconds(3) & ( (!seconds(1) & (!\state[1]~DUPLICATE_q\ & (seconds(0) & \state[0]~DUPLICATE_q\))) ) ) ) # ( !seconds(2) & ( !seconds(3) & ( (!seconds(1) & (\state[1]~DUPLICATE_q\ & (seconds(0) & 
-- \state[0]~DUPLICATE_q\))) # (seconds(1) & (!\state[0]~DUPLICATE_q\ & (!\state[1]~DUPLICATE_q\ $ (seconds(0))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100000100000010000000000000100000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datab => \ALT_INV_state[1]~DUPLICATE_q\,
	datac => ALT_INV_seconds(0),
	datad => \ALT_INV_state[0]~DUPLICATE_q\,
	datae => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(3),
	combout => \state[0]~0_combout\);

-- Location: FF_X46_Y6_N22
\state[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \state[0]~3_combout\,
	clrn => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => state(0));

-- Location: LABCELL_X46_Y6_N21
\state[0]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \state[0]~3_combout\ = ( \Equal0~4_combout\ & ( !\state[0]~0_combout\ $ (!state(0)) ) ) # ( !\Equal0~4_combout\ & ( state(0) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100001111111100000000111111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state[0]~0_combout\,
	datad => ALT_INV_state(0),
	dataf => \ALT_INV_Equal0~4_combout\,
	combout => \state[0]~3_combout\);

-- Location: FF_X46_Y6_N23
\state[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \state[0]~3_combout\,
	clrn => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state[0]~DUPLICATE_q\);

-- Location: LABCELL_X46_Y6_N27
\Equal4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal4~0_combout\ = ( seconds(0) & ( (!seconds(2) & (!seconds(3) & !seconds(1))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000100000001000000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(2),
	datab => ALT_INV_seconds(3),
	datac => ALT_INV_seconds(1),
	dataf => ALT_INV_seconds(0),
	combout => \Equal4~0_combout\);

-- Location: LABCELL_X45_Y6_N36
\state[2]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \state[2]~2_combout\ = ( \state[1]~DUPLICATE_q\ & ( !state(2) $ (((!\state[0]~DUPLICATE_q\) # ((!\Equal0~4_combout\) # (!\Equal4~0_combout\)))) ) ) # ( !\state[1]~DUPLICATE_q\ & ( state(2) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000001111111100000000111111110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state[0]~DUPLICATE_q\,
	datab => \ALT_INV_Equal0~4_combout\,
	datac => \ALT_INV_Equal4~0_combout\,
	datad => ALT_INV_state(2),
	dataf => \ALT_INV_state[1]~DUPLICATE_q\,
	combout => \state[2]~2_combout\);

-- Location: FF_X45_Y6_N38
\state[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \state[2]~2_combout\,
	clrn => \ALT_INV_KEY[0]~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => state(2));

-- Location: MLABCELL_X47_Y6_N18
\Equal2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal2~0_combout\ = ( !seconds(3) & ( (!seconds(1) & (seconds(0) & seconds(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001010000000000000101000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datac => ALT_INV_seconds(0),
	datad => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(3),
	combout => \Equal2~0_combout\);

-- Location: MLABCELL_X47_Y6_N36
\Mux7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux7~0_combout\ = ( !seconds(2) & ( seconds(1) & ( (\state[1]~DUPLICATE_q\ & (!state(0) & (seconds(0) & !seconds(3)))) ) ) ) # ( !seconds(2) & ( !seconds(1) & ( (\state[1]~DUPLICATE_q\ & (state(0) & (seconds(0) & !seconds(3)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000000000000000000000000000100000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state[1]~DUPLICATE_q\,
	datab => ALT_INV_state(0),
	datac => ALT_INV_seconds(0),
	datad => ALT_INV_seconds(3),
	datae => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(1),
	combout => \Mux7~0_combout\);

-- Location: MLABCELL_X47_Y6_N9
\Equal1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal1~0_combout\ = ( !seconds(0) & ( (seconds(1) & (!seconds(3) & !seconds(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000000000000010100000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datac => ALT_INV_seconds(3),
	datad => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(0),
	combout => \Equal1~0_combout\);

-- Location: MLABCELL_X47_Y6_N54
\Mux9~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux9~0_combout\ = ( !state(0) & ( (!\EWG~q\ & (state(2) & (!\Equal1~0_combout\ & ((!\state[1]~DUPLICATE_q\))))) # (\EWG~q\ & ((((\Equal1~0_combout\ & !\state[1]~DUPLICATE_q\)) # (\Mux7~0_combout\)))) ) ) # ( state(0) & ( (!\EWG~q\ & (state(2) & 
-- (!\Equal2~0_combout\ & ((!\state[1]~DUPLICATE_q\))))) # (\EWG~q\ & (((!\state[1]~DUPLICATE_q\ & ((\Equal2~0_combout\) # (state(2))))) # (\Mux7~0_combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "0010010101110101001101010111010100000000010101010000000001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_EWG~q\,
	datab => ALT_INV_state(2),
	datac => \ALT_INV_Equal2~0_combout\,
	datad => \ALT_INV_Mux7~0_combout\,
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_state[1]~DUPLICATE_q\,
	datag => \ALT_INV_Equal1~0_combout\,
	combout => \Mux9~0_combout\);

-- Location: MLABCELL_X47_Y6_N0
\EWR~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \EWR~0_combout\ = ( \Equal0~0_combout\ & ( \Equal0~1_combout\ & ( (!\KEY[0]~input_o\ & (\Equal0~3_combout\ & (!counter(17) & \Equal0~2_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_KEY[0]~input_o\,
	datab => \ALT_INV_Equal0~3_combout\,
	datac => ALT_INV_counter(17),
	datad => \ALT_INV_Equal0~2_combout\,
	datae => \ALT_INV_Equal0~0_combout\,
	dataf => \ALT_INV_Equal0~1_combout\,
	combout => \EWR~0_combout\);

-- Location: FF_X47_Y6_N56
EWG : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Mux9~0_combout\,
	ena => \EWR~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \EWG~q\);

-- Location: MLABCELL_X47_Y6_N12
\Mux7~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux7~1_combout\ = ( !state(0) & ( (!\NSG~q\ & (!state(2) & (!\Equal1~0_combout\ & ((!\state[1]~DUPLICATE_q\))))) # (\NSG~q\ & ((((\Equal1~0_combout\ & !\state[1]~DUPLICATE_q\)) # (\Mux7~0_combout\)))) ) ) # ( state(0) & ( (!\NSG~q\ & (!state(2) & 
-- (!\Equal2~0_combout\ & ((!\state[1]~DUPLICATE_q\))))) # (\NSG~q\ & (((!\state[1]~DUPLICATE_q\ & ((!state(2)) # (\Equal2~0_combout\)))) # (\Mux7~0_combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "1000010111010101110001011101010100000000010101010000000001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_NSG~q\,
	datab => ALT_INV_state(2),
	datac => \ALT_INV_Equal2~0_combout\,
	datad => \ALT_INV_Mux7~0_combout\,
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_state[1]~DUPLICATE_q\,
	datag => \ALT_INV_Equal1~0_combout\,
	combout => \Mux7~1_combout\);

-- Location: FF_X47_Y6_N14
NSG : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Mux7~1_combout\,
	ena => \EWR~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \NSG~q\);

-- Location: MLABCELL_X47_Y6_N6
\Mux8~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux8~0_combout\ = ( seconds(0) & ( (!state(0) & ((!seconds(1)) # ((seconds(2)) # (seconds(3))))) ) ) # ( !seconds(0) & ( !state(0) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000010110000111100001011000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datab => ALT_INV_seconds(3),
	datac => ALT_INV_state(0),
	datad => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(0),
	combout => \Mux8~0_combout\);

-- Location: MLABCELL_X47_Y6_N33
\Mux8~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux8~1_combout\ = ( \NSR~q\ & ( (!\Mux8~0_combout\) # (((state(0) & !\Equal4~0_combout\)) # (state(2))) ) ) # ( !\NSR~q\ & ( ((state(0) & !\Equal4~0_combout\)) # (\Mux8~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011100110011011101110011001111011111110011111101111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_state(0),
	datab => \ALT_INV_Mux8~0_combout\,
	datac => ALT_INV_state(2),
	datad => \ALT_INV_Equal4~0_combout\,
	dataf => \ALT_INV_NSR~q\,
	combout => \Mux8~1_combout\);

-- Location: MLABCELL_X47_Y6_N42
\Mux8~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux8~2_combout\ = ( !state(0) & ( (!\state[1]~DUPLICATE_q\ & ((!\Equal1~0_combout\ & (state(2))) # (\Equal1~0_combout\ & (((\NSR~q\)))))) # (\state[1]~DUPLICATE_q\ & ((((\Mux8~1_combout\))))) ) ) # ( state(0) & ( (!\state[1]~DUPLICATE_q\ & 
-- ((!\Equal2~0_combout\ & (state(2))) # (\Equal2~0_combout\ & (((\NSR~q\)))))) # (\state[1]~DUPLICATE_q\ & ((((\Mux8~1_combout\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "0010000000101010001000000010101001110101011111110111010101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_state[1]~DUPLICATE_q\,
	datab => ALT_INV_state(2),
	datac => \ALT_INV_Equal2~0_combout\,
	datad => \ALT_INV_NSR~q\,
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_Mux8~1_combout\,
	datag => \ALT_INV_Equal1~0_combout\,
	combout => \Mux8~2_combout\);

-- Location: FF_X47_Y6_N44
NSR : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Mux8~2_combout\,
	ena => \EWR~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \NSR~q\);

-- Location: MLABCELL_X47_Y6_N30
\Mux10~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux10~0_combout\ = ( \EWR~q\ & ( (!\Mux8~0_combout\) # ((!state(2)) # ((state(0) & !\Equal4~0_combout\))) ) ) # ( !\EWR~q\ & ( ((state(0) & !\Equal4~0_combout\)) # (\Mux8~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111001101110011011100110111001111111111110111001111111111011100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_state(0),
	datab => \ALT_INV_Mux8~0_combout\,
	datac => \ALT_INV_Equal4~0_combout\,
	datad => ALT_INV_state(2),
	dataf => \ALT_INV_EWR~q\,
	combout => \Mux10~0_combout\);

-- Location: MLABCELL_X47_Y6_N24
\Mux10~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux10~1_combout\ = ( !state(0) & ( (!state(1) & ((!\Equal1~0_combout\ & (((!state(2))))) # (\Equal1~0_combout\ & (\EWR~q\)))) # (state(1) & ((((\Mux10~0_combout\))))) ) ) # ( state(0) & ( (!state(1) & ((!\Equal2~0_combout\ & (((!state(2))))) # 
-- (\Equal2~0_combout\ & (\EWR~q\)))) # (state(1) & ((((\Mux10~0_combout\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "1100010100000000110001010000000011000101111111111100010111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_EWR~q\,
	datab => ALT_INV_state(2),
	datac => \ALT_INV_Equal2~0_combout\,
	datad => ALT_INV_state(1),
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_Mux10~0_combout\,
	datag => \ALT_INV_Equal1~0_combout\,
	combout => \Mux10~1_combout\);

-- Location: FF_X47_Y6_N26
EWR : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Mux10~1_combout\,
	ena => \EWR~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \EWR~q\);

-- Location: LABCELL_X67_Y10_N39
\hex3_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux6~0_combout\ = ( !state(0) & ( state(2) & ( !\state[1]~DUPLICATE_q\ ) ) ) # ( state(0) & ( !state(2) & ( !\state[1]~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000011110000111100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state[1]~DUPLICATE_q\,
	datae => ALT_INV_state(0),
	dataf => ALT_INV_state(2),
	combout => \hex3_inst|Mux6~0_combout\);

-- Location: LABCELL_X67_Y10_N42
\hex3_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux5~0_combout\ = ( !state(0) & ( \state[1]~DUPLICATE_q\ & ( state(2) ) ) ) # ( state(0) & ( !\state[1]~DUPLICATE_q\ & ( state(2) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011110000111100001111000011110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_state(2),
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_state[1]~DUPLICATE_q\,
	combout => \hex3_inst|Mux5~0_combout\);

-- Location: LABCELL_X67_Y10_N0
\hex3_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux4~0_combout\ = ( !state(0) & ( \state[1]~DUPLICATE_q\ & ( !state(2) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000111100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_state(2),
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_state[1]~DUPLICATE_q\,
	combout => \hex3_inst|Mux4~0_combout\);

-- Location: LABCELL_X67_Y10_N21
\hex3_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux3~0_combout\ = ( state(0) & ( state(2) & ( \state[1]~DUPLICATE_q\ ) ) ) # ( !state(0) & ( state(2) & ( !\state[1]~DUPLICATE_q\ ) ) ) # ( state(0) & ( !state(2) & ( !\state[1]~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000011110000111100000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state[1]~DUPLICATE_q\,
	datae => ALT_INV_state(0),
	dataf => ALT_INV_state(2),
	combout => \hex3_inst|Mux3~0_combout\);

-- Location: LABCELL_X67_Y10_N24
\hex3_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux2~0_combout\ = ( state(0) & ( \state[1]~DUPLICATE_q\ ) ) # ( state(0) & ( !\state[1]~DUPLICATE_q\ ) ) # ( !state(0) & ( !\state[1]~DUPLICATE_q\ & ( state(2) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111111111111111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_state(2),
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_state[1]~DUPLICATE_q\,
	combout => \hex3_inst|Mux2~0_combout\);

-- Location: LABCELL_X67_Y10_N33
\hex3_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux1~0_combout\ = ( state(0) & ( state(2) & ( \state[1]~DUPLICATE_q\ ) ) ) # ( state(0) & ( !state(2) ) ) # ( !state(0) & ( !state(2) & ( \state[1]~DUPLICATE_q\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_state[1]~DUPLICATE_q\,
	datae => ALT_INV_state(0),
	dataf => ALT_INV_state(2),
	combout => \hex3_inst|Mux1~0_combout\);

-- Location: LABCELL_X67_Y10_N12
\hex3_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex3_inst|Mux0~0_combout\ = ( state(0) & ( \state[1]~DUPLICATE_q\ & ( state(2) ) ) ) # ( state(0) & ( !\state[1]~DUPLICATE_q\ & ( !state(2) ) ) ) # ( !state(0) & ( !\state[1]~DUPLICATE_q\ & ( !state(2) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_state(2),
	datae => ALT_INV_state(0),
	dataf => \ALT_INV_state[1]~DUPLICATE_q\,
	combout => \hex3_inst|Mux0~0_combout\);

-- Location: LABCELL_X46_Y6_N24
\hex0_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux6~0_combout\ = (!seconds(2) & (seconds(0) & (!seconds(3) $ (seconds(1))))) # (seconds(2) & (!seconds(1) & (!seconds(3) $ (seconds(0)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100100100000010010010010000001001001001000000100100100100000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(2),
	datab => ALT_INV_seconds(3),
	datac => ALT_INV_seconds(0),
	datad => ALT_INV_seconds(1),
	combout => \hex0_inst|Mux6~0_combout\);

-- Location: LABCELL_X46_Y6_N15
\hex0_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux5~0_combout\ = ( seconds(0) & ( (!seconds(1) & (seconds(2) & !seconds(3))) # (seconds(1) & ((seconds(3)))) ) ) # ( !seconds(0) & ( (seconds(2) & ((seconds(3)) # (seconds(1)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001010100010101000101010001010101000011010000110100001101000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(2),
	datab => ALT_INV_seconds(1),
	datac => ALT_INV_seconds(3),
	dataf => ALT_INV_seconds(0),
	combout => \hex0_inst|Mux5~0_combout\);

-- Location: MLABCELL_X47_Y6_N48
\hex0_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux4~0_combout\ = ( seconds(0) & ( (seconds(1) & (seconds(3) & seconds(2))) ) ) # ( !seconds(0) & ( (!seconds(3) & (seconds(1) & !seconds(2))) # (seconds(3) & ((seconds(2)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100001101000011010000110100001100000001000000010000000100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datab => ALT_INV_seconds(3),
	datac => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(0),
	combout => \hex0_inst|Mux4~0_combout\);

-- Location: LABCELL_X46_Y6_N12
\hex0_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux3~0_combout\ = ( seconds(3) & ( (seconds(1) & (!seconds(2) $ (seconds(0)))) ) ) # ( !seconds(3) & ( (!seconds(2) & (!seconds(1) & seconds(0))) # (seconds(2) & (!seconds(1) $ (seconds(0)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100100101001001010010010100100100100001001000010010000100100001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(2),
	datab => ALT_INV_seconds(1),
	datac => ALT_INV_seconds(0),
	dataf => ALT_INV_seconds(3),
	combout => \hex0_inst|Mux3~0_combout\);

-- Location: MLABCELL_X47_Y6_N51
\hex0_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux2~0_combout\ = ( seconds(0) & ( (!seconds(3)) # ((!seconds(1) & !seconds(2))) ) ) # ( !seconds(0) & ( (!seconds(1) & (!seconds(3) & seconds(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010100000000000001010000011111010111100001111101011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datac => ALT_INV_seconds(3),
	datad => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(0),
	combout => \hex0_inst|Mux2~0_combout\);

-- Location: MLABCELL_X47_Y6_N21
\hex0_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux1~0_combout\ = ( seconds(0) & ( !seconds(3) $ (((!seconds(1) & seconds(2)))) ) ) # ( !seconds(0) & ( (seconds(1) & (!seconds(3) & !seconds(2))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010000000000010001000000000011001100011001101100110001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_seconds(1),
	datab => ALT_INV_seconds(3),
	datad => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(0),
	combout => \hex0_inst|Mux1~0_combout\);

-- Location: LABCELL_X45_Y6_N51
\hex0_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \hex0_inst|Mux0~0_combout\ = ( seconds(1) & ( (!seconds(0)) # ((!seconds(2)) # (seconds(3))) ) ) # ( !seconds(1) & ( (!seconds(3) & ((seconds(2)))) # (seconds(3) & ((!seconds(2)) # (seconds(0)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111111110011000011111111001111111111110011111111111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_seconds(0),
	datac => ALT_INV_seconds(3),
	datad => ALT_INV_seconds(2),
	dataf => ALT_INV_seconds(1),
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

-- Location: LABCELL_X64_Y12_N3
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


