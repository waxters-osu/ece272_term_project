////////////////////////////////////////////////////////////////////////////
// Company:         Oregon State University
// Engineer:        Matthew Walker, Silas Waxter
//
// Create date:     04/25/2022
// Design name:     PS2ControlledSprite
// Module name:     comparator
// Target devices:  DE10Lite
// Tool versions:   Quartus Prime Lite Edition 18.0
// Description:     Checks wether value a is greater than and or less than M paramater.
// 
////////////////////////////////////////////////////////////////////////////

module comparator #(parameter N = 10, M = 1)
                   (input  logic [N-1:0] a,
                    output logic gt, lt);
						  
  assign gt  = (a > M);
  assign lt  = (a < M);
endmodule
