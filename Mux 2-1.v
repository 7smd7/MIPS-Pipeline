//MIPS
module  mux_2_1(in0, in1, sel, out);
  input  [31:0] in0;
  input  [31:0] in1;
  input         sel;

  output reg [31:0] out;
  
  always@(in0,in1,sel) begin
    out = (sel) ? in1 : in0;
  end
endmodule
