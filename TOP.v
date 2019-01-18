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
    output wire VGA_BLUE,
    output wire KBD_TEST_LED
);
    reg pix_stb;
    always @(posedge CLOCK)
        pix_stb <= ~pix_stb;

    wire [9:0] x;  // 10-bit pixel x position (1024>640)
    wire [8:0] y;  // 9-bit pixel y position (512>480)
    VGA display (
        .in_clock(CLOCK),
        .in_strobe(pix_stb),
        .in_reset(RESET),

        .out_hsync(VGA_HSYNC),
        .out_vsync(VGA_VSYNC),
        .out_x(x),
        .out_y(y)
    );

    wire [7:0] kbd_code;
    PS2 keyboard (
        .ps2_clock(PS2_CLOCK),
        .ps2_data(PS2_DATA),
        .reset(RESET),

        .keyboard_code(kbd_code)
    );
    assign KBD_TEST_LED = (kbd_code == 0);

    // �etri kvadr�ti
    wire sq_a, sq_b, sq_c, sq_d;

    assign sq_a = ((x > 120) & (y >  40) & (x < 280) & (y < 200)) ? 1 : 0;
    assign sq_b = ((x > 200) & (y > 120) & (x < 360) & (y < 280)) ? 1 : 0;
    assign sq_c = ((x > 280) & (y > 200) & (x < 440) & (y < 360)) ? 1 : 0;
    assign sq_d = ((x > 360) & (y > 280) & (x < 520) & (y < 440)) ? 1 : 0;

    assign VGA_RED = sq_b;
    assign VGA_GREEN = sq_a | sq_d;
    assign VGA_BLUE = sq_c;
endmodule
