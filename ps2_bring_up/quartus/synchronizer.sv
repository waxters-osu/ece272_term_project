module synchronizer(input   logic clk, d, reset,
                    output  logic q);
    logic n1;
    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else begin
            n1 <= d;
            q <= n1;
        end
    end
endmodule
