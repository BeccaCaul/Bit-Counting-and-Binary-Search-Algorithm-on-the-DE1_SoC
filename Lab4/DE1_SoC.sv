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
  
  //DISPLAY: ----------------------------------------------------------------
  seg7 display_count (.hex(result[3:0]), .leds(count_leds));
  assign HEX0 = count_leds;
  
  assign LEDR[9] = done;
  
  //INSTANTIATE -------------------------------------------------------------
	t1 countOnes (.s, .reset, .clk(CLOCK_50), .done, .A, .result);
			  
  
//  //logic for RAM
//  logic [A-1:0] addr; //5 bit address
//  logic [D-1:0] din; //3 bit data in
//  logic [D-1:0] dout; //3 bit data out
//  logic clk; //clock input separate from clock_50?
//  
//  //HARDWARE CONNECTIONS: ------------------------------------------------
//  //controlling DataIn and Addr using SW
//  //din is connected to [SW3-SW1]
//  assign din = SW[3:1];
//  //addr is connected to [SW8-SW4]
//  assign addr = SW[8:4];
//  //assign SW0 to wren
//  assign wren = SW[0];
//  //KEY0 is clk input;
//  assign clk = KEY[0]; //UPDATE TO CLOCK_50 if things get weird -> clk is 1 when key0 is unpressed (1)
//  
//  //--------------------------------------------------------------------
//  
////  
////  //Connect signals for task1, as specified in the header comment
////  task1 ram1 (.addr, .din, .clk, .wren, .dout);
//  
//  //Connect signals for task2, as specified in the header comment
//  task2 ram2 (.addr, .din, .clk, .wren, .dout);
//  
//  //Connect signals for seg7 as specified in the header comment
//  logic [6:0] hex5_leds, hex4_leds, din_leds, dout_leds;
// 
//  //Display addr on Hex 5 and Hex 4
//  seg7 addr_lsb (.hex(addr[3:0]), .leds(hex4_leds));
//  seg7 addr_msb (.hex({3'b000, addr[4]}), .leds(hex5_leds));
//  
//  assign HEX5 = hex5_leds;
//  assign HEX4 = hex4_leds;
//
//  //Display datain on HEX1
//  seg7 datain_s7 (.hex({1'b0, din}), .leds(din_leds));
//  seg7 dataout_s7 (.hex({1'b0, dout}), .leds(dout_leds));
//  
//  assign HEX1 = din_leds;
//  assign HEX0 = dout_leds;
//  

endmodule  // DE1_SoC
