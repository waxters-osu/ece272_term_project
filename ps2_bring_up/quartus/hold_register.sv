// holds the contents of a complete shift on "out" until a new
// complete shift is ready.
module hold_register
    #(parameter N=11,
                NUM_SHIFTS=11)
    (input logic shift_clk, reset,
    input logic [N-1:0] in,
    output logic [N-1:0] out);

    //track when shifts are completed by dividing the double_shift_clk
    logic is_completed_shift;
    bounded_counter #(.N($clog2(NUM_SHIFTS)),
                    .BOUND(NUM_SHIFTS),
                    .IS_RESET_ON_BOUND_REACHED(1)) is_completed_shift_counter
        (.counted_signal(shift_clk),
        .reset(reset),
        .bound_reached(is_completed_shift));

    reg [N-1:0] hold_reg;
    always_ff@(posedge is_completed_shift, posedge reset) begin
        if (reset)
            hold_reg <= '1;
        else begin
            hold_reg <= in;
        end
    end

    assign out = hold_reg;

endmodule
