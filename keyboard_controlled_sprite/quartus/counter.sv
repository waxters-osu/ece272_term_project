////////////////////////////////////////////////////////////////////////////
// Company:         Oregon State University
// Engineer:        Matthew Walker, Silas Waxter
//
// Create date:     04/25/2022
// Design name:     PS2ControlledSprite
// Module name:     counter
// Target devices:  DE10Lite
// Tool versions:   Quartus Prime Lite Edition 18.0
// Description:     Counts up when clock edge is high and holds previous value while clock edge is low.
// 
////////////////////////////////////////////////////////////////////////////

module counter #(parameter N = 10)
                (input  logic clk,
                 input  logic reset,
                 output logic [N-1:0] q);
    
  always_ff @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= q + 1;
endmodule
