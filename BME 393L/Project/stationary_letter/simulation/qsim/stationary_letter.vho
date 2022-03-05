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

-- DATE "03/04/2022 20:48:42"

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

ENTITY 	stationary_letter IS
    PORT (
	CLOCK_50_B5B : IN std_logic;
	GPIO : OUT std_logic_vector(35 DOWNTO 0)
	);
END stationary_letter;

-- Design Ports Information
-- GPIO[0]	=>  Location: PIN_T21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[1]	=>  Location: PIN_D26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[2]	=>  Location: PIN_K25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[3]	=>  Location: PIN_E26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[4]	=>  Location: PIN_K26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[5]	=>  Location: PIN_M26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[6]	=>  Location: PIN_M21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[7]	=>  Location: PIN_P20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[8]	=>  Location: PIN_T22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[9]	=>  Location: PIN_T19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[10]	=>  Location: PIN_U19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[11]	=>  Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[12]	=>  Location: PIN_P8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[13]	=>  Location: PIN_R8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[14]	=>  Location: PIN_R9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[15]	=>  Location: PIN_R10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[16]	=>  Location: PIN_F26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[17]	=>  Location: PIN_Y9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[18]	=>  Location: PIN_G26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[19]	=>  Location: PIN_Y8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[20]	=>  Location: PIN_AA7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[21]	=>  Location: PIN_AA6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[22]	=>  Location: PIN_AD7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[23]	=>  Location: PIN_AD6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[24]	=>  Location: PIN_U20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[25]	=>  Location: PIN_V22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[26]	=>  Location: PIN_V20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[27]	=>  Location: PIN_W21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[28]	=>  Location: PIN_W20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[29]	=>  Location: PIN_Y24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[30]	=>  Location: PIN_Y23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[31]	=>  Location: PIN_AA23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[32]	=>  Location: PIN_AA22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[33]	=>  Location: PIN_AC24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[34]	=>  Location: PIN_AC23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- GPIO[35]	=>  Location: PIN_AC22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- CLOCK_50_B5B	=>  Location: PIN_R20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF stationary_letter IS
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
SIGNAL ww_GPIO : std_logic_vector(35 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50_B5B~input_o\ : std_logic;
SIGNAL \CLOCK_50_B5B~inputCLKENA0_outclk\ : std_logic;
SIGNAL \index[3]~1_combout\ : std_logic;
SIGNAL \index[3]~DUPLICATE_q\ : std_logic;
SIGNAL \Mux5~1_combout\ : std_logic;
SIGNAL \index[5]~0_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \Mux0~1_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \col_driver[1]~1_combout\ : std_logic;
SIGNAL \col_driver[2]~feeder_combout\ : std_logic;
SIGNAL \col_driver[3]~feeder_combout\ : std_logic;
SIGNAL \col_driver[6]~feeder_combout\ : std_logic;
SIGNAL \col_driver[7]~feeder_combout\ : std_logic;
SIGNAL \col_driver[7]~DUPLICATE_q\ : std_logic;
SIGNAL \col_driver[0]~0_combout\ : std_logic;
SIGNAL \col_driver[3]~DUPLICATE_q\ : std_logic;
SIGNAL \col_driver[4]~DUPLICATE_q\ : std_logic;
SIGNAL \col_driver[5]~DUPLICATE_q\ : std_logic;
SIGNAL index : std_logic_vector(5 DOWNTO 0);
SIGNAL col_driver : std_logic_vector(0 TO 7);
SIGNAL \ALT_INV_col_driver[7]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_col_driver[5]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_col_driver[4]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_col_driver[3]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_index[3]~DUPLICATE_q\ : std_logic;
SIGNAL ALT_INV_col_driver : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_Mux5~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux4~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL ALT_INV_index : std_logic_vector(5 DOWNTO 3);

BEGIN

ww_CLOCK_50_B5B <= CLOCK_50_B5B;
GPIO <= ww_GPIO;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_col_driver[7]~DUPLICATE_q\ <= NOT \col_driver[7]~DUPLICATE_q\;
\ALT_INV_col_driver[5]~DUPLICATE_q\ <= NOT \col_driver[5]~DUPLICATE_q\;
\ALT_INV_col_driver[4]~DUPLICATE_q\ <= NOT \col_driver[4]~DUPLICATE_q\;
\ALT_INV_col_driver[3]~DUPLICATE_q\ <= NOT \col_driver[3]~DUPLICATE_q\;
\ALT_INV_index[3]~DUPLICATE_q\ <= NOT \index[3]~DUPLICATE_q\;
ALT_INV_col_driver(7) <= NOT col_driver(7);
ALT_INV_col_driver(6) <= NOT col_driver(6);
ALT_INV_col_driver(5) <= NOT col_driver(5);
ALT_INV_col_driver(2) <= NOT col_driver(2);
ALT_INV_col_driver(1) <= NOT col_driver(1);
ALT_INV_col_driver(0) <= NOT col_driver(0);
\ALT_INV_Mux5~0_combout\ <= NOT \Mux5~0_combout\;
\ALT_INV_Mux4~0_combout\ <= NOT \Mux4~0_combout\;
\ALT_INV_Mux0~1_combout\ <= NOT \Mux0~1_combout\;
\ALT_INV_Mux0~0_combout\ <= NOT \Mux0~0_combout\;
ALT_INV_index(3) <= NOT index(3);
ALT_INV_index(4) <= NOT index(4);
ALT_INV_index(5) <= NOT index(5);

-- Location: IOOBUF_X68_Y14_N45
\GPIO[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(0));

-- Location: IOOBUF_X68_Y37_N39
\GPIO[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_GPIO(1));

-- Location: IOOBUF_X68_Y40_N45
\GPIO[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(2));

-- Location: IOOBUF_X68_Y37_N56
\GPIO[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux0~1_combout\,
	devoe => ww_devoe,
	o => ww_GPIO(3));

-- Location: IOOBUF_X68_Y40_N62
\GPIO[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(4));

-- Location: IOOBUF_X68_Y37_N22
\GPIO[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux0~1_combout\,
	devoe => ww_devoe,
	o => ww_GPIO(5));

-- Location: IOOBUF_X68_Y32_N62
\GPIO[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(6));

-- Location: IOOBUF_X68_Y22_N62
\GPIO[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux0~1_combout\,
	devoe => ww_devoe,
	o => ww_GPIO(7));

-- Location: IOOBUF_X68_Y14_N62
\GPIO[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(8));

-- Location: IOOBUF_X68_Y13_N5
\GPIO[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_GPIO(9));

-- Location: IOOBUF_X68_Y10_N45
\GPIO[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(10));

-- Location: IOOBUF_X68_Y12_N22
\GPIO[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_GPIO(11));

-- Location: IOOBUF_X7_Y0_N2
\GPIO[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(12));

-- Location: IOOBUF_X7_Y0_N19
\GPIO[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_GPIO(13));

-- Location: IOOBUF_X6_Y0_N2
\GPIO[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(14));

-- Location: IOOBUF_X6_Y0_N19
\GPIO[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(15));

-- Location: IOOBUF_X68_Y33_N39
\GPIO[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(16));

-- Location: IOOBUF_X4_Y0_N2
\GPIO[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(17));

-- Location: IOOBUF_X68_Y33_N56
\GPIO[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(18));

-- Location: IOOBUF_X6_Y0_N36
\GPIO[19]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(19));

