/*Bit-Counting algorithm which counts the number of 1s in a given input A
*logic is split between controller (c_unit) and datapath (d_unit) modules
*/
module bitCounter #(parameter W = 8)(input logic s, reset, clk,
			  output logic done,
			  input logic [W-1:0] A,
			  output logic [W-1:0] result);

			  
	//define status and control signals
	logic shiftA, loadA, incr_result, clr_result;
	logic A_eq_0, a0;
	
	
   //instantiate control and datapath
	bitCounter_controller c_unit (.*);
	bitCounter_datapath d_init (.*);
	
endmodule