////////////////////////////////////////////////////////////////////////////
// Company:         Oregon State University
// Engineer:        Matthew Walker, Silas Waxter
//
// Create date:     05/20/2022
// Design name:     PS2ControlledSprite
// Module name:     Nbit_mux2
// Target devices:  DE10Lite
// Tool versions:   Quartus Prime Lite Edition 18.0
// Description:     Displays N-bit values depending on input value s.
// 
////////////////////////////////////////////////////////////////////////////

module Nbit_mux2 #(parameter N = 10)
                   (input  logic [N-1:0] d0, d1,
                    input  logic         s,
                    output logic [N-1:0] y);

  assign y = s ? d1 : d0;
endmodule
