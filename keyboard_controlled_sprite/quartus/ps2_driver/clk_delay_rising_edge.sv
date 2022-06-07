// this module is used to delay a slower clk by some ammount of clock cycles
// of a faster clk.
module clk_delay_rising_edge
    #(parameter NUM_BITS_BOUNDED_COUNTER=32,
                NUM_FAST_CLK_TO_DELAY=10)
    (input logic fast_clk, slow_clk, reset,
    output logic delayed_slow_clk);


    //continous counter that gets reset on slow_clk falling edge
    logic set_delayed_slow_clk;
    bounded_counter #(.N(NUM_BITS_BOUNDED_COUNTER),
                    .BOUND(NUM_FAST_CLK_TO_DELAY),
                    .IS_RESET_ON_BOUND_REACHED(0)) fast_clk_counter
        (.counted_signal(fast_clk),
        .reset((reset | ~(slow_clk))),
        .bound_reached(set_delayed_slow_clk));

    //delayed_slow_clk rises on set_delayed_slow_clk 
    //and falls on negedge of slow_clk
    always_ff @(posedge set_delayed_slow_clk, negedge slow_clk) begin
        if (set_delayed_slow_clk) begin
            delayed_slow_clk <= 1;
        end
        else begin
            delayed_slow_clk <= 0;
        end
    end

endmodule
