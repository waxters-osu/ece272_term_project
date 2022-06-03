module mux_2
        #(parameter N=4)
		(input logic [N-1:0]sig_1_activehigh, sig_2_activelow,
       input logic select,
       output logic [N-1:0]sig_out);

    assign sig_out = select ? sig_1_activehigh : sig_2_activelow;
endmodule
