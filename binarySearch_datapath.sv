//this is the datapath for the binary search algorithm. it takes in control signals
//				from the controller and updates staus signals accordingly
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
//		reset - reset
//		A - value we are searching for (controlled by user input)
//		mem_data - data at the searched address in the array
//		addr - address we're requesting from the RAM
// 	Loc - address of the matching value in the array (0 if never found)
module binarySearch_datapath #(parameter W = 8)(
    input  logic         clk,
    input  logic         reset,
    input  logic [W-1:0] A,
    input  logic [7:0]   mem_data,
    // Control signals
    input  logic         set_Loc,
    input  logic         clr_all,
    input  logic         set_mid,
    input  logic         update_high,
    input  logic         update_low,
    // RAM address
    output logic [4:0]   addr,
    // Status signals
    output logic         low_gt_high,
    output logic         val_lt_mid,
    output logic         val_gt_mid,
    output logic         val_found,
	 output logic 			 low_eq_high,
    // location of matching value
    output logic [4:0]   Loc
);

	logic [4:0] low, mid, high;
	
	// datapath logic
	always_ff @(posedge clk) begin
		if (reset) begin
          low  <= 5'd0;
          high <= 5'd31;
          mid  <= 5'd0;
          Loc  <= 5'd0;
		end else begin
			if (clr_all) begin
          low  <= 5'd0;
          high <= 5'd31;
          mid  <= 5'd0;
          Loc  <= 5'd0;
		   end else begin
				if (set_Loc)
					Loc <= mid;
				if (set_mid) 
					mid <= low + ((high - low) >> 1); //sets mid to the middle of high and low
				if(update_high) 
					high <= mid - 5'd1; //searching left half of section
				if(update_low) 
					low  <= mid + 5'd1; //searching right half of section
		   end
		end
	end 
	
	assign addr = mid;
	
	//assign ouputs
	assign low_gt_high = (low > high);
	assign low_eq_high = (low == high) && (A != mem_data);
	assign val_lt_mid = (A < mem_data);
	assign val_gt_mid = (A > mem_data);
	assign val_found     = (mem_data == A);


endmodule 