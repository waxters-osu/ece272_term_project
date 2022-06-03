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
// CREATED		"Fri Jun  3 12:48:19 2022"

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
output wire	[10:0] leds;

wire	clk_1MHz;
wire	data_sample_clk;
wire	[10:0] ps2_msg;
wire	sys_reset;
wire	SYNTHESIZED_WIRE_0;





shift_register	b2v_inst(
	.clk(data_sample_clk),
	.reset(sys_reset),
	.serial_in(ps2_data),
	.out(ps2_msg));
	defparam	b2v_inst.N = 11;

assign	sys_reset =  ~hardware_reset;


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
	defparam	b2v_inst5.BOUND = 17;
	defparam	b2v_inst5.IS_RESET_ON_BOUND_REACHED = 1'b0;
	defparam	b2v_inst5.N = 32;

assign	SYNTHESIZED_WIRE_0 = sys_reset | ps2_clk;

assign	leds = ps2_msg;

endmodule
