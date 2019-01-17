`timescale 1ns / 1ps
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

module TOP(
    input CLK_50MHZ,
    input BTN_EAST,
    output VGA_RED,
    output VGA_GREEN,
    output VGA_BLUE,
    output VGA_HSYNC,
    output VGA_VSYNC
    );

	/*----------------------------
		Reset button
		
	  ----------------------------
	*/
	wire rst = ~BTN_EAST;
	
	
	/*----------------------------
		Clock divider 50MHz -> 20MHz
		
	  ----------------------------
	*/
	
	reg [15:0] cnt;
	reg px_strobe;
	
	always @ (posedge CLK_50MHZ)
		{px_strobe, cnt} <= cnt + 16'h8000;
	
	
	/*----------------------------
		Pixel position
		
	  ----------------------------
	*/
	wire [9:0] x;
	wire [8:0] y;
	
	
	VGA display 
	(
		.in_clock(CLK_50MHZ),
		.in_strobe(px_strobe),
		.in_reset(rst),
		.out_hsync(VGA_HSYNC),
		.out_vsync(VGA_VSYNC),
		.out_x(x),
		.out_y(y)
	);
	
    wire sq_a, sq_b, sq_c, sq_d;
    assign sq_a = ((x > 120) & (y >  40) & (x < 280) & (y < 200)) ? 1 : 0;
    assign sq_b = ((x > 200) & (y > 120) & (x < 360) & (y < 280)) ? 1 : 0;
    assign sq_c = ((x > 280) & (y > 200) & (x < 440) & (y < 360)) ? 1 : 0;
    assign sq_d = ((x > 360) & (y > 280) & (x < 520) & (y < 440)) ? 1 : 0;

    assign VGA_R[3] = sq_b;         // square b is red
    assign VGA_G[3] = sq_a | sq_d;  // squares a and d are green
    assign VGA_B[3] = sq_c;         // square c is blue

endmodule
