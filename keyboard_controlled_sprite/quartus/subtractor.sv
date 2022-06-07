////////////////////////////////////////////////////////////////////////////
// Company:         Oregon State University
// Engineer:        Matthew Walker, Silas Waxter
//
// Create date:     06/01/2022
// Design name:     PS2ControlledSprite
// Module name:     subtractor
// Target devices:  DE10Lite
// Tool versions:   Quartus Prime Lite Edition 18.0
// Description:     Outputs difference between input value a and parameter sub_by.
// 
////////////////////////////////////////////////////////////////////////////

module subtractor #(parameter N = 10, sub_by = 10)
                   (input  logic [N-1:0] a,
                    output logic [N-1:0] diff);
    
  assign diff = (a - sub_by);
endmodule
