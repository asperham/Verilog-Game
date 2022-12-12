module render(
	input clk, reset,
	input [9:0] x, y,//position of point on screen
	input video_on,
	output [11:0]rgb,
	input clk_1ms,
	input ship_on, rocket_on, astroid_on, 
	input [11:0]rgb_ship,rgb_rocket, rbg_astroid,
	input [1:0] game_state
	);
	
	reg [11:0] rgb_reg;

	
	localparam H_ACTIVE	= 640; //size and boundries of screen
	localparam V_ACTIVE	= 480; 
	localparam zero		= 0;
	
	localparam X_blocksize = 50; //setting the block size of horizontal and vertical
	localparam Y_blocksize = 50;
	//poistion of center block
	reg [9:0] x_block = H_ACTIVE/2, y_block=V_ACTIVE/2;
	
	always @(posedge clk)
	begin
	if (!reset)
		rgb_reg <= 0; //black screen or default 
	else
		begin
			if (game_state == 2'b01) //playing game
			begin
				if (ship_on)
					rgb_reg <= rgb_ship; //setting color of ship
				else if (rocket_on)
					rgb_reg <= rgb_rocket; //setting color of rocket
				else if (astroid_on)
					rgb_reg <= rbg_astroid; //setting color of astroid
				else
					rgb_reg <= 12'b000000000000;//background color is black 
			end
			else if (game_state == 2'b10)    //win state
				rgb_reg <= 12'b000000001111; 
			else if (game_state == 2'b11)    //lose state
				rgb_reg <= rgb_ship;
			else rgb_reg <= 0;
		end
	end
	assign rgb = (video_on) ? rgb_reg : 8'b0; 
	
endmodule