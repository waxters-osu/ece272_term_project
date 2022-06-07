//this polling driver turns key encoding into actual button high/low line.
module button_driver
    (input logic reset, polling_clk, new_ps2_msg,
    input logic [7:0] key_encoding,
    output logic [6:0] is_key_pressed);

    logic [6:0] currently_pressed_keys;
    logic [7:0] prev_key_encoding;

    //allow the polling to be enabled and disabled
    logic controlled_polling_clk;
    logic is_controlled_polling_clk_enabled;
    logic send_disable_controlled_polling_clk;
    always_comb begin
        if (is_controlled_polling_clk_enabled) begin
            controlled_polling_clk = polling_clk;
        end
        else begin
            controlled_polling_clk = 0;
        end
    end

    //when a new msg is passed enable polling clk
    always_ff @(posedge new_ps2_msg,
                posedge send_disable_controlled_polling_clk,
                posedge reset) begin
        if (reset) begin
            is_controlled_polling_clk_enabled = 1;
        end
        else begin
            if (new_ps2_msg) begin
                is_controlled_polling_clk_enabled = 1;
            end
            else begin
                is_controlled_polling_clk_enabled = 0;
            end
        end
    end

    // track currently_pressed_keys by examining current key_encoding and
    // remembering whether a release code has been transmitted.
    always_ff @(posedge controlled_polling_clk,
                posedge reset) begin
        if (reset) begin
              currently_pressed_keys <= 0;
              prev_key_encoding <= 0;
              send_disable_controlled_polling_clk <= 0;
        end
        else begin
            //if prev key code was a release code 
            //and current code is not a release code
            if (((prev_key_encoding >> 7) == 1) && ((key_encoding >> 7) == 0)) begin
                //clear whatever key is currently encoded
                currently_pressed_keys <= (currently_pressed_keys & ~(key_encoding));
                //disable polling until new ps2_msg is transmitted
                send_disable_controlled_polling_clk <= 1;
                //update prev key code
                prev_key_encoding <= key_encoding;
            end
            //if prev key code was NOT a release code,
            else begin
                //set whatever key is currently encoded
                currently_pressed_keys <= (currently_pressed_keys | key_encoding);
                //enable polling
                send_disable_controlled_polling_clk <= 0;
                //update prev key code
                prev_key_encoding <= key_encoding;
            end
        end
    end

    assign is_key_pressed[6:0] = currently_pressed_keys[6:0];

endmodule
