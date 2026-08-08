`timescale 1ns/1ps
module sync_FIFO_tb();
	reg clk, rst, wr_en, rd_en;
	reg [7:0]data_in;
	
	wire full, empty;
	wire [7:0]data_out;
	wire [6:0]FIFO_counter;
	
	syn_FIFO dut(clk, rst, data_out, data_in, wr_en, rd_en, empty, full, FIFO_counter);
	
	always #10 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 1;
		wr_en = 0;
		rd_en = 0;
		data_in = 0;
		
		#40 rst = 0;
		 //Test 1 Write - AA
		#20 wr_en = 1;
			 data_in = 8'hAA; //FIFO_counter = 1
		#20 wr_en = 0;
			if(FIFO_counter == 1)
				$display("PASS : Counter = 1");
			else
				$display("Counter FAIL");
		
		//Test 2 Write - BC
		#20 wr_en = 1;
			 data_in = 8'hBC; //FIFO_counter = 2
		#20 wr_en = 0;
			if(FIFO_counter == 2)
				$display("PASS : Counter = 2");
			else
				$display("Counter FAIL");
		
		//Test 3 Write - 17, Read - AA
		#20 wr_en = 1; rd_en = 1;
			data_in = 8'h17;	//FIFO_counter = 2
						
		#20 wr_en = 0; rd_en = 0;
				if(data_out == 8'hAA)
					$display("PASS : Read AA");
				else
					$display("FAIL");
					
				if(FIFO_counter == 2)
					$display("PASS : Counter = 2");
				else
					$display("Counter FAIL");
		
		//Test 4 Read - BC
		#20 rd_en = 1;
					
		#20 rd_en = 0;
				if(data_out == 8'hBC)
					$display("PASS : Read BC");
				else
					$display("FAIL");   //FIFO_counter = 1
				
				if(FIFO_counter == 1)
					$display("PASS : Counter = 1");
				else
					$display("Counter FAIL");
					
		//Test 5 Read - 17
		#20 rd_en = 1;
					
		#20 rd_en = 0;
				if(data_out == 8'h17)
					$display("PASS : Read 17");
				else
					$display("FAIL");//FIFO_counter = 0
				
				if(FIFO_counter == 0)
					$display("PASS : Counter = 0");
				else
					$display("Counter FAIL");
					
		//TEST 6 Read when FIFO is Empty
		#20 rd_en = 1;
							//FIFO_counter = 0
		#20 rd_en = 0;

			if(empty)
				$display("PASS : FIFO is empty");
			else
				$display("FAIL : Empty flag not asserted");
				
			if(FIFO_counter == 0)
				$display("PASS : Counter unchanged");
			else
				$display("FAIL : Counter changed");	
				
				
			repeat(64) begin
				#20 wr_en = 1;
				data_in = data_in + 1;
				#20 wr_en = 0;
				end

				if(full)
					$display("PASS : FIFO Full");
				else
					$display("FAIL : Full flag not asserted");
		$stop;
	end
endmodule