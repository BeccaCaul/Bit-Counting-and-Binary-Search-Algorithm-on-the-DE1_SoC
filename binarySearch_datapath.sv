//this is the datapath for the binary search algorithm. it takes in control signals
//				from the controller and updates staus signals accordingly


//TODO: figure out what im interfacign with for addresses and shit
module binarySearch_datapath #(parameter W = 8)(clk, reset,  shiftA, loadA, incr_result, 
															clr_result, A, A_eq_0, a0, result);
	
	//Status signals: low_gteq_high, val_lt_mid, val_gt_mid, val_found
	//Control signals: set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low

	// port definitions
	input logic clk, reset;
	input logic set_Loc, clr_found, clr_Loc, set_mid, update_high, update_low;
	input logic [W-1:0] A; //what im trying to find 
	output logic [$clog(W)-1:0]  Loc; //check later
	
	logic low, mid, high;
	
	// datapath logic
	always_ff @(posedge clk) begin
		if (loadA) begin
			A1 <= A;
		end
		if (clr_all) begin
			found <= 1'b0;
			Loc <= 1'b0;
			low <= 1'b0;
			mid <= 1'b0;
			high <= W-1'b1;
		end
		if (set_Loc) begin
			Loc <= mid;
		end
		if (set_mid) begin
			mid <= floor((low + high)/2)
		end
		if(update_high) begin
			high <= mid - 1'b1;
		end
		if(update_low) begin
			low <= mid + 1'b1;
		end	
	end //always_ff
	
	//assign ouputs
	assign low_gteq_high = (low >= high);
	assign val_lt_mid = (A < ROM[mid]);
	assign val_gt_mid = (A > ROM[mid]);
	assign val_found = (A == mid);


endmodule 