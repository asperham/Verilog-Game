module rocket(
	input clk,clk_1ms,reset, fireButton,
	input [9:0] x, y,
	output rocket_on,
	output [11:0] rgb_rocket,
	input [9:0] x_ship, y_ship,
	input [1:0] game_state,
	output reg [9:0] x_rocket,
	output reg [9:0] y_rocket 
	);
		
	localparam H_ACTIVE	= 640; //Resolution and bounds of screen
	localparam V_ACTIVE	= 480;
	
	localparam rocket_width = 16; //horizontal
	localparam rocket_height = 16; //vertical
	
	
	reg flag = 0;
	
	always @ (posedge clk_1ms)
	begin
	
		if(!reset)
		begin
			x_rocket <= x_ship; // rocket starts at current ship location
			y_rocket <= y_ship;
		   flag <=0;	//flag for the rocket
			
		end
		else if (game_state == 2'b01)
		begin
			
			if (x_rocket == (H_ACTIVE - rocket_width/2)) //check for right side of screen
			begin 
				flag <=0;
				x_rocket <= x_ship; //Starts at ship
				y_rocket <= y_ship;
			end
			
			else if (flag == 1)
			begin
				x_rocket <= x_rocket + 1;  //movement across the screen on x axis 
				y_rocket <= y_rocket;	
			end
			
			else if (fireButton == 1)
			begin
				flag <= 1; //set the flag to 1 as rocket is moving on screen
			end
			
			else
			begin
			   x_rocket <= x_ship;  //movment 
				y_rocket <= y_ship;	
			end
			
		end
		else //If game is not being played this usually wont be run 
		begin
			x_rocket <= x_ship;
		   y_rocket <= y_ship;
		end

	end
	//drawing rocket 	
	assign rocket_on = (x >= x_rocket-(rocket_width/2) && x <= x_rocket+(rocket_width/2) && y >= y_rocket-(rocket_height/2) && y <= y_rocket+(rocket_height/2))?1:0;
	
	assign rgb_rocket = 12'b111111111111;
	
	
	
endmodule