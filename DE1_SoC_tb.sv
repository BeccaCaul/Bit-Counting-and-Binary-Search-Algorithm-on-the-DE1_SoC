/*
module DE1_SoC_tb ();
  	parameter W = 8;
	logic s, reset, clk;
   logic done;
   logic [W-1:0] A;
   logic [W-1:0] result;

  //instantiate task 1 as dut
  DE1_SoC #(W) dut(.*);
  
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
					  $display("T= %4t, countOnes(%8b) returned %0d", $time, A, result); 
					  @(posedge clk);                       
		end
		@(posedge clk); // extra cycle
		$stop;
	end
endmodule
*/ 