`default_nettype none

module TOP(
    input wire CLOCK, // Board clock
    input wire RESET, // Frame reset

    input wire PS2_CLOCK,
    input wire PS2_DATA,

    output wire VGA_HSYNC,
    output wire VGA_VSYNC,
    output wire VGA_RED,
    output wire VGA_GREEN,
    output wire VGA_BLUE
);
    localparam PIX_WIDTH = 640;         // Screen width in pixels
    localparam PIX_WIDTH_HALF = 320;
    localparam PIX_HEIGHT = 480;        // Screen height in pixels
    localparam PIX_HEIGHT_HALF = 240;
    localparam PIX_STEP = 10;           // Length of a movement in pixels
    localparam BOX_WIDTH_HALF = 90;     // Half of moving box width
    localparam BOX_HEIGHT_HALF = 90;    // Half of moving box height

    wire [9:0] x;  // 10-bit pixel x position (1024>640)
    wire [8:0] y;  // 9-bit pixel y position (512>480)

    // Coordinates of the midpoint of each moving block edge
    reg [9:0] moving_x_right;
    reg [9:0] moving_x_left;
    reg [8:0] moving_y_bottom;
    reg [8:0] moving_y_top;

    wire [7:0] kbd_code;
    reg pix_stb;

    /* Divides clock in half (50MHz -> 25 MHz) */
    always @ (posedge CLOCK)
        pix_stb <= ~pix_stb;

    VGA display (
        .in_clock(CLOCK),
        .in_strobe(pix_stb),
        .in_reset(RESET),

        .out_hsync(VGA_HSYNC),
        .out_vsync(VGA_VSYNC),
        .out_x(x),
        .out_y(y)
    );

    PS2 keyboard (
        .ps2_clock(PS2_CLOCK),
        .ps2_data(PS2_DATA),
        .reset(RESET),

        .keyboard_code(kbd_code)
    );

    always @ (posedge CLOCK)
    begin
        if (RESET)
        begin
            // Reset the moving box to the middle of the screen
            moving_x_left <= PIX_WIDTH_HALF - BOX_WIDTH_HALF;
            moving_x_right <= PIX_WIDTH_HALF + BOX_WIDTH_HALF;
            moving_y_bottom <= PIX_HEIGHT_HALF - BOX_HEIGHT_HALF;
            moving_y_top <= PIX_HEIGHT_HALF + BOX_HEIGHT_HALF;
        end

        // Move the box around with WASD keys and wrap to the opposite side if
        // the screen edge has been reached
        case (kbd_code)
            8'h1D: // 'W'
                begin
                    if (moving_y_bottom < PIX_HEIGHT - PIX_STEP)
                        moving_y_bottom <= moving_y_bottom + PIX_STEP;
                    else
                        moving_y_bottom <= PIX_STEP - (PIX_HEIGHT - moving_y_bottom);

                    if (moving_y_top < PIX_HEIGHT - PIX_STEP)
                        moving_y_top <= moving_y_top + PIX_STEP;
                    else
                        moving_y_top <= PIX_STEP - (PIX_HEIGHT - moving_y_top);
                end
            8'h1C: // 'A'
                begin
                    if (moving_x_left > PIX_STEP)
                        moving_x_left <= moving_x_left - PIX_STEP;
                    else
                        moving_x_left <= PIX_WIDTH - (PIX_STEP - moving_x_left);

                    if (moving_x_right > PIX_STEP)
                        moving_x_right <= moving_x_right - PIX_STEP;
                    else
                        moving_x_right <= PIX_WIDTH - (PIX_STEP - moving_x_right);

                end
            8'h1B: // 'S'
                begin
                    if (moving_y_top > PIX_STEP)
                        moving_y_top <= moving_y_top - PIX_STEP;
                    else
                        moving_y_top <= PIX_HEIGHT - (PIX_STEP - moving_y_top);

                    if (moving_y_bottom > PIX_STEP)
                        moving_y_bottom <= moving_y_bottom - PIX_STEP;
                    else
                        moving_y_bottom <= PIX_HEIGHT - (PIX_STEP - moving_y_bottom);
                end
            8'h23: // 'D'
                begin
                    if (moving_x_right < PIX_WIDTH - PIX_STEP)
                        moving_x_right <= moving_x_right + PIX_STEP;
                    else
                        moving_x_right <= PIX_STEP - (PIX_WIDTH - moving_x_right);

                    if (moving_x_left + PIX_STEP < PIX_WIDTH)
                        moving_x_left <= moving_x_left + PIX_STEP;
                    else
                        moving_x_left <= PIX_STEP - (PIX_WIDTH - moving_x_left);
                end
        endcase
    end

    wire red_block, green_block, blue_block;

    assign red_block = ((x > moving_x_left) & (y >  moving_y_bottom) & (x < moving_x_right) & (y < moving_y_top)) ? 1 : 0;
    assign green_block = red_block;
    assign blue_block = red_block;

    assign VGA_RED = red_block;
    assign VGA_GREEN = green_block;
    assign VGA_BLUE = blue_block;
endmodule
