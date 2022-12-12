module ship(
	input clk_1ms,reset, 
	input upButton, downButton,
	input [9:0] x, y,   //x and y position of the ship
	output ship_on,
	output [11:0] rgb_ship,
	output reg [9:0] x_ship = L_position + (shipwidth/2),  //starting position of the ship
	output reg [9:0] y_ship = V_active/2
	);

	localparam H_active = 640; //Resolution and bounds of the screen
	localparam V_active = 480;
	
	localparam shipwidth = 50;  //Size of ship
	localparam shipheight = 20;

	
	localparam L_position = 20; //Position of ship is set 20 pixles away from the right side of the screen
	localparam R_position = 20;
		
	always @ (posedge clk_1ms)
	begin
		if(!reset)
		begin	
			x_ship <= L_position + (shipwidth/2);  //starting position of ship is in the middle right side of screen
			
			y_ship <= V_active/2;
		end
		else if (downButton && y_ship-(shipheight/2) >= 0) //downwards movment will check for bounds
		
			y_ship <= y_ship-1;
			
		else if (upButton && y_ship+(shipheight/2) <= V_active) //upwards movment will check for bounds
		
			y_ship <= y_ship+1;
			
		else y_ship <= y_ship;
	end
	//drawing the ship 
	assign ship_on = (x >= x_ship-(shipwidth/2) && x <= x_ship+(shipwidth/2) && y >= y_ship-(shipheight/2) && y < y_ship+(shipheight/2))?1:0;

	assign rgb_ship = 12'b111100000000; //color 
	
	
endmodule