-- Location: IOOBUF_X6_Y0_N53
\GPIO[20]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(20));

-- Location: IOOBUF_X4_Y0_N36
\GPIO[21]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => col_driver(0),
	devoe => ww_devoe,
	o => ww_GPIO(21));

-- Location: IOOBUF_X7_Y0_N36
\GPIO[22]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(22));

-- Location: IOOBUF_X7_Y0_N53
\GPIO[23]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_col_driver(1),
	devoe => ww_devoe,
	o => ww_GPIO(23));

-- Location: IOOBUF_X68_Y13_N22
\GPIO[24]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(24));

-- Location: IOOBUF_X68_Y12_N5
\GPIO[25]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_col_driver(2),
	devoe => ww_devoe,
	o => ww_GPIO(25));

-- Location: IOOBUF_X68_Y10_N62
\GPIO[26]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(26));

-- Location: IOOBUF_X68_Y11_N22
\GPIO[27]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_col_driver[3]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_GPIO(27));

-- Location: IOOBUF_X68_Y11_N5
\GPIO[28]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(28));

-- Location: IOOBUF_X68_Y13_N56
\GPIO[29]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_col_driver[4]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_GPIO(29));

-- Location: IOOBUF_X68_Y13_N39
\GPIO[30]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(30));

-- Location: IOOBUF_X68_Y11_N56
\GPIO[31]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_col_driver[5]~DUPLICATE_q\,
	devoe => ww_devoe,
	o => ww_GPIO(31));

-- Location: IOOBUF_X68_Y11_N39
\GPIO[32]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(32));

-- Location: IOOBUF_X68_Y12_N39
\GPIO[33]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_col_driver(6),
	devoe => ww_devoe,
	o => ww_GPIO(33));

-- Location: IOOBUF_X68_Y10_N96
\GPIO[34]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_GPIO(34));

-- Location: IOOBUF_X68_Y10_N79
\GPIO[35]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_col_driver(7),
	devoe => ww_devoe,
	o => ww_GPIO(35));

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

-- Location: LABCELL_X67_Y12_N21
\index[3]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \index[3]~1_combout\ = ( !index(3) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111000000000000000011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => ALT_INV_index(3),
	combout => \index[3]~1_combout\);

-- Location: FF_X67_Y12_N23
\index[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \index[3]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(3));

-- Location: FF_X67_Y12_N22
\index[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \index[3]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \index[3]~DUPLICATE_q\);

-- Location: LABCELL_X67_Y12_N9
\Mux5~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux5~1_combout\ = ( \index[3]~DUPLICATE_q\ & ( !index(4) ) ) # ( !\index[3]~DUPLICATE_q\ & ( index(4) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_index(4),
	dataf => \ALT_INV_index[3]~DUPLICATE_q\,
	combout => \Mux5~1_combout\);

