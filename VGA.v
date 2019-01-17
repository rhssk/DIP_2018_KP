`default_nettype none
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

module VGA(
    input wire in_clock,       
    input wire in_strobe,      
    input wire in_reset,   
    
    output wire out_hsync,     
    output wire out_vsync,  
	 
    output wire out_blank,   // blanking interval  
    output wire out_active,  // visible image data/signal
    output wire out_screen,    
    
    output wire [9:0] out_x,   
    output wire [8:0] out_y    
    );

    localparam HS_STA = 16;           // Skatît DIP VGA dokumentu   
    localparam HS_END = 16 + 96;         
    localparam HA_STA = 16 + 96 + 48;    
    localparam VS_STA = 480 + 11;        
    localparam VS_END = 480 + 11 + 2;    
    localparam VA_END = 480;             
    localparam LINE   = 800;             
    localparam SCREEN = 524;             

    reg [9:0] linepos;  
    reg [9:0] pixpos;  


	// Generate VH sync
	 assign out_hsync = ~((linepos >= HS_STA) & (linepos < HS_END));
    assign out_vsync = ~((pixpos >= VS_STA) & (pixpos < VS_END));

	// X and Y are bound to active pixels area
    assign out_x = (linepos < HA_STA) ? 0 : (linepos - HA_STA);
    assign out_y = (pixpos >= VA_END) ? (VA_END - 1) : (pixpos);

	// Blanking Interval
    assign out_blank = ((linepos < HA_STA) | (pixpos > VA_END - 1));

	// Active/Draw interval for visible image signal
    assign out_active = ~((linepos < HA_STA) | (pixpos > VA_END - 1)); 

	// End of screen tick
    assign out_screen = ((pixpos == SCREEN - 1) & (linepos == LINE));

    always @ (posedge in_clock)
		 begin
			  if (in_reset)  // reset frame
				  begin
						linepos <= 0;
						pixpos <= 0;
				  end
			  if (in_strobe)  // per 40ns tick
				  begin
						if (linepos == LINE)  
							begin
								 linepos <= 0;
								 pixpos <= pixpos + 1;
							end
						else 
							 linepos <= linepos + 1;

						if (pixpos == SCREEN) 
pixpos <= 0;
				  end
		 end
endmodule