module t1_controller (clk, reset, s, A_eq_0, a0,
                     shiftA, loadA, done, incr_result, clr_result);
	
	
	// control signals: shiftA, loadA, done, incr_result, clr_result
	// status signals: s, reset, A_eq_0, a0
	// states: S1: idle, S2: count/shift, S3: done
	

	// port definitions
	input logic clk, reset, s;
	input logic A_eq_0, a0; //status signals
	output logic shiftA, loadA, done, incr_result, clr_result; //control signals
	
	
	// define state names and variables
	enum logic [1:0] {S1, S2, S3} ps, ns;
	
	
	// next state logic
	always_comb begin
		case (ps)
			S1: ns = s ? S2 : S1;
			S2: ns = A_eq_0 ? S3 : S2;
			S3: ns = s ? S3 : S1;
		endcase
	end //always_comb
	
	
	
	// FSM outputs - control signals
	assign loadA = (ps == S1) && (s==0);
	assign clr_result = (ps == S1);
	assign shiftA = (ps == S2);
	assign incr_result = (ps == S2) && !A_eq_0 && a0;
	assign done = (ps == S3);
	
	
	
	// controller logic w/synchronous reset
	always_ff @(posedge clk)
		if (reset)
			ps <= S1;
		else
			ps <= ns;



endmodule //t1_controller