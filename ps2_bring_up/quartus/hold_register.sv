// holds the contents of a complete shift on "out" until a new
// complete shift is ready.
module hold_register
    #(parameter N=11,
                NUM_SHIFTS=11)
    (input logic shift_clk, sync_clk, reset,
    input logic [N-1:0] in,
	 output logic completed_shift,  //rising edge on completed shift falling edge 1 sync_clk cycle later.
    output logic [N-1:0] out);

	 logic is_completed_shift;
    //track when shifts are completed by dividing the double_shift_clk
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

    // Ensure completed_shift is high for at least 1 sync_clk cycles
    logic delayed_is_completed_shift;
    bounded_counter #(.N($clog2(NUM_SHIFTS + 2)),
                    .BOUND(NUM_SHIFTS + 2),
                    .IS_RESET_ON_BOUND_REACHED(1)) delayed_completed_shift_counter
        (.counted_signal(sync_clk),
        .reset(reset),
        .bound_reached(delayed_is_completed_shift));
    always_ff @(posedge is_completed_shift, 
                posedge delayed_is_completed_shift,
                posedge reset) begin
        if (reset) begin
            completed_shift <= 0;
        end
        else begin
            if (is_completed_shift) begin
                completed_shift <= 1;
            end
            else begin
                completed_shift <= 0;
            end
        end
    end

    assign out = hold_reg;

endmodule
