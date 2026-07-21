	module ALU_TOP_MODULE#(parameter N = 3 )(in, out, flags, clk, rst);
		input [17:0]in;
		input clk, rst;
		output reg [7:0]out;
		output [4:0]flags;
		
		wire [6:0]i1;
		wire [6:0]i2;
		wire [3:0]op;
		wire [4:0]arth_flg;
		wire [7:0]out_art;
	   wire [6:0]out_log;
	   wire [6:0]out_shi;
		
		assign i1 = in[13:7];
		assign i2 = in[6:0];
		assign op = in[17:14];
		
		ALU_ARITHMETIC #(N) art (i1, i2, op[1:0], out_art, arth_flg );
		ALU_LOGIC #(N) log (i1, i2, op[1:0], out_log);
		ALU_SHIFTER #(N) shi (i1, op[1:0], out_shi);
		 
		 assign flags = arth_flg;
		 always@(posedge clk or posedge rst)
			begin
			if(rst)
				out = 0;
			else
				if(clk)begin
					case(op[3:2])
						2'b00: out = out_art; //ARITHMETIC
						2'b01: out = {1'b0, out_log}; //LOGICAL
						2'b10: out = {1'b0, out_shi}; //SHIFTER
						default: out = 0;
					endcase
				end
			end
	endmodule	