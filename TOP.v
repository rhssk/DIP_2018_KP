//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:29:22 01/16/2019
// Design Name:
// Module Name:    TOP
// Project Name:   DIP 2018/19
// Target Devices:
// Tool versions:
// Description:    VGA component for DIP 2k18
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
`default_nettype none
module TOP(
    input wire CLK_50MHZ,

    input wire BTN_EAST,

    output wire [3:0] VGA_RED,
    output wire [3:0] VGA_GREEN,
    output wire [3:0] VGA_BLUE,

    output wire VGA_HSYNC,
    output wire VGA_VSYNC
);

    /*----------------------------
        Reset button

    ----------------------------
    */
    wire rst = ~BTN_EAST;

    /*----------------------------
        Clock divider 50MHz -> 25MHz

    ----------------------------
    */
    reg [15:0] cnt;
    reg stb;
    always @(posedge CLK_50MHZ)
        {stb, cnt} <= cnt + 16'h8000;

    /*----------------------------
        Pixel position

    ----------------------------
    */
    wire [9:0] x;
    wire [8:0] y;

    VGA display (
        .in_clock(CLK_50MHZ),
        .in_strobe(stb),
        .in_reset(rst),
        .out_hsync(VGA_HSYNC),
        .out_vsync(VGA_VSYNC),
        .out_x(x),
        .out_y(y)
    );


    // Test��anas nol�kiem, �is uz ekr�na z�m� kvadr�tus. Re�li, datus, protams, dodam no bufera.
    wire sq_a, sq_b, sq_c, sq_d;
    assign sq_a = ((x > 120) & (y >  40) & (x < 280) & (y < 200)) ? 1 : 0;
    assign sq_b = ((x > 200) & (y > 120) & (x < 360) & (y < 280)) ? 1 : 0;
    assign sq_c = ((x > 280) & (y > 200) & (x < 440) & (y < 360)) ? 1 : 0;
    assign sq_d = ((x > 360) & (y > 280) & (x < 520) & (y < 440)) ? 1 : 0;

    assign VGA_RED[3] = sq_b;
    assign VGA_GREEN[3] = sq_a | sq_d;
    assign VGA_BLUE[3] = sq_c;
endmodule
