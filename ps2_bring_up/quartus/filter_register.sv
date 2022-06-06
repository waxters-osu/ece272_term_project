module filter_register
    #(parameter MIN_SAME_SAMPLES = 20)
    (input logic sample_clk, reset, input_to_filter,
    output logic filtered_out);

    logic [MIN_SAME_SAMPLES-1:0] previous_samples;
    shift_register #(.N(MIN_SAME_SAMPLES)) filtering_shift_register
        (.clk(sample_clk),
        .reset(reset),
        .serial_in(input_to_filter),
        .out(previous_samples));

    //check if all ones
    logic is_all_ones_n;
    NAND_Nbit #(.N(MIN_SAME_SAMPLES)) is_all_ones_nand
        (.in(previous_samples),
        .out(is_all_ones_n));

    //check if all zeros
    logic is_all_zeros_n;
    OR_Nbit #(.N(MIN_SAME_SAMPLES)) is_all_zeros_or
        (.in(previous_samples),
        .out(is_all_zeros_n));

    //output based on all ones, all zeros, or mismatched (ie output prev)
    reg last_output_level;
    always_ff @(posedge sample_clk) begin
        //if mismatched bits, output last output
        if ( is_all_zeros_n && is_all_ones_n ) begin
            filtered_out <= last_output_level;
        end

        if (~(is_all_zeros_n)) begin
            filtered_out <= 0;
            last_output_level <= 0;
        end

        if (~(is_all_ones_n)) begin
            filtered_out <= 1;
            last_output_level <= 1;
        end
    end

endmodule
