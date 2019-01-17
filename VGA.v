`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date:    15:44:46 01/16/2019 
// Design Name: 
// Module Name:    VGA 
// Project Name: DIP 2018
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGA(
    input wire in_clock,
    input wire in_strobe,
    input wire in_reset,
    output wire out_hsync,
    output wire out_vsync,
    output wire out_blank,
    output wire out_active,
    output wire out_scrend,
    output wire out_anim,
    output wire [9:0] out_x,
    output wire [8:0] out_y
    );
	 
	localparam HS_STA = 16;             
	localparam HS_END = 16 + 96;        
	localparam HA_STA = 16 + 96 + 48;  
	
	localparam VS_STA = 480 + 11;       
	localparam VS_END = 480 + 11 + 2;   
	localparam VA_END = 480;    
	
	localparam LINE   = 800;            
	localparam SCREEN = 524;            

	reg [9:0] line_pos;  // line position
	reg [9:0] scr_pos;  // screen position
	
	
	// Generate VH sync
	assign out_hsync = ~((line_pos >= HS_STA) & (line_pos < HS_END));
   assign out_vsync = ~((scr_pos >= VS_STA) & (scr_pos < VS_END));
	
	
	// X and Y are bound to active pixels area
	assign out_x = (line_pos < HA_STA) ? 0 : (line_pos - HA_STA);
	assign out_y = (scr_pos >= VA_END) ? (VA_END - 1) : (scr_pos);
	
	
	// Blanking Interval
	assign out_blank = ((line_pos < HA_STA) | (scr_pos > VA_END - 1));
	
	// Active/Draw interval
	assign out_active = ~((line_pos < HA_STA) | (scr_pos > VA_END - 1)); 
	
	// End of screen tick
	assign out_scrend = ((scr_pos == SCREEN - 1) & (line_pos == LINE));
	
	// Animation tick
	assign out_anim = ((scr_pos == VA_END - 1) & (line_pos == LINE));

	
	always @ (posedge in_clock)
		begin
        if (in_reset)  	// Reset frame
			  begin
					line_pos <= 0;
					scr_pos <= 0;
			  end
        if (in_strobe)  // Per tick
			  begin
					if (line_pos == LINE)  // end of line
						begin
							 line_pos <= 0;
							 scr_pos <= scr_pos + 1;
						end
					else 
						 line_pos <= line_pos + 1;

					if (scr_pos == SCREEN)  // end of screen
						 scr_pos <= 0;
			  end
    end

endmodule
