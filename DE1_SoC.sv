/*Top Level module for a bit counting algorithm and binary serach algorithm implementing on FPGA
* 		-KEY3 is used for 'start' signal
*		-KEY0 is used for reset
*		-SW9 is used to toggle between tasks (bit counting active low and binary serach active high)
*		- SW7-SW0 control the input value 'A' (either to be bit counted or searched for)
*		-binary search is implemented with an on-board 32x8 RAM module which reads from my_array.mif
*/
module DE1_SoC #(parameter W=8)
                (CLOCK_50, HEX0, HEX1, SW, KEY, LEDR);
  input  logic       CLOCK_50;  // 50MHz clock
  output logic [6:0] HEX0, HEX1;  // active low
  input  logic [9:0] SW;
  output  logic [9:0] LEDR;
  input  logic [3:0] KEY; //active low
  
  //INTERNAL LOGIC ---------------------------------------------------------
  logic key3_stable, key0_stable;
  logic reset, done;
  logic [W-1:0] A;
  logic s;
  logic [6:0] count_leds;
  
  //task 1
  logic        done_t1;
  logic [W-1:0] result;
  
  //task 2
  
  logic        done_t2, found;
  logic [4:0]  Loc;
  
  //outputs
  logic        done_out, found_out;
  logic [4:0]  loc_out;
  

  
  //HARDWARE CONNECTIONS: --------------------------------------------------
  D_FF key0_sync (.clk(CLOCK_50), .button(~KEY[0]), .out(key0_stable));
  D_FF key3_sync (.clk(CLOCK_50), .button(~KEY[3]), .out(key3_stable));
  
  assign reset = key0_stable;
  assign A = SW[7:0];
  
  //start assigns
  logic s_t1, s_t2;
  assign s_t1 = key3_stable & ~SW[9];
  assign s_t2 = key3_stable &  SW[9];
  
  assign task_toggle = SW[9];
  
  assign done_out  = SW[9] ? done_t2  : done_t1;
  assign found_out = SW[9] ? found : 1'b0;
  assign loc_out   = SW[9] ? Loc   : result[4:0];
  //DISPLAY: ----------------------------------------------------------------
  seg7 disp0 (.hex(loc_out[3:0]), .leds(HEX0));
  seg7 disp1 (.hex({3'b0, loc_out[4]}), .leds(HEX1));
  
  assign LEDR[9] = done_out;
  assign LEDR[0]   = found_out;
  assign LEDR[8:1] = '0;
  
  //synchronize start 
  //INSTANTIATE -------------------------------------------------------------
	bitCounter task1 (.s(s_t1), .reset, .clk(CLOCK_50), .done (done_t1), .A, .result);
	
	binarySearch task2 (.s(s_t2), .reset, .clk(CLOCK_50), .done(done_t2), .found, .Loc, .A);

endmodule