module shift_register
    #(parameter N=11)
    (input logic clk, reset, serial_in,
    output logic [N-1:0] out);

    reg [N-1:0] shift_reg;
    always_ff@(posedge clk, posedge reset) begin
        if (reset)
            shift_reg <= '1;
        else begin
            shift_reg <= (shift_reg << 1);
            shift_reg[0] <= serial_in;
        end
    end

    assign out = shift_reg;

endmodule
