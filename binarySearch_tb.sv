`timescale 1 ps / 1 ps

module binarySearch_tb ();
  	parameter W = 8;
   logic         clk;
   logic         reset;
   logic         s;
   logic [W-1:0] A;
   logic         done;
   logic         found;
   logic [4:0]   Loc;

  //instantiate task 1 as dut
  binarySearch #(W) dut(.*);
  
  // simulated clock
	 parameter period = 100;
	 initial begin
		clk <= 0;
		forever
			#(period/2)
			clk <= ~clk;
	end // initial clock
	
	integer i;
	initial begin 
			reset = 1; s = 0; @(posedge clk);
			reset = 0;			@(posedge clk);
			
			for (i = 0; i < 2**W; i++) begin                                           
		           A = i;														@(posedge clk);
					  s = 1;														@(posedge clk);  // iterate through all possible values for A
					  s = 0; 									            @(posedge done); // wait for posedge of done signal to display final result
					  $display("T= %4t, value looking for (%8b) value found: %0d @ %4b", $time, A, found, Loc); 
					  @(posedge clk);                       
		end
		@(posedge clk); // extra cycle
		$stop;
	end
endmodule