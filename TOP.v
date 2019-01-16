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

	wire rst = ~BTN_EAST;
	
	reg [15:0] cnt;
	reg px_strobe;
	always @ (posedge CLK_50MHZ)
		{px_strobe, cnt} <= cnt + 16'h8000;
	
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

endmodule
