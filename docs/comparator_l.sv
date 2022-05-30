module comparator_l #(parameter N = 8, M = 0)
							(input  logic [N-1:0] a,
						    output logic lt);
						  
  assign lt  = (a < M);
endmodule
