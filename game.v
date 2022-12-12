module game (
	input clk, reset, upButton, downButton, fireButton,
	output [11:0] rgb,
	output hsync, vsync, 
	output [6:0] seg1
	);
	
	
	wire [9:0] x,y;
	
	wire video_on;
	wire clk_1ms;
	
	wire [11:0] rgb_ship, rgb_rocket, rbg_astroid;
	wire rocket_on, ship_on, astroid_on;
	wire [9:0] x_ship,  y_ship, x_rocket, y_rocket;
	wire [4:0] player_score, gameOver;
	wire [1:0] game_state;
	
	vga_sync v1	(.clk(clk), .hsync(hsync), .vsync(vsync), .x(x), .y(y), .video_on(video_on));
	
	render r1	(.clk(clk), .reset(reset), .x(x), .y(y), .video_on(video_on), .rgb(rgb), .clk_1ms(clk_1ms),
					.ship_on(ship_on),  .rocket_on(rocket_on), .astroid_on(astroid_on),
					.rgb_ship(rgb_ship),  .rgb_rocket(rgb_rocket), .rbg_astroid(rbg_astroid),
					.game_state(game_state));
				
	clock_divider c1 (.clk(clk), .clk_1ms(clk_1ms));
	
	ship s1	(.clk_1ms(clk_1ms), .reset(reset), .x(x), .y(y),
					 .upButton(upButton), .downButton(downButton), 
					.ship_on(ship_on), .rgb_ship(rgb_ship),  
					.x_ship(x_ship),  .y_ship(y_ship) );
	
	
	
	astroid a1 (.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .x(x), .y(y),  .astroid_on(astroid_on), .rgb_astroid(rbg_astroid),
				.x_ship(x_ship), .y_ship(y_ship), .game_state(game_state), .x_rocket(x_rocket), .y_rocket(y_rocket), 
				.player_score(player_score), .gameOver(gameOver));
				
	
	rocket ro1 	(.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .fireButton(fireButton), .x(x), .y(y),  .rocket_on(rocket_on), .rgb_rocket(rgb_rocket),
				.x_ship(x_ship),  .y_ship(y_ship),  .x_rocket(x_rocket), .y_rocket(y_rocket),
				  .game_state(game_state));
	

	game_state(.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .player_score(player_score), .gameOver(gameOver), .game_state(game_state));
	
	score (.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .player_score(player_score), .seg1(seg1));
	
	
endmodule