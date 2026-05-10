`timescale 1 ps / 1 ps

//this is the binary search test bench
//tests the algorthm for all possible values of A 
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

	always_comb begin
		if(done)
			$display("T= %4t, VALUE: %8b | FOUND: %s | ADDRESS: %4b", $time, A, 
					(found ? "YES" : "NO"), Loc);                       
	end
	initial begin 
			reset = 1; s = 0; @(posedge clk);
			reset = 0;			@(posedge clk);
			
			for (i = 0; i < 2**W - 1; i++) begin  
					  reset = 1; 	      @(posedge clk);
					  reset = 0;			@(posedge clk);			
		           A = i;														@(posedge clk);
					  s = 1;														@(posedge clk);  // iterate through all possible values for A
					  s = 0; 									            @(posedge done); // wait for posedge of done signal to display final result
		end
		
		@(posedge clk); // extra cycle
		$stop;
	end
endmodule