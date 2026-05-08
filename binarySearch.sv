//this is a bitcounting algorithm that counts the number of bits set to 1 in an n-bit input
module binarySearch #(parameter W = 8)(input logic s, reset, clk,
			  output logic done, Loc,
			  input logic [W-1:0] A,
			  output logic found);

			  
	//define status and control signals
	//Status signals: counter_eq_logN, curr_lt_mid, curr_gt_mid, set_found ??
	//Control signals: set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low 

	logic high_eq_low, curr_lt_mid, curr_gt_mid, set_found;
	logic set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low;
	
	
   //instantiate control and datapath
	binarySearch_controller c_unit (.*);
	binarySearch_datapath d_init (.*);
	
endmodule