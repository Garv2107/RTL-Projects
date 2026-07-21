module syn_FIFO#(parameter DATA_WIDTH = 8, // Width of each data word (bits)
						parameter DEPTH = 64,	// Number of FIFO storage locations
						parameter ADDR_WIDTH = 6)// Address width (2^ADDR_WIDTH >= Depth)
						(clk, rst, data_out, data_in, wr_en, rd_en, empty, full, FIFO_counter);
						
	input clk, rst, wr_en, rd_en;
	input [DATA_WIDTH - 1:0]data_in;
	output reg [DATA_WIDTH - 1:0]data_out;
	output empty, full;
	output reg [ADDR_WIDTH:0]FIFO_counter;
	
	reg [DATA_WIDTH - 1:0]mem[DEPTH - 1:0];
	reg [ADDR_WIDTH - 1:0]rd_ptr;
	reg [ADDR_WIDTH - 1:0]wr_ptr;
	
	//For Flags EMPTY and FULL
	assign full = (FIFO_counter == DEPTH);
	assign empty = (FIFO_counter == 0);

	//FIFO COUNTER
	always@(posedge clk or posedge rst)begin
		if(rst)
			FIFO_counter <= 0;
		else if((!empty && rd_en) && (!full && wr_en))
			FIFO_counter <= FIFO_counter;
		else if(!empty && rd_en)
			FIFO_counter <= FIFO_counter - 1;
		else if(!full && wr_en)
			FIFO_counter <= FIFO_counter + 1;
	end
	
	//DATA FROM FIFO
	always@(posedge clk or posedge rst)begin
		if(rst)
			data_out <= 0;
		else begin
			if(!empty && rd_en)
				data_out <= mem[rd_ptr];
		end
	end
	//DATA TO FIFO
	always@(posedge clk)begin
		if(!full && wr_en)
			mem[wr_ptr] <= data_in;
	end
	
	//Read Write POINTER
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			wr_ptr <= 0;
			rd_ptr <= 0;
		end
		else begin
			if(!full && wr_en)
				wr_ptr <= wr_ptr + 1;
				
			if(!empty && rd_en)
				rd_ptr <= rd_ptr + 1;
		end
	end
endmodule