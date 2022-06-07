

module comparator_offR #(parameter N = 10, M = 10)
								(input  logic [N-1:0] a, offcount,
								output logic offset);
						  
  assign offset  = ((a >= offcount) && (a < (M+offcount)));
endmodule
