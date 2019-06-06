module IF2ID (clk, rst, PCIn, instructionIn, PC, instruction);
  input clk, rst;
  input [31:0] PCIn, instructionIn;
  output reg [31:0] PC, instruction;

  always @ (posedge clk) begin
    if (rst) begin
      PC <= 0;
      instruction <= 0;
    end
    else begin
          instruction <= instructionIn;
          PC <= PCIn;
    end
  end
endmodule // IF2ID