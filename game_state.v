module game_state(
	input clk, clk_1ms, reset,
	input [4:0] player_score, gameOver,
	output reg [1:0] game_state
	);
	
	reg [3:0] gameState = 4'b1001; //score to win is 9 

	always @ (posedge clk)
	begin
		if (!reset)
			game_state = 0;
		else 
		begin
			if ( player_score == gameState)
				game_state = 2'b10;// won
			else if ( gameOver == gameState)
				game_state = 2'b11;// this register is set to 9 for game a game over
			else 
				game_state = 2'b01;//playing
		end
	end

endmodule