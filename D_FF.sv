//module to send button input through D FF to avoid metastability
//inputs: clk, button (either left or right button user input)
//output: out (the D FF output)
module D_FF(clk, button, out); //D_FF

	input logic clk, button;
	output logic out;
	
	logic FF1_out;
	
	always_ff @(posedge clk) begin
		FF1_out <= button;
	end
	
	always_ff @(posedge clk) begin
		out <= FF1_out;
	end
endmodule //D_FF