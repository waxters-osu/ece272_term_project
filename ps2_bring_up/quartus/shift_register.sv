module shift_register
    #(parameter     N=8)
    (input logic clk, reset, serial_in,
    output logic [N-1:0] out);

    always_ff@(posedge clk, posedge reset) begin
        if (reset)
            out <= 0;
        else 
            out <= {out[N-2:0], serial_in};     
    end

endmodule
