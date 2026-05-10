//this is the controller for the binary search algorithm. it takes in status signals
//				from the controller and updates control signals and states accordingly
//				-this assumes the array is sorted in ascending order
// Control Signals:
//		set_Loc - sets the location of the value in the array
//		clr_all - clears all values (low, high, mid, Loc)
//		set_mid - sets mid (the address we're checking) to the middle of low and high
//		update_high - updates the upper address (of the searched section of the array) to mid - 1
//		update_low -  updates the lower address (of the searched section of the array) to mid + 1
// Status Signals:
//		low_gt_high - is low is greater than high
//		val_lt_mid - is the value we want less than the current value in the array
//		val_gt_mid - is the value we want greater than the current value in the array
//		val_found - does the value match the current value in the array
//		low_eq_high - is the lower bound equal to than the upper bound
//	Misc:
//		clk - clock
// 	reset - reset
// 	s - do we start the algorithm
//	   done - are we done with the algorithm
//	   found - did we find the value
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
	
  typedef enum logic [3:0] {IDLE, INIT, WAIT, COMPARE, REGMEM, UPDATE, FOUND, NOTFOUND} statetype;
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
			 REGMEM: ns = UPDATE; //wait for the memory to ouput our new value we're matching against
		 	 UPDATE: ns = low_eq_high ? NOTFOUND : WAIT;
			 FOUND: ns = FOUND; 
			 NOTFOUND: ns = NOTFOUND;
	   endcase
  end
  
  	// control signals
	assign clr_all = (ps == IDLE);
	assign set_mid = (ps == INIT) || (ps == COMPARE);
	
	assign update_high = (ps == UPDATE) && val_lt_mid;
   assign update_low  = (ps == UPDATE) && val_gt_mid;
	assign set_Loc = (ns == FOUND);
	
	//external outputs
	assign found = (ps == FOUND);
	assign done = (ps == FOUND || ps == NOTFOUND);
	
	
	always_ff @(posedge clk)
		if (reset)
			ps <= IDLE;
		else
			ps <= ns;
  
  
endmodule