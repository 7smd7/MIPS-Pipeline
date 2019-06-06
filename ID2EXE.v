module ID2EXE (clk, rst, signExIn,  readData1In,  readData2In,  PC_In,  EXE_In,  M_In, WB_In,  src1In,  src2In,
                         signExOut, readData1Out, readData2Out, PC_Out, EXE_Out, M_Out, WB_Out, src1Out, src2Out);
  input clk, rst, M_In;
  input [1:0] WB_In;
  input [2:0] EXE_In
  input [4:0] src1In, src2In;
  input [31:0] signExIn, PC_In, readData1In, readData2In;
  output M_Out;
  output [1:0] WB_Out;
  output [2:0] EXE_Out;
  output [4:0] src1Out, src1Out;
  output [31:0] signExOut, PC_Out, readData1Out, readData2Out;

  always @(posedge clk) begin
    
  end
endmodule // ID2EXE