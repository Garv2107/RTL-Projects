module ALU_ARITHMETIC #(parameter N )(i1, i2, s, o, fl);
	input [N - 1:0]i1,i2;
	input[1:0]s;
	output reg [(2*N) - 1:0]o;
	output reg [4:0]fl;
	
	reg [(2*N) - 1:0]O;
		always@(*)
			begin
			fl = 0;
				case(s)
						2'b00:
						begin
							O = i1 + i2; //ADD
							fl[0] = O[N]; //CARRY FLAG
						end
					2'b01:
						begin
							O = i1 - i2; //SUB
							fl[1] = i1<i2; //BORROW FLAG
						end
					2'b10: 
						begin
							O = i1 * i2; //MULTIPLICATION
							if(O[(2*N) - 1:N] != 0)  //OVERFLOW FLAG
								fl[2] = 1;
						end
					2'b11:
						begin
							if(i2 == 0) begin
								fl[3] = 1;      // Divide by zero flag
								O = 0;          // Safe output
							end
						else begin
								O = i1 / i2;    // Division result
								fl[3] = 0;
							end
						end
				endcase	
				o = O;
				if(O == 0)	
					fl[4] = 1; //ZERO ANSWER
			end
endmodule