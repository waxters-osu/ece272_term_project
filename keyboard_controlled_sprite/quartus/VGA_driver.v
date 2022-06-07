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
// CREATED		"Mon Jun 06 16:28:07 2022"

module VGA_driver(
	reset_n,
	clk,
	Pixel_RGB,
	H_sync,
	V_sync,
	ColumnCount,
	RGB_Outputs,
	RowCount
);


input wire	reset_n;
input wire	clk;
input wire	[11:0] Pixel_RGB;
output wire	H_sync;
output wire	V_sync;
output wire	[9:0] ColumnCount;
output wire	[11:0] RGB_Outputs;
output wire	[9:0] RowCount;

reg	clk_25;
wire	clk_50MHz;
wire	[11:0] clr_out;
wire	[11:0] color;
wire	EN;
wire	[9:0] H_count;
wire	H_disp;
wire	res;
wire	[9:0] V_count;
wire	V_disp;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[0:3] SYNTHESIZED_WIRE_7;
wire	[0:3] SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_10;
wire	[0:9] SYNTHESIZED_WIRE_11;
wire	[9:0] SYNTHESIZED_WIRE_12;
wire	[0:9] SYNTHESIZED_WIRE_13;
wire	[9:0] SYNTHESIZED_WIRE_14;
wire	[0:3] SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_7 = 0;
assign	SYNTHESIZED_WIRE_8 = 0;
assign	SYNTHESIZED_WIRE_11 = 0;
assign	SYNTHESIZED_WIRE_13 = 0;
assign	SYNTHESIZED_WIRE_15 = 0;



assign	SYNTHESIZED_WIRE_16 =  ~clk_25;


subtractor	b2v_inst1(
	.a(H_count),
	.diff(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst1.N = 10;
	defparam	b2v_inst1.sub_by = 144;


counter	b2v_inst10(
	.clk(clk_25),
	.reset(SYNTHESIZED_WIRE_0),
	.q(H_count));
	defparam	b2v_inst10.N = 10;


comparator	b2v_inst11(
	.a(H_count),
	.gt(SYNTHESIZED_WIRE_17)
	);
	defparam	b2v_inst11.M = 799;
	defparam	b2v_inst11.N = 10;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_17 | res;

assign	SYNTHESIZED_WIRE_10 = SYNTHESIZED_WIRE_2 | res;


comparator	b2v_inst14(
	.a(V_count),
	.gt(V_sync)
	);
	defparam	b2v_inst14.M = 1;
	defparam	b2v_inst14.N = 10;


comparator	b2v_inst15(
	.a(V_count),
	.gt(SYNTHESIZED_WIRE_3)
	);
	defparam	b2v_inst15.M = 34;
	defparam	b2v_inst15.N = 10;


comparator	b2v_inst16(
	.a(V_count),
	
	.lt(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst16.M = 515;
	defparam	b2v_inst16.N = 10;


comparator	b2v_inst17(
	.a(V_count),
	.gt(SYNTHESIZED_WIRE_2)
	);
	defparam	b2v_inst17.M = 524;
	defparam	b2v_inst17.N = 10;

assign	V_disp = SYNTHESIZED_WIRE_3 & SYNTHESIZED_WIRE_4;


subtractor	b2v_inst19(
	.a(V_count),
	.diff(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst19.N = 10;
	defparam	b2v_inst19.sub_by = 35;

assign	H_disp = SYNTHESIZED_WIRE_5 & SYNTHESIZED_WIRE_6;



Nbit_mux2	b2v_inst23(
	.s(EN),
	.d0(SYNTHESIZED_WIRE_7),
	.d1(color[7:4]),
	.y(clr_out[7:4]));
	defparam	b2v_inst23.N = 4;



Nbit_mux2	b2v_inst25(
	.s(EN),
	.d0(SYNTHESIZED_WIRE_8),
	.d1(color[3:0]),
	.y(clr_out[3:0]));
	defparam	b2v_inst25.N = 4;



counter	b2v_inst27(
	.clk(SYNTHESIZED_WIRE_17),
	.reset(SYNTHESIZED_WIRE_10),
	.q(V_count));
	defparam	b2v_inst27.N = 10;


Nbit_mux2	b2v_inst28(
	.s(EN),
	.d0(SYNTHESIZED_WIRE_11),
	.d1(SYNTHESIZED_WIRE_12),
	.y(ColumnCount));
	defparam	b2v_inst28.N = 10;



comparator	b2v_inst3(
	.a(H_count),
	
	.lt(SYNTHESIZED_WIRE_6));
	defparam	b2v_inst3.M = 784;
	defparam	b2v_inst3.N = 10;


Nbit_mux2	b2v_inst30(
	.s(EN),
	.d0(SYNTHESIZED_WIRE_13),
	.d1(SYNTHESIZED_WIRE_14),
	.y(RowCount));
	defparam	b2v_inst30.N = 10;


assign	EN = H_disp & V_disp;

assign	res =  ~reset_n;


Nbit_mux2	b2v_inst6(
	.s(EN),
	.d0(SYNTHESIZED_WIRE_15),
	.d1(color[11:8]),
	.y(clr_out[11:8]));
	defparam	b2v_inst6.N = 4;


comparator	b2v_inst7(
	.a(H_count),
	.gt(H_sync)
	);
	defparam	b2v_inst7.M = 95;
	defparam	b2v_inst7.N = 10;


always@(posedge clk_50MHz or negedge reset_n)
begin
if (!reset_n)
	begin
	clk_25 <= 0;
	end
else
	begin
	clk_25 <= SYNTHESIZED_WIRE_16;
	end
end


comparator	b2v_inst9(
	.a(H_count),
	.gt(SYNTHESIZED_WIRE_5)
	);
	defparam	b2v_inst9.M = 143;
	defparam	b2v_inst9.N = 10;

assign	clk_50MHz = clk;
assign	RGB_Outputs = clr_out;
assign	color = Pixel_RGB;

endmodule
