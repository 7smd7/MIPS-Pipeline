module EXE2MEM (clk, rst, zeroIn,  WB_In,  M_In,  PC_In,  ALUResIn,  readDate2In,  destIn,
                          zeroOut, WB_Out, M_Out, PC_Out, ALUResOut, readDate2Out, destOut);
    input clk, rst, zeroIn;
    input [1:0] WB_In;
    input [2:0] M_In;
    input [4:0] destIn;
    input [31:0] ALUResIn, readDate2In, PC_In;
    output reg zeroOut;
    output reg [1:0] WB_Out;
    output reg [2:0] M_Out;
    output reg [4:0] destOut;
    output reg [31:0] ALUResOut, readDate2Out, PC_Out;

    

    always @ (posedge clk) begin
        if (rst) begin
            {M_Out, zeroOut, WB_Out, destOut, ALUResOut, readDate2Out, PC_Out} <= 0;
        end
        else begin
            M_Out <= M_In;
            zeroOut <= zeroIn;
            WB_Out <= WB_In;
            destOut <= destIn;
            ALUResOut <= ALUResIn;
            readDate2Out <= readDate2In;
            PC_Out <= PC_In;
        end
    end
endmodule