`default_nettype none

module PS2(
    input wire ps2_clock,
    input wire ps2_data,
    input wire reset,

    output reg [7:0] keyboard_code
);
    reg [3:0] received_bytes;
    reg [7:0] code;
    reg skip;

    always @ (negedge ps2_clock)
    begin
        if (reset)
        begin
            code <= 0;
            received_bytes <= 0;
            skip <= 0;
            keyboard_code <= 0;
        end

        case (received_bytes)
            4'd0: // '0' start bit
                begin
                    if (ps2_data)
                    begin
                        code <= 0;
                        skip <= 1;
                    end
                end
            /* 4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8: // Data bits */
            /*     begin */
            /*         if (!skip) */
            /*             code[received_bytes - 1] <= ps2_data; */
            /*     end */
            4'd9: // Parity bit
                begin
                    if ((code[0] + code[1] + code[2] + code[3] + code[4] + code[5] + code[6] + code[7]) != ps2_data)
                        code <= 0;
                end
            4'd10: // '1' stop bit
                begin
                    if (!ps2_data)
                        code <= 0;
                    keyboard_code <= code;

                    // Prepare for the next packet
                    received_bytes <= 0;
                    skip <= 1;
                end
        endcase

        if (skip)
            skip <= 0;
        else
            received_bytes <= received_bytes + 1;
        keyboard_code <= 0;
    end
endmodule