-- Location: FF_X67_Y12_N11
\index[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Mux5~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(4));

-- Location: LABCELL_X67_Y12_N48
\index[5]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \index[5]~0_combout\ = ( index(4) & ( !index(3) $ (!index(5)) ) ) # ( !index(4) & ( index(5) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100001111111100000000111111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_index(3),
	datad => ALT_INV_index(5),
	dataf => ALT_INV_index(4),
	combout => \index[5]~0_combout\);

-- Location: FF_X67_Y12_N50
\index[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \index[5]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => index(5));

-- Location: LABCELL_X67_Y12_N45
\Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = ( \index[3]~DUPLICATE_q\ & ( index(5) ) ) # ( !\index[3]~DUPLICATE_q\ & ( (!index(4)) # (index(5)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111010111110101111101011111010101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_index(5),
	datac => ALT_INV_index(4),
	dataf => \ALT_INV_index[3]~DUPLICATE_q\,
	combout => \Mux0~0_combout\);

-- Location: LABCELL_X67_Y12_N33
\Mux0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux0~1_combout\ = (index(4)) # (\index[3]~DUPLICATE_q\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100111111001111110011111100111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_index[3]~DUPLICATE_q\,
	datac => ALT_INV_index(4),
	combout => \Mux0~1_combout\);

-- Location: LABCELL_X67_Y12_N6
\Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = ( index(4) & ( (index(5)) # (\index[3]~DUPLICATE_q\) ) ) # ( !index(4) & ( \index[3]~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100111111001111110011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_index[3]~DUPLICATE_q\,
	datac => ALT_INV_index(5),
	dataf => ALT_INV_index(4),
	combout => \Mux4~0_combout\);

-- Location: LABCELL_X67_Y12_N51
\Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = ( index(5) ) # ( !index(5) & ( !index(4) $ (!\index[3]~DUPLICATE_q\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100001111000011110011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(4),
	datac => \ALT_INV_index[3]~DUPLICATE_q\,
	dataf => ALT_INV_index(5),
	combout => \Mux5~0_combout\);

-- Location: LABCELL_X67_Y12_N12
\Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = ( \index[3]~DUPLICATE_q\ & ( (!index(4) & !index(5)) ) ) # ( !\index[3]~DUPLICATE_q\ & ( !index(4) $ (!index(5)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100001111000011110011000000110000001100000011000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_index(4),
	datac => ALT_INV_index(5),
	dataf => \ALT_INV_index[3]~DUPLICATE_q\,
	combout => \Mux6~0_combout\);

-- Location: LABCELL_X67_Y12_N42
\col_driver[1]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \col_driver[1]~1_combout\ = ( !col_driver(0) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_col_driver(0),
	combout => \col_driver[1]~1_combout\);

-- Location: FF_X67_Y12_N44
\col_driver[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[1]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(1));

-- Location: LABCELL_X67_Y12_N57
\col_driver[2]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \col_driver[2]~feeder_combout\ = ( col_driver(1) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_col_driver(1),
	combout => \col_driver[2]~feeder_combout\);

-- Location: FF_X67_Y12_N58
\col_driver[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(2));

-- Location: LABCELL_X67_Y12_N0
\col_driver[3]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \col_driver[3]~feeder_combout\ = ( col_driver(2) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_col_driver(2),
	combout => \col_driver[3]~feeder_combout\);

-- Location: FF_X67_Y12_N2
\col_driver[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(3));

-- Location: FF_X67_Y12_N41
\col_driver[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => col_driver(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(4));

-- Location: FF_X67_Y12_N32
\col_driver[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => col_driver(4),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(5));

-- Location: LABCELL_X67_Y12_N27
\col_driver[6]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \col_driver[6]~feeder_combout\ = ( col_driver(5) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_col_driver(5),
	combout => \col_driver[6]~feeder_combout\);

-- Location: FF_X67_Y12_N28
\col_driver[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[6]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(6));

-- Location: LABCELL_X67_Y12_N36
\col_driver[7]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \col_driver[7]~feeder_combout\ = ( col_driver(6) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_col_driver(6),
	combout => \col_driver[7]~feeder_combout\);

-- Location: FF_X67_Y12_N38
\col_driver[7]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \col_driver[7]~DUPLICATE_q\);

-- Location: LABCELL_X67_Y12_N15
\col_driver[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \col_driver[0]~0_combout\ = ( !\col_driver[7]~DUPLICATE_q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_col_driver[7]~DUPLICATE_q\,
	combout => \col_driver[0]~0_combout\);

-- Location: FF_X67_Y12_N17
\col_driver[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(0));

-- Location: FF_X67_Y12_N1
\col_driver[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \col_driver[3]~DUPLICATE_q\);

-- Location: FF_X67_Y12_N40
\col_driver[4]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => col_driver(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \col_driver[4]~DUPLICATE_q\);

-- Location: FF_X67_Y12_N31
\col_driver[5]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	asdata => col_driver(4),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \col_driver[5]~DUPLICATE_q\);

-- Location: FF_X67_Y12_N37
\col_driver[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \col_driver[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => col_driver(7));

-- Location: LABCELL_X35_Y34_N3
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


