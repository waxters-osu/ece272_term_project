//One-Hot Decoder out = [ABCDEFGH]
module decoder
        #(parameter N=8,
                    CODE7=0,
                    CODE6=1,
                    CODE5=2,
                    CODE4=3,
                    CODE3=4,
                    CODE2=5,
                    CODE1=6,
                    CODE0=7)
		(input logic [N-1:0] in,
        output logic [7:0] one_hot_out);
    
    always_comb
    begin
        case(in)
            CODE7   : one_hot_out = 8'b10000000;
            CODE6   : one_hot_out = 8'b01000000;
            CODE5   : one_hot_out = 8'b00100000;
            CODE4   : one_hot_out = 8'b00010000;
            CODE3   : one_hot_out = 8'b00001000;
            CODE2   : one_hot_out = 8'b00000100;
            CODE1   : one_hot_out = 8'b00000010;
            CODE0   : one_hot_out = 8'b00000001;
			default : one_hot_out = 8'b00000000;
		endcase
    end
endmodule
