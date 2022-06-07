module two_four_decoder (input  logic [1:0] data,
							    output logic [3:0] encoding);

  always_comb
    case(data)
      2'b00: encoding = 4'b0000; 
      2'b01: encoding = 4'b0101; 
      2'b10: encoding = 4'b1010; 
      2'b11: encoding = 4'b1111;  
      default: encoding = 4'b0000; 
    endcase
endmodule
