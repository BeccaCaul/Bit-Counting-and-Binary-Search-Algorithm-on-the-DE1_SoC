//this is a bitcounting algorithm that counts the number of bits set to 1 in an n-bit input
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