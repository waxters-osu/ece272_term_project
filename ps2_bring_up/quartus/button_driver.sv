//turns key encoding into actual button press and release events
module temp
    #(parameter N=8)
    (input logic [N-2:0] key_encoding,
    output logic [N-2:0] is_key_pressed)

    reg [N-2:0] currently_pressed_keys;

    genvar i;
    generate
        for (i = 0; i < (N-1); i++) begin
            always_ff @(posedge key_encoding[i]) begin
                    currently_pressed_keys[i] <= 1;
            end
        end
    endgenerate
