////////////////////////////////////////////////////////////////////////////
// Company:         Oregon State University
// Engineer:        Matthew Walker, Silas Waxter
//
// Create date:     06/02/2022
// Design name:     PS2ControlledSprite
// Module name:     AddressConverter
// Target devices:  DE10Lite
// Tool versions:   Quartus Prime Lite Edition 18.0
// Description:     Converts given row and column into address for ROM to display sprite.
// 
////////////////////////////////////////////////////////////////////////////

module AddressConverter #(parameter N = 16, ROWVAL = 256)
                         (input  logic [9:0] row, column, roff, coff,
                          output logic [N-1:0] addresses);

  assign addresses = ((row - roff) * ROWVAL) + (column - coff);
endmodule
