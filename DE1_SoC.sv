/*Top Level module for 32x3 RAM connections to hardware
*/
module DE1_SoC #(parameter W=8)
                (CLOCK_50, HEX0, HEX1, SW, KEY, LEDR);
  input  logic       CLOCK_50;  // 50MHz clock
  output logic [6:0] HEX0, HEX1;  // active low
  input  logic [8:0] SW;
  output  logic [9:0] LEDR;
  input  logic [3:0] KEY; //active low
  
  //INTERNAL LOGIC ---------------------------------------------------------
  logic key3_stable, key0_stable;
  logic reset, done;
  logic [W-1:0] A, result;
  logic s;
  logic [6:0] count_leds;
  
  //HARDWARE CONNECTIONS: --------------------------------------------------
  D_FF key0_sync (.clk(CLOCK_50), .button(KEY[0]), .out(key0_stable));
  D_FF key3_sync (.clk(CLOCK_50), .button(KEY[3]), .out(key3_stable));
  assign reset = key0_stable;
  assign A = SW[7:0];
  assign s = key3_stable;
  
  assign task_toggle = SW[9];
  
  //DISPLAY: ----------------------------------------------------------------
  seg7 display_count (.hex(result[3:0]), .leds(count_leds));
  assign HEX0 = count_leds;
  
  assign LEDR[9] = done;
  
  //INSTANTIATE -------------------------------------------------------------
	bitCounter task1 (.s, .reset, .clk(CLOCK_50), .done, .A, .result);
	
	binarySearch task2 (

endmodule