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

-- DATE "02/25/2022 14:52:38"

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

ENTITY 	Lab4_Prelab IS
    PORT (
	CLOCK_50_B5B : IN std_logic;
	LEDG : OUT std_logic_vector(7 DOWNTO 0)
	);
END Lab4_Prelab;

-- Design Ports Information
-- LEDG[0]	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[1]	=>  Location: PIN_K6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[2]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[3]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[4]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[5]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[6]	=>  Location: PIN_H8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDG[7]	=>  Location: PIN_H9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLOCK_50_B5B	=>  Location: PIN_R20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF Lab4_Prelab IS
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
SIGNAL ww_LEDG : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50_B5B~input_o\ : std_logic;
SIGNAL \CLOCK_50_B5B~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \counter[0]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~125_sumout\ : std_logic;
SIGNAL \Add0~126\ : std_logic;
SIGNAL \Add0~121_sumout\ : std_logic;
SIGNAL \Add0~122\ : std_logic;
SIGNAL \Add0~117_sumout\ : std_logic;
SIGNAL \Add0~118\ : std_logic;
SIGNAL \Add0~113_sumout\ : std_logic;
SIGNAL \Add0~114\ : std_logic;
SIGNAL \Add0~109_sumout\ : std_logic;
SIGNAL \Add0~110\ : std_logic;
SIGNAL \Add0~105_sumout\ : std_logic;
SIGNAL \Add0~106\ : std_logic;
SIGNAL \Add0~101_sumout\ : std_logic;
SIGNAL \counter[7]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~102\ : std_logic;
SIGNAL \Add0~97_sumout\ : std_logic;
SIGNAL \counter[8]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~98\ : std_logic;
SIGNAL \Add0~93_sumout\ : std_logic;
SIGNAL \counter[9]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~94\ : std_logic;
SIGNAL \Add0~89_sumout\ : std_logic;
SIGNAL \Add0~90\ : std_logic;
SIGNAL \Add0~85_sumout\ : std_logic;
SIGNAL \counter[11]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~86\ : std_logic;
SIGNAL \Add0~81_sumout\ : std_logic;
SIGNAL \counter[12]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~82\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \counter[13]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~65_sumout\ : std_logic;
SIGNAL \Add0~66\ : std_logic;
SIGNAL \Add0~69_sumout\ : std_logic;
SIGNAL \counter[15]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~70\ : std_logic;
SIGNAL \Add0~73_sumout\ : std_logic;
SIGNAL \counter[16]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~74\ : std_logic;
SIGNAL \Add0~77_sumout\ : std_logic;
SIGNAL \Add0~78\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \counter[20]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \counter[21]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \counter[23]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
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
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \counter[19]~DUPLICATE_q\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \counter[4]~DUPLICATE_q\ : std_logic;
SIGNAL \counter[2]~DUPLICATE_q\ : std_logic;
SIGNAL \Equal0~5_combout\ : std_logic;
SIGNAL \Equal0~6_combout\ : std_logic;
SIGNAL \clock_1_Hz~0_combout\ : std_logic;
SIGNAL \clock_1_Hz~q\ : std_logic;
SIGNAL counter : std_logic_vector(31 DOWNTO 0);
SIGNAL ALT_INV_counter : std_logic_vector(31 DOWNTO 0);
SIGNAL \ALT_INV_counter[2]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[4]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[7]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[8]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[9]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[11]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[12]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[16]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[15]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[13]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[23]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[21]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[20]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_counter[19]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_Equal0~6_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~5_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~4_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~3_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~2_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_clock_1_Hz~q\ : std_logic;

BEGIN

