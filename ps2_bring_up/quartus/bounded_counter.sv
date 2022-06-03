module bounded_counter
        #(parameter N=8,
					BOUND=50,
					IS_RESET_ON_BOUND_REACHED=1)
		(input logic counted_signal, reset,
        output logic bound_reached);

    logic [N-1:0] signal_count;
    logic send_reset_signal_count;
    counter #(.N(N)) signal_count_counter
        (.clk(counted_signal),
        .reset((reset | send_reset_signal_count)),
        .q(signal_count));

    comparator #(.N(N)) bound_reached_comparator
        (.a(signal_count),
        .b(BOUND),
        .eq(bound_reached));

    always_comb begin
        if (IS_RESET_ON_BOUND_REACHED == 1)
            send_reset_signal_count = bound_reached;
        else
            send_reset_signal_count = 0;
    end
endmodule
