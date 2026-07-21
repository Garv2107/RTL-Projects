module ALU_SHIFTER #(parameter N)(i1, s, o);
	input [N - 1:0]i1;
	input [1:0]s;
	output reg [N - 1:0]o;

	always@(*)
		begin
			case(s)
				2'b00: o = i1 << 1; //LEFT SHIFT
				2'b01: o = i1 >> 1; //RIGHT SHIFT
				2'b10: o = {i1[N-2:0], i1[N-1]}; // rotate left
				2'b11: o = {i1[0], i1[N-1:1]}; // rotate right
			endcase
		end
endmodule		