ww_CLOCK_50_B5B <= CLOCK_50_B5B;
LEDG <= ww_LEDG;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
ALT_INV_counter(1) <= NOT counter(1);
ALT_INV_counter(2) <= NOT counter(2);
ALT_INV_counter(3) <= NOT counter(3);
ALT_INV_counter(4) <= NOT counter(4);
ALT_INV_counter(5) <= NOT counter(5);
ALT_INV_counter(6) <= NOT counter(6);
ALT_INV_counter(7) <= NOT counter(7);
ALT_INV_counter(8) <= NOT counter(8);
ALT_INV_counter(9) <= NOT counter(9);
ALT_INV_counter(10) <= NOT counter(10);
ALT_INV_counter(11) <= NOT counter(11);
ALT_INV_counter(12) <= NOT counter(12);
ALT_INV_counter(17) <= NOT counter(17);
ALT_INV_counter(16) <= NOT counter(16);
ALT_INV_counter(15) <= NOT counter(15);
ALT_INV_counter(14) <= NOT counter(14);
ALT_INV_counter(13) <= NOT counter(13);
ALT_INV_counter(0) <= NOT counter(0);
ALT_INV_counter(23) <= NOT counter(23);
ALT_INV_counter(22) <= NOT counter(22);
ALT_INV_counter(21) <= NOT counter(21);
ALT_INV_counter(20) <= NOT counter(20);
ALT_INV_counter(19) <= NOT counter(19);
ALT_INV_counter(18) <= NOT counter(18);
ALT_INV_counter(29) <= NOT counter(29);
ALT_INV_counter(28) <= NOT counter(28);
ALT_INV_counter(27) <= NOT counter(27);
ALT_INV_counter(26) <= NOT counter(26);
ALT_INV_counter(25) <= NOT counter(25);
ALT_INV_counter(24) <= NOT counter(24);
ALT_INV_counter(31) <= NOT counter(31);
ALT_INV_counter(30) <= NOT counter(30);
\ALT_INV_counter[2]~DUPLICATE_q\ <= NOT \counter[2]~DUPLICATE_q\;
\ALT_INV_counter[4]~DUPLICATE_q\ <= NOT \counter[4]~DUPLICATE_q\;
\ALT_INV_counter[7]~DUPLICATE_q\ <= NOT \counter[7]~DUPLICATE_q\;
\ALT_INV_counter[8]~DUPLICATE_q\ <= NOT \counter[8]~DUPLICATE_q\;
\ALT_INV_counter[9]~DUPLICATE_q\ <= NOT \counter[9]~DUPLICATE_q\;
\ALT_INV_counter[11]~DUPLICATE_q\ <= NOT \counter[11]~DUPLICATE_q\;
\ALT_INV_counter[12]~DUPLICATE_q\ <= NOT \counter[12]~DUPLICATE_q\;
\ALT_INV_counter[16]~DUPLICATE_q\ <= NOT \counter[16]~DUPLICATE_q\;
\ALT_INV_counter[15]~DUPLICATE_q\ <= NOT \counter[15]~DUPLICATE_q\;
\ALT_INV_counter[13]~DUPLICATE_q\ <= NOT \counter[13]~DUPLICATE_q\;
\ALT_INV_counter[0]~DUPLICATE_q\ <= NOT \counter[0]~DUPLICATE_q\;
\ALT_INV_counter[23]~DUPLICATE_q\ <= NOT \counter[23]~DUPLICATE_q\;
\ALT_INV_counter[21]~DUPLICATE_q\ <= NOT \counter[21]~DUPLICATE_q\;
\ALT_INV_counter[20]~DUPLICATE_q\ <= NOT \counter[20]~DUPLICATE_q\;
\ALT_INV_counter[19]~DUPLICATE_q\ <= NOT \counter[19]~DUPLICATE_q\;
\ALT_INV_Equal0~6_combout\ <= NOT \Equal0~6_combout\;
\ALT_INV_Equal0~5_combout\ <= NOT \Equal0~5_combout\;
\ALT_INV_Equal0~4_combout\ <= NOT \Equal0~4_combout\;
\ALT_INV_Equal0~3_combout\ <= NOT \Equal0~3_combout\;
\ALT_INV_Equal0~2_combout\ <= NOT \Equal0~2_combout\;
\ALT_INV_Equal0~1_combout\ <= NOT \Equal0~1_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_clock_1_Hz~q\ <= NOT \clock_1_Hz~q\;

