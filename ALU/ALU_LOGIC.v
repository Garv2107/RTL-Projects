module ALU_LOGIC#(parameter n)(i1, i2, s, o);
 input [n-1:0]i1,i2;  //n = no of bits
 input [1:0]s;
 output reg [n-1:0]o;
 
 always @(*)
	begin
		case(s)
			
			2'b00: o = i1 & i2; //AND
			2'b01: o = i1 | i2; //OR
			2'b10: o = i1 ^ i2; //XOR
			2'b11: o = ~i1;	  //NOT	
		endcase
	end	
endmodule	