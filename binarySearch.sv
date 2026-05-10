//This is a binary Search algorithm that searches for a value 'A' in a sorted array
// Inputs/Outputs:
//		clk - clock
//		reset - reset
//		s - start algorithm
//		A - use inputted value to search for
//		done - is the algorithm done
//		found - did we find the value
//		Loc - where was the value found in the array (0 if not found)
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
module binarySearch #(parameter W = 8)(
    input  logic         clk,
    input  logic         reset,
    input  logic         s,
    input  logic [W-1:0] A,
    output logic         done,
    output logic         found,
    output logic [4:0]   Loc
);
	 
	 //status signals
	 logic low_gt_high;   
    logic val_lt_mid;  
    logic val_gt_mid;   
    logic val_found; 
	 logic low_eq_high;
 
    // Control signals
    logic set_Loc;
    logic clr_all;
    logic set_mid;
    logic update_high;
    logic update_low;
	 
	 logic [4:0] addr;
    logic [7:0] mem_data;
 
    ram32x8 dataSet (.clock   (clk), .address (addr), .q (mem_data));
	
   //instantiate control and datapath
	binarySearch_controller c_unit (.*);
	binarySearch_datapath d_init (.*);
	
endmodule