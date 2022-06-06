// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Mon Jun  6 02:09:58 2022"

module ps2_bring_up(
	ps2_clk,
	ps2_data,
	hardware_reset,
	hardware_clk_50MHz,
	leds
);


input wire	ps2_clk;
input wire	ps2_data;
input wire	hardware_reset;
input wire	hardware_clk_50MHz;
output wire	[7:0] leds;

wire	clk_1MHz;
wire	data_sample_clk;
wire	delayed_data_sample_clk;
wire	[7:0] key_encoding;
wire	ps2_data_filtered;
wire	[10:0] ps2_msg;
wire	[10:0] ps2_shift_reg;
wire	sys_reset;
wire	SYNTHESIZED_WIRE_0;

wire	[7:0] GDFX_TEMP_SIGNAL_0;


assign	GDFX_TEMP_SIGNAL_0 = {ps2_msg[2],ps2_msg[3],ps2_msg[4],ps2_msg[5],ps2_msg[6],ps2_msg[7],ps2_msg[8],ps2_msg[9]};


shift_register	b2v_inst(
	.clk(data_sample_clk),
	.reset(sys_reset),
	.serial_in(ps2_data_filtered),
	.out(ps2_shift_reg));
	defparam	b2v_inst.N = 11;

assign	sys_reset =  ~hardware_reset;


hold_register	b2v_inst12(
	.shift_clk(delayed_data_sample_clk),
	.reset(sys_reset),
	.in(ps2_shift_reg),
	.out(ps2_msg));
	defparam	b2v_inst12.N = 11;
	defparam	b2v_inst12.NUM_SHIFTS = 11;


clk_delay_rising_edge	b2v_inst13(
	.fast_clk(hardware_clk_50MHz),
	.slow_clk(data_sample_clk),
	.reset(sys_reset),
	.delayed_slow_clk(delayed_data_sample_clk));
	defparam	b2v_inst13.NUM_BITS_BOUNDED_COUNTER = 32;
	defparam	b2v_inst13.NUM_FAST_CLK_TO_DELAY = 25;


filter_register	b2v_inst2(
	.sample_clk(hardware_clk_50MHz),
	.reset(sys_reset),
	.input_to_filter(ps2_data),
	.filtered_out(ps2_data_filtered));
	defparam	b2v_inst2.MIN_SAME_SAMPLES = 20;


bounded_counter	b2v_inst4(
	.counted_signal(hardware_clk_50MHz),
	.reset(sys_reset),
	.bound_reached(clk_1MHz));
	defparam	b2v_inst4.BOUND = 50;
	defparam	b2v_inst4.IS_RESET_ON_BOUND_REACHED = 1;
	defparam	b2v_inst4.N = 8;


bounded_counter	b2v_inst5(
	.counted_signal(clk_1MHz),
	.reset(SYNTHESIZED_WIRE_0),
	.bound_reached(data_sample_clk));
	defparam	b2v_inst5.BOUND = 20;
	defparam	b2v_inst5.IS_RESET_ON_BOUND_REACHED = 1'b0;
	defparam	b2v_inst5.N = 32;


decoder	b2v_inst6(
	.in(GDFX_TEMP_SIGNAL_0),
	.one_hot_out(key_encoding));
	defparam	b2v_inst6.CODE0 = 8'b00011100;
	defparam	b2v_inst6.CODE1 = 8'b00011011;
	defparam	b2v_inst6.CODE2 = 8'b00011101;
	defparam	b2v_inst6.CODE3 = 8'b00100011;
	defparam	b2v_inst6.CODE4 = 8'b11111111;
	defparam	b2v_inst6.CODE5 = 8'b11111111;
	defparam	b2v_inst6.CODE6 = 8'b11111111;
	defparam	b2v_inst6.CODE7 = 8'b11110000;
	defparam	b2v_inst6.N = 8;

assign	SYNTHESIZED_WIRE_0 = sys_reset | ps2_clk;

assign	leds = key_encoding;

endmodule
