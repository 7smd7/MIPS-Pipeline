module ALU (
	input [31:0] r1,
	input [31:0] r2,
	input [1:0] OP,
	output [31:0] result
);
	reg [31:0] out;
	
  always @(OP) begin
		case(OP)
			2'b00: out = r1 + r2; //ADD, LW,SW
			2'b01: out = r1 & r2; //AND 
			2'b10: out = r1 | r2; //OR
			2'b11: out = r1 - r2; //SUB, BEq
			default: out = 0;
		endcase
	end
	assign result = out;
endmodule