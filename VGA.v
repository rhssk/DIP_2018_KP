`default_nettype none

module VGA(
    input wire in_clock,
    input wire in_strobe,
    input wire in_reset,
    output wire out_hsync,
    output wire out_vsync,
    output wire out_blanking,
    output wire out_active,
    output wire out_screenend,
    output wire out_animate,
    output wire [9:0] out_x,
    output wire [8:0] out_y
);

    localparam HS_STA = 16;              // H-sync starts
    localparam HS_END = 16 + 96;         // H-sync ends
    localparam HA_STA = 16 + 96 + 48;    // H-pixels start

    localparam VS_STA = 480 + 11;        // V-sync starts
    localparam VS_END = 480 + 11 + 2;    // V-sync ends
    localparam VA_END = 480;             // V-pixels end
    localparam LINE   = 800;             // end of line
    localparam SCREEN = 524;             // end of screen

    reg [9:0] pos_line;     // line position
    reg [9:0] pos_screen;  // screen position

    // Generate sync signals
    assign out_hsync = ~((pos_line >= HS_STA) & (pos_line < HS_END));
    assign out_vsync = ~((pos_screen >= VS_STA) & (pos_screen < VS_END));

    // X and Y must NOT go outside the PIXELS domain
    assign out_x = (pos_line < HA_STA) ? 0 : (pos_line - HA_STA);
    assign out_y = (pos_screen >= VA_END) ? (VA_END - 1) : (pos_screen);

    // Blanking interval
    assign out_blanking = ((pos_line < HA_STA) | (pos_screen > VA_END - 1));

    // Draw pixels
    assign out_active = ~((pos_line < HA_STA) | (pos_screen > VA_END - 1));

    // Screenend
    assign out_screenend = ((pos_screen == SCREEN - 1) & (pos_line == LINE));

    // More tearing prevention
    assign out_animate = ((pos_screen == VA_END - 1) & (pos_line == LINE));

    always @ (posedge in_clock)
    begin
        if (in_reset)  // Reset frame
        begin
            pos_line <= 0;
            pos_screen <= 0;
        end
        if (in_strobe)  // Per 40ns tick
        begin
            if (pos_line == LINE)
            begin
                pos_line <= 0;
                pos_screen <= pos_screen + 1;
            end
            else
                pos_line <= pos_line + 1;

            if (pos_screen == SCREEN)
                pos_screen <= 0;
        end
    end
endmodule
