module ID2EXE (clk, rst, signExIn,  readData1In,  readData2In,  PC_In,  EXE_In,  M_In, WB_In,  dest1In,  dest2In,
                         signExOut, readData1Out, readData2Out, PC_Out, EXE_Out, M_Out, WB_Out, dest1Out, dest2Out);
  input clk, rst;
  input [1:0] WB_In;
  input [2:0] M_In;
  input [3:0] EXE_In;
  input [4:0] dest1In, dest2In;
  input [31:0] signExIn, PC_In, readData1In, readData2In;
  output reg [1:0] WB_Out;
  output reg [2:0] M_Out;
  output reg [3:0] EXE_Out;
  output reg [4:0] dest1Out, dest1Out;
  output reg [31:0] signExOut, PC_Out, readData1Out, readData2Out;

  always @(posedge clk) begin
    if (rst) begin
      {M_Out, WB_Out, EXE_Out, signExOut, PC_Out, readData1Out, readData2Out, dest1_out, dest2_out} <= 0;
    end
    else begin
      M_Out <= M_In;
      WB_Out <= WB_In;
      EXE_Out <= EXE_In;
      signExOut <= signExIn;
      readData1Out <= readData1In;
      readData2Out <= readData2In;
      PC_Out <= PCIn;
      dest1_out <= dest1_in;
      dest2_out <= dest2_in;
    end
  end
endmodule // ID2EXE