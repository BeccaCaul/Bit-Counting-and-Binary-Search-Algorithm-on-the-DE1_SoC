//this is the controller for the bit counting algorithm
	//Status signals: low_gteq_high, val_lt_mid, val_gt_mid, val_found
	//Control signals: set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low
module binarySearch_controller (	 
	 input  logic clk,
    input  logic reset,
    input  logic s,
    // Status signals
    input  logic low_gt_high,
    input  logic val_lt_mid,
    input  logic val_gt_mid,
    input  logic val_found,
	 input logic low_eq_high,
    // Control signals
    output logic set_Loc,
    output logic clr_all,
    output logic set_mid,
    output logic update_high,
    output logic update_low,
    // external outputs
    output logic done,
    output logic found );
	
  typedef enum logic [3:0] {IDLE, INIT, WAIT, COMPARE, REGMEM, WAIT2, UPDATE, FOUND, NOTFOUND} statetype;
  statetype ps, ns;
 
  always_comb begin
	   case (ps)
			 IDLE: ns = s ? INIT : IDLE; 
			 INIT: ns = WAIT;
			 WAIT: ns = COMPARE;
			 COMPARE: begin 
				if (val_found)
                ns = FOUND;
            else if (low_gt_high)
                ns = NOTFOUND;
            else
                ns = REGMEM;
			 end
			 REGMEM: ns = UPDATE;
		 	 UPDATE: ns = low_eq_high ? NOTFOUND : WAIT2;
			 WAIT2: ns = WAIT;
			 FOUND: ns = FOUND; //maybe swap later?
			 NOTFOUND: ns = NOTFOUND;
	   endcase
  end
  
  	// control signals
	assign clr_all = (ps == IDLE);
	
	
	assign set_mid = (ps == INIT) || (ps == COMPARE);
	
	assign update_high = (ps == UPDATE) && val_lt_mid;
   assign update_low  = (ps == UPDATE) && val_gt_mid;
	assign set_Loc = (ps == COMPARE);
	assign found = (ps == FOUND);
	assign done = (ps == FOUND || ps == NOTFOUND);
	
	
	always_ff @(posedge clk)
		if (reset)
			ps <= IDLE;
		else
			ps <= ns;
  
  
endmodule