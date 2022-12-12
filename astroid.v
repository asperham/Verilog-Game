module astroid(input clk,clk_1ms,reset,
					input [9:0] x, y,
					output astroid_on,
					output [11:0] rgb_astroid,
					input [9:0] x_ship, y_ship, x_rocket, y_rocket,
					input [1:0] game_state,
					output reg [4:0]  player_score, gameOver
					);
					
	localparam H_active	= 640;  //setting bounds 
	localparam V_active	= 480;	
	
	localparam astroid_width = 50; 
	localparam astroid_height = 50;
	
	localparam shipwidth = 50;   //for hit detection
	localparam shipheight = 20;
	
	localparam rocket_width = 16;  //for hit detection
	localparam rocket_height = 16;
	
	localparam R_position = 20;    // for hit detection
	reg [9:0] x_astroid, y_astroid;
	
	always @(posedge clk_1ms)
	begin
		if(!reset)
		begin
			x_astroid <= H_active - (R_position + (astroid_width/2)); //starting position
			y_astroid <= V_active/2;
			player_score <= 0; //setting scores to 0 on reset 
			gameOver <=0;
		end
		
		
		else if(game_state == 2'b01)
		begin
	      if(x_astroid == 80)  // if the astroid reaches the right side if the screen, it will respawn on the left
			begin
			   x_astroid <= H_active - (R_position + (astroid_width/2)); //starting position
			   y_astroid <= y_ship;
			end
			// hit detection for the rocket and astroid, the astroid will respawn on right side of screen if hit by rocket
		   else if((x_astroid - astroid_width / 2 <= x_rocket + rocket_width /2) && (y_astroid + astroid_height / 2 >= y_rocket + rocket_height / 2) && (y_astroid - astroid_height / 2 <= y_rocket - rocket_height / 2))
			begin
				x_astroid <= H_active - (R_position + (astroid_width/2)); //starting position
			   y_astroid <= y_ship;
				player_score <= player_score + 1; 
			end
			 //hit detection for the ship and astroid, if the astroid hits the ship the game state will change to game over
			 else if((x_astroid - astroid_width / 2 <= x_ship + shipwidth /2) && (y_astroid + astroid_height / 2 >= y_ship + shipheight / 2) && (y_astroid - astroid_height / 2 <= y_ship - shipheight / 2))
			 begin
				gameOver <= 4'b1001;
			 end
			
			
			else
			begin
				x_astroid <= x_astroid - 1; //astroid movment to left side of the screen
				y_astroid <= y_astroid;
			end
			
		end
		
	end
	//draw astroid 
	assign astroid_on = (x >= x_astroid-(astroid_width/2) && x <= x_astroid+(astroid_width/2) && y >= y_astroid-(astroid_height/2) && y <= y_astroid+(astroid_height/2))?1:0;
	
	assign rgb_astroid = 12'b111101110000;
	
	
endmodule 