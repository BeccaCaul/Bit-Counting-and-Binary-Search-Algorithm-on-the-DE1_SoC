`timescale 1 ps / 1 ps
module DE1_SoC_tb ();
  	parameter W = 8;
   logic CLOCK_50;  // 50MHz clock
   logic [6:0] HEX0, HEX1;  // active low
   logic [9:0] SW;
   logic [9:0] LEDR;
   logic [3:0] KEY; //active low

  //instantiate task 1 as dut
  DE1_SoC #(W) dut(.*);
  
  // simulated clock
	 parameter period = 100;
	 initial begin
		CLOCK_50 <= 0;
		forever
			#(period/2)
			CLOCK_50 <= ~CLOCK_50;
	end // initial clock
	
	integer i;
	initial begin
	//TASK 1 TESTS => SW[9] = 0
			KEY[0] = 0; KEY[3] = 1; SW[9] = 0;                   @(posedge CLOCK_50); //reset
			KEY[0] = 1;			                                   @(posedge CLOCK_50);
			
			for (i = 0; i < 2**W; i++) begin  								//iterate through all possible values for A
					  KEY[0] = 0; KEY[3] = 1; SW[9] = 0;            @(posedge CLOCK_50); //reset
					  KEY[0] = 1;			                           @(posedge CLOCK_50);
		           SW[7:0] = i;												@(posedge CLOCK_50); //set A
					  KEY[3] = 1;												@(posedge CLOCK_50);  // start
					  KEY[3] = 0; 									         @(posedge LEDR[9]); // wait for posedge of done signal to display final result
			end
  //TASK 2 TESTS => SW[9] = 1
			KEY[0] = 0; KEY[3] = 1; SW[9] = 1;                   @(posedge CLOCK_50); //reset
			KEY[0] = 1;			                                   @(posedge CLOCK_50);
				
				for (i = 0; i < 2**W; i++) begin  								//iterate through all possible values for A
						  KEY[0] = 0; KEY[3] = 1; SW[9] = 1;            @(posedge CLOCK_50); //reset
						  KEY[0] = 1;			                           @(posedge CLOCK_50);
						  SW[7:0] = i;												@(posedge CLOCK_50); //set A
						  KEY[3] = 1;												@(posedge CLOCK_50);  // start
						  KEY[3] = 0; 									         @(posedge LEDR[9]); // wait for posedge of done signal to display final result
			end
		@(posedge CLOCK_50); // extra cycle
		$stop;
	end
endmodule