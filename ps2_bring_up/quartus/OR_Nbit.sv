module OR_Nbit
        #(parameter N=8)
		(input logic [N-1:0] in,
       output logic out);

    assign out = |in;
endmodule
