//this is the controller for the bit counting algorithm
//it includes status signals s, A_eq_0 and a0
//it also includes control signals shiftA, loadA, done, incr_result, and clr_result
module bitCounter_controller (clk, reset, s, A_eq_0, a0, shiftA, 
					loadA, done, incr_result, clr_result);

	input logic clk, reset;
	input logic s, A_eq_0, a0; //status signals
	output logic shiftA, loadA, done, incr_result, clr_result; //control signals
  
  typedef enum logic [1:0] {S1, S2, S3} statetype;
  statetype ps, ns;
 
  always_comb begin
	   case (ps)
			 S1: ns = s ? S2 : S1;
			 S2: ns = A_eq_0 ? S3 :S2;
		 	 S3: ns = s ? S3 : S1;
			 //default: ns = S1;
	   endcase
  end
  
  	// control signals
	assign loadA = (ps == S1) && (s==0);
	assign clr_result = (ps == S1);
	assign shiftA = (ps == S2);
	assign incr_result = (ps == S2) && !A_eq_0 && a0;
	assign done = (ps == S3);
	
	always_ff @(posedge clk)
		if (reset)
			ps <= S1;
		else
			ps <= ns;
  
  
endmodule