//this is the controller for the bit counting algorithm
	//Status signals: low_gteq_high, curr_lt_mid, curr_gt_mid, val_found
	//Control signals: set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low
module binarySearch_controller (clk, reset, s, low_gteq_high, curr_lt_mid, curr_gt_mid, 
				val_found, set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low);

	input logic clk, reset;
	input logic s, low_gteq_high, curr_lt_mid, curr_gt_mid, val_found;
	output logic set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low;
	//TODO: need to figure out bit width for these
	
  typedef enum logic [1:0] {IDLE, COMPARE, UPDATE, FOUND, NOTFOUND} statetype;
  statetype ps, ns;
 
  always_comb begin
	   case (ps)
			 IDLE: ns = s ? COMPARE : IDLE; 
			 COMPARE: begin 
			 if (val_found)
                ns = FOUND;
            else if (low_gteq_high)
                ns = NOTFOUND;
            else
                ns = UPDATE;
			 end
		 	 UPDATE: ns = COMPARE;
			 FOUND ns = s ? IDLE : FOUND;
			 NOTFOUND ns = s ? IDLE : NOTFOUND;
	   endcase
  end
  
  	// control signals
	assign loadA = (ps == IDLE) && (s==0);
	assign clr_result = (ps == IDLE);
	assign clr_found = (ps == IDLE);
	assign clr_Loc = (ps == IDLE);
	
	assign set_mid = (ps == COMPARE);
	assign update_high = (ps == UPDATE) && curr_lt_mid;
   assign update_low  = (ps == UPDATE) && curr_gt_mid;
	
	assign found = (ps == FOUND);
	assign done = (ps == FOUND || ps == NOTFOUND);
	
	always_ff @(posedge clk)
		if (reset)
			ps <= IDLE;
		else
			ps <= ns;
  
  
endmodule