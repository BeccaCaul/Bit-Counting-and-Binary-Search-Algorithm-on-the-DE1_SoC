//this is the datapath for the binary search algorithm. it takes in control signals
//				from the controller and updates staus signals accordingly


//TODO: figure out what im interfacign with for addresses and shit
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
    // RAM address output (current mid)
    output logic [4:0]   addr,
    // Status signals
    output logic         low_gteq_high,
    output logic         val_lt_mid,
    output logic         val_gt_mid,
    output logic         val_found,
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
					mid <= (low + high) >> 1;
				if(update_high) 
					high <= mid - 5'd1;
				if(update_low) 
					low  <= mid + 5'd1;	
		   end
		end
	end //always_ff
	
	assign addr = mid;
	
	//assign ouputs
	assign low_gteq_high = (low >= high);
	assign val_lt_mid = (A < mem_data);
	assign val_gt_mid = (A > mem_data);
	assign val_found     = (mem_data == A);


endmodule 