-- Location: IOOBUF_X10_Y61_N42
\LEDG[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \clock_1_Hz~q\,
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
	i => GND,
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
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDG(7));

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

-- Location: LABCELL_X17_Y42_N0
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( \counter[0]~DUPLICATE_q\ ) + ( VCC ) + ( !VCC ))
-- \Add0~58\ = CARRY(( \counter[0]~DUPLICATE_q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_counter[0]~DUPLICATE_q\,
	cin => GND,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X17_Y42_N2
\counter[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[0]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N3
\Add0~125\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~125_sumout\ = SUM(( counter(1) ) + ( GND ) + ( \Add0~58\ ))
-- \Add0~126\ = CARRY(( counter(1) ) + ( GND ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(1),
	cin => \Add0~58\,
	sumout => \Add0~125_sumout\,
	cout => \Add0~126\);

-- Location: FF_X17_Y42_N5
\counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~125_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(1));

-- Location: LABCELL_X17_Y42_N6
\Add0~121\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~121_sumout\ = SUM(( counter(2) ) + ( GND ) + ( \Add0~126\ ))
-- \Add0~122\ = CARRY(( counter(2) ) + ( GND ) + ( \Add0~126\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(2),
	cin => \Add0~126\,
	sumout => \Add0~121_sumout\,
	cout => \Add0~122\);

-- Location: FF_X17_Y42_N7
\counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~121_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(2));

-- Location: LABCELL_X17_Y42_N9
\Add0~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~117_sumout\ = SUM(( counter(3) ) + ( GND ) + ( \Add0~122\ ))
-- \Add0~118\ = CARRY(( counter(3) ) + ( GND ) + ( \Add0~122\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(3),
	cin => \Add0~122\,
	sumout => \Add0~117_sumout\,
	cout => \Add0~118\);

-- Location: FF_X17_Y42_N11
\counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~117_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(3));

-- Location: LABCELL_X17_Y42_N12
\Add0~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~113_sumout\ = SUM(( counter(4) ) + ( GND ) + ( \Add0~118\ ))
-- \Add0~114\ = CARRY(( counter(4) ) + ( GND ) + ( \Add0~118\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(4),
	cin => \Add0~118\,
	sumout => \Add0~113_sumout\,
	cout => \Add0~114\);

-- Location: FF_X17_Y42_N14
\counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~113_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(4));

-- Location: LABCELL_X17_Y42_N15
\Add0~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~109_sumout\ = SUM(( counter(5) ) + ( GND ) + ( \Add0~114\ ))
-- \Add0~110\ = CARRY(( counter(5) ) + ( GND ) + ( \Add0~114\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(5),
	cin => \Add0~114\,
	sumout => \Add0~109_sumout\,
	cout => \Add0~110\);

-- Location: FF_X17_Y42_N17
\counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~109_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(5));

-- Location: LABCELL_X17_Y42_N18
\Add0~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~105_sumout\ = SUM(( counter(6) ) + ( GND ) + ( \Add0~110\ ))
-- \Add0~106\ = CARRY(( counter(6) ) + ( GND ) + ( \Add0~110\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(6),
	cin => \Add0~110\,
	sumout => \Add0~105_sumout\,
	cout => \Add0~106\);

-- Location: FF_X17_Y42_N20
\counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~105_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(6));

-- Location: LABCELL_X17_Y42_N21
\Add0~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~101_sumout\ = SUM(( \counter[7]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~106\ ))
-- \Add0~102\ = CARRY(( \counter[7]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~106\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_counter[7]~DUPLICATE_q\,
	cin => \Add0~106\,
	sumout => \Add0~101_sumout\,
	cout => \Add0~102\);

-- Location: FF_X17_Y42_N23
\counter[7]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~101_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[7]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N24
\Add0~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~97_sumout\ = SUM(( \counter[8]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~102\ ))
-- \Add0~98\ = CARRY(( \counter[8]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~102\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_counter[8]~DUPLICATE_q\,
	cin => \Add0~102\,
	sumout => \Add0~97_sumout\,
	cout => \Add0~98\);

-- Location: FF_X17_Y42_N26
\counter[8]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~97_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[8]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N27
\Add0~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~93_sumout\ = SUM(( \counter[9]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~98\ ))
-- \Add0~94\ = CARRY(( \counter[9]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~98\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_counter[9]~DUPLICATE_q\,
	cin => \Add0~98\,
	sumout => \Add0~93_sumout\,
	cout => \Add0~94\);

-- Location: FF_X17_Y42_N29
\counter[9]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~93_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[9]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N30
\Add0~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~89_sumout\ = SUM(( counter(10) ) + ( GND ) + ( \Add0~94\ ))
-- \Add0~90\ = CARRY(( counter(10) ) + ( GND ) + ( \Add0~94\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(10),
	cin => \Add0~94\,
	sumout => \Add0~89_sumout\,
	cout => \Add0~90\);

-- Location: FF_X17_Y42_N31
\counter[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~89_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(10));

-- Location: LABCELL_X17_Y42_N33
\Add0~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~85_sumout\ = SUM(( \counter[11]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~90\ ))
-- \Add0~86\ = CARRY(( \counter[11]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_counter[11]~DUPLICATE_q\,
	cin => \Add0~90\,
	sumout => \Add0~85_sumout\,
	cout => \Add0~86\);

-- Location: FF_X17_Y42_N35
\counter[11]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~85_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[11]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N36
\Add0~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~81_sumout\ = SUM(( \counter[12]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~86\ ))
-- \Add0~82\ = CARRY(( \counter[12]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_counter[12]~DUPLICATE_q\,
	cin => \Add0~86\,
	sumout => \Add0~81_sumout\,
	cout => \Add0~82\);

-- Location: FF_X17_Y42_N38
\counter[12]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~81_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[12]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N39
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( \counter[13]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~82\ ))
-- \Add0~62\ = CARRY(( \counter[13]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_counter[13]~DUPLICATE_q\,
	cin => \Add0~82\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\);

-- Location: FF_X17_Y42_N41
\counter[13]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[13]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N42
\Add0~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~65_sumout\ = SUM(( counter(14) ) + ( GND ) + ( \Add0~62\ ))
-- \Add0~66\ = CARRY(( counter(14) ) + ( GND ) + ( \Add0~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(14),
	cin => \Add0~62\,
	sumout => \Add0~65_sumout\,
	cout => \Add0~66\);

-- Location: FF_X17_Y42_N43
\counter[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~65_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(14));

-- Location: LABCELL_X17_Y42_N45
\Add0~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~69_sumout\ = SUM(( \counter[15]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~66\ ))
-- \Add0~70\ = CARRY(( \counter[15]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_counter[15]~DUPLICATE_q\,
	cin => \Add0~66\,
	sumout => \Add0~69_sumout\,
	cout => \Add0~70\);

-- Location: FF_X17_Y42_N47
\counter[15]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~69_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[15]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N48
\Add0~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~73_sumout\ = SUM(( \counter[16]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~70\ ))
-- \Add0~74\ = CARRY(( \counter[16]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_counter[16]~DUPLICATE_q\,
	cin => \Add0~70\,
	sumout => \Add0~73_sumout\,
	cout => \Add0~74\);

-- Location: FF_X17_Y42_N50
\counter[16]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~73_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[16]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y42_N51
\Add0~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~77_sumout\ = SUM(( counter(17) ) + ( GND ) + ( \Add0~74\ ))
-- \Add0~78\ = CARRY(( counter(17) ) + ( GND ) + ( \Add0~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(17),
	cin => \Add0~74\,
	sumout => \Add0~77_sumout\,
	cout => \Add0~78\);

-- Location: FF_X17_Y42_N52
\counter[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~77_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(17));

-- Location: LABCELL_X17_Y42_N54
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( counter(18) ) + ( GND ) + ( \Add0~78\ ))
-- \Add0~34\ = CARRY(( counter(18) ) + ( GND ) + ( \Add0~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(18),
	cin => \Add0~78\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X17_Y42_N56
\counter[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(18));

-- Location: LABCELL_X17_Y42_N57
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( counter(19) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( counter(19) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(19),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X17_Y42_N59
\counter[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(19));

-- Location: LABCELL_X17_Y41_N0
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( \counter[20]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~42\ = CARRY(( \counter[20]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_counter[20]~DUPLICATE_q\,
	cin => \Add0~38\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: FF_X17_Y41_N2
\counter[20]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[20]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y41_N3
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( \counter[21]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~46\ = CARRY(( \counter[21]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_counter[21]~DUPLICATE_q\,
	cin => \Add0~42\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: FF_X17_Y41_N5
\counter[21]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[21]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y41_N6
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( counter(22) ) + ( GND ) + ( \Add0~46\ ))
-- \Add0~50\ = CARRY(( counter(22) ) + ( GND ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(22),
	cin => \Add0~46\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

-- Location: FF_X17_Y41_N7
\counter[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~49_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(22));

-- Location: LABCELL_X17_Y41_N9
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( \counter[23]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( \counter[23]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_counter[23]~DUPLICATE_q\,
	cin => \Add0~50\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X17_Y41_N11
\counter[23]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[23]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y41_N12
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( counter(24) ) + ( GND ) + ( \Add0~54\ ))
-- \Add0~10\ = CARRY(( counter(24) ) + ( GND ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(24),
	cin => \Add0~54\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X17_Y41_N14
\counter[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(24));

-- Location: LABCELL_X17_Y41_N15
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( counter(25) ) + ( GND ) + ( \Add0~10\ ))
-- \Add0~14\ = CARRY(( counter(25) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(25),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X17_Y41_N17
\counter[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(25));

-- Location: LABCELL_X17_Y41_N18
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( counter(26) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~18\ = CARRY(( counter(26) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_counter(26),
	cin => \Add0~14\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X17_Y41_N20
\counter[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(26));

-- Location: LABCELL_X17_Y41_N21
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( counter(27) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( counter(27) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(27),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X17_Y41_N23
\counter[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(27));

-- Location: LABCELL_X17_Y41_N24
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( counter(28) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( counter(28) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(28),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X17_Y41_N25
\counter[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(28));

-- Location: LABCELL_X17_Y41_N27
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( counter(29) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( counter(29) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_counter(29),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X17_Y41_N29
\counter[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(29));

-- Location: LABCELL_X17_Y41_N30
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( counter(30) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~2\ = CARRY(( counter(30) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(30),
	cin => \Add0~30\,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: FF_X17_Y41_N32
\counter[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(30));

-- Location: LABCELL_X17_Y41_N33
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( counter(31) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(31),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\);

-- Location: FF_X17_Y41_N35
\counter[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(31));

-- Location: LABCELL_X17_Y41_N36
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( !counter(31) & ( !counter(30) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110011001100110011001100110000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_counter(30),
	dataf => ALT_INV_counter(31),
	combout => \Equal0~0_combout\);

-- Location: FF_X17_Y41_N4
\counter[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(21));

-- Location: FF_X17_Y41_N10
\counter[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(23));

-- Location: FF_X17_Y41_N1
\counter[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(20));

-- Location: FF_X17_Y42_N58
\counter[19]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[19]~DUPLICATE_q\);

-- Location: LABCELL_X18_Y41_N12
\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ( \counter[19]~DUPLICATE_q\ & ( counter(18) & ( (counter(22) & (counter(21) & (!counter(23) & counter(20)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(22),
	datab => ALT_INV_counter(21),
	datac => ALT_INV_counter(23),
	datad => ALT_INV_counter(20),
	datae => \ALT_INV_counter[19]~DUPLICATE_q\,
	dataf => ALT_INV_counter(18),
	combout => \Equal0~2_combout\);

-- Location: FF_X17_Y42_N1
\counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(0));

-- Location: FF_X17_Y42_N46
\counter[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~69_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(15));

-- Location: FF_X17_Y42_N49
\counter[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~73_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(16));

-- Location: FF_X17_Y42_N40
\counter[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(13));

-- Location: LABCELL_X18_Y42_N24
\Equal0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = ( counter(14) & ( counter(13) & ( (!counter(17) & (counter(0) & (!counter(15) & counter(16)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(17),
	datab => ALT_INV_counter(0),
	datac => ALT_INV_counter(15),
	datad => ALT_INV_counter(16),
	datae => ALT_INV_counter(14),
	dataf => ALT_INV_counter(13),
	combout => \Equal0~3_combout\);

-- Location: LABCELL_X17_Y41_N54
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( !counter(29) & ( !counter(28) & ( (!counter(26) & (counter(24) & (!counter(27) & !counter(25)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(26),
	datab => ALT_INV_counter(24),
	datac => ALT_INV_counter(27),
	datad => ALT_INV_counter(25),
	datae => ALT_INV_counter(29),
	dataf => ALT_INV_counter(28),
	combout => \Equal0~1_combout\);

-- Location: FF_X17_Y42_N25
\counter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~97_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(8));

-- Location: FF_X17_Y42_N22
\counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~101_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(7));

-- Location: FF_X17_Y42_N34
\counter[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~85_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(11));

-- Location: FF_X17_Y42_N28
\counter[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~93_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(9));

-- Location: FF_X17_Y42_N37
\counter[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~81_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => counter(12));

-- Location: LABCELL_X18_Y42_N6
\Equal0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = ( !counter(9) & ( counter(12) & ( (!counter(10) & (!counter(8) & (!counter(7) & counter(11)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000100000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_counter(10),
	datab => ALT_INV_counter(8),
	datac => ALT_INV_counter(7),
	datad => ALT_INV_counter(11),
	datae => ALT_INV_counter(9),
	dataf => ALT_INV_counter(12),
	combout => \Equal0~4_combout\);

-- Location: FF_X17_Y42_N13
\counter[4]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~113_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[4]~DUPLICATE_q\);

-- Location: FF_X17_Y42_N8
\counter[2]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \Add0~121_sumout\,
	sclr => \Equal0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter[2]~DUPLICATE_q\);

-- Location: LABCELL_X17_Y41_N48
\Equal0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~5_combout\ = ( counter(5) & ( !counter(6) & ( (\counter[4]~DUPLICATE_q\ & (counter(1) & (counter(3) & \counter[2]~DUPLICATE_q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_counter[4]~DUPLICATE_q\,
	datab => ALT_INV_counter(1),
	datac => ALT_INV_counter(3),
	datad => \ALT_INV_counter[2]~DUPLICATE_q\,
	datae => ALT_INV_counter(5),
	dataf => ALT_INV_counter(6),
	combout => \Equal0~5_combout\);

-- Location: LABCELL_X17_Y41_N45
\Equal0~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~6_combout\ = ( \Equal0~4_combout\ & ( \Equal0~5_combout\ & ( (\Equal0~0_combout\ & (\Equal0~2_combout\ & (\Equal0~3_combout\ & \Equal0~1_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datab => \ALT_INV_Equal0~2_combout\,
	datac => \ALT_INV_Equal0~3_combout\,
	datad => \ALT_INV_Equal0~1_combout\,
	datae => \ALT_INV_Equal0~4_combout\,
	dataf => \ALT_INV_Equal0~5_combout\,
	combout => \Equal0~6_combout\);

-- Location: LABCELL_X17_Y41_N39
\clock_1_Hz~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \clock_1_Hz~0_combout\ = ( \Equal0~6_combout\ & ( !\clock_1_Hz~q\ ) ) # ( !\Equal0~6_combout\ & ( \clock_1_Hz~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_clock_1_Hz~q\,
	dataf => \ALT_INV_Equal0~6_combout\,
	combout => \clock_1_Hz~0_combout\);

-- Location: FF_X17_Y41_N40
clock_1_Hz : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50_B5B~inputCLKENA0_outclk\,
	d => \clock_1_Hz~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_1_Hz~q\);

-- Location: MLABCELL_X19_Y2_N0
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


