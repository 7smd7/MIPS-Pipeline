module MipsCPU(clock, reset); 
    
    input clock;
    input reset; 

    wire Zero;
    wire [4:0]  wbWriteReg;
    wire [31:0] WriteData_Reg;
    wire [4:0]  WriteReg;
    wire [31:0] Add_PCOut;
    wire [31:0] PCin, PCout;
    wire [31:0] Add_ALUOut;
    wire [31:0] ALUOut;
    wire [31:0] ReadData;

    PC pc_0(
        //inputs
        .clk(clock), .rst(reset), .PCin(PCin),
        //outputs
        .PCout(PCout) 
    );

    wire [31:0] inst;
    inst_mem instmem_0(
        //inputs
        .pc(PCout),
        //outputs
        .instruction(inst)
   );

    wire [31:0] idpc,idinst;
    IF2ID if2id (
       //inputs
       .clk(clock), 
       .rst(reset), 
       .PCIn(Add_PCOut),
       .instructionIn(inst),
       //outputs 
       .PC(idpc),
       .instruction(idinst)
    );

    wire reg [1:0] wb;
    wire reg [2:0] m;
    wire reg [3:0] exe;    
    control main_control_0(
        //inputs
        .opcode(idinst[31:26]),
        //outputs
        .wb(wb), .m(m), .exe(exe)
    );
    
    wire [1:0] wbWB;
    wire [31:0] ReadData1, ReadData2; 
    ReqFile regfile_0(
        //inputs
        .rd_reg1(idinst[25:21]), 
        .rd_reg2(idinst[20:16]),
        .RegWrite(wbWB[0]),
        .wr_reg(wbWriteReg),
        .wr_data(WriteData_Reg),
        //outputs
        .rd_data1(ReadData1),
        .rd_data2(ReadData2)
    ); 

    wire [31:0] Extend32; 
    signext sign_extend_0(
        //inputs
        .ip(idinst[15:0]),
        //outputs
        .op(Extend32)
    );

    wire [1:0] exWB;
    wire [2:0] exM;
    wire [3:0] exEXE;
    wire [4:0] exdest1, exdest2;
    wire [31:0] exsignEx, exPC, exreadData1, exreadData2;   
    ID2EXE id2exe (
        //inputs
        .clk(clock), 
        .rst(reset), 
        .signExIn(Extend32),
        .readData1In(ReadData1),  
        .readData2In(ReadData2),  
        .PC_In(idpc),
        .EXE_In(exe),
        .M_In(m), 
        .WB_In(wb),
        .dest1In(idinst[20:16]),  
        .dest2In(idinst[15:11]),
        //outputs
        .signExOut(exsignEx),
        .readData1Out(exreadData1),
        .readData2Out(exreadData2),
        .PC_Out(exPC),
        .EXE_Out(exEXE),
        .M_Out(exM), 
        .WB_Out(exWB), 
        .dest1Out(exdest1),
        .dest2Out(exdest2)
    );

    wire memZero;
    wire [1:0] memWB;
    wire [2:0] memM;
    wire [4:0]  memWriteReg;
    wire [31:0] memAdd_ALU, memPC, memreadData2;
    EXE2MEM exe2mem (
        //inputs
        .clk(clock),
        .rst(reset), 
        .zeroIn(Zero),
        .WB_In(exWB),
        .M_In(exM),
        .PC_In(Add_ALUOut),
        .ALUResIn(ALUOut),
        .readDate2In(exreadData2),
        .destIn(WriteReg),
        //outputs
        .zeroOut(memZero), 
        .WB_Out(memWB), 
        .M_Out(memM),
        .PC_Out(memPC),
        .ALUResOut(memAdd_ALU), 
        .readDate2Out(memreadData2),
        .destOut(memWriteReg)
        );
    
    wire [31:0] wbAdd_ALU, wbReadData;
    MEM2WB mem2wb (
        //inputs
        .clk(clock), 
        .rst(reset), 
        .WB_IN(memWB), 
        .ALUResIn(memAdd_ALU), 
        .memReadIn(ReadData), 
        .destIn(memWriteReg),
        //outputs
        .WB_Out(wbWB),
        .ALUResOut(wbAdd_ALU),
        .memReadOut(wbReadData),   
        .destOut(wbWriteReg)  
        );


    //Mux InstMem - RegisterFile 
    mux_2_1 mux0(
            //input
            .in0(exdest1),
            .in1(exdest2),
            .sel(exEXE[0]),
            //output
            .out(WriteReg)
            );
    

    wire [31:0] ALU_B;
    mux_2_1 mux2_0(
        //inputs
        .sel(exEXE[3]),
        .in0(exreadData2),
        .in1(exsignEx),
        //outputs
        .out(ALU_B)
    );   

    wire [31:0] ShiftOut;
    lshift shift_left2_0(
        //inputs
        .ip(exsignEx),
        //outputs
        .op(ShiftOut)
    ); 

    wire [1:0] ALUCtl;
    ALUControl alu_control_0(
        //inputs
        .ALUOp(exEXE[2:1]),
        .Func(exsignEx[5:0]),
        //outputs
        .ALUCtl(ALUCtl)
    );

    ALU alu_0(
        //inputs
        .r1(exreadData1),
        .r2(ALU_B),
        .OP(ALUCtl),
        //outputs
        .result(ALUOut),
        .zero(Zero)
    ); 

    
    adder add_alu_0(
        //inputs
        .ip1(exPC),
        .ip2(ShiftOut),
        //outputs
        .out(Add_ALUOut)    
    );

    adder add_alu(
        //inputs
        .ip1(PCout),
        .ip2(1),
        //outputs
        .out(Add_PCOut)
    );

    wire PCSrc;
    AndGate and_gate_0(
        //inputs
        .Branch(memM[0]),
        .Zero(Zero),
        //outputs
        .AndGateOut(PCSrc)
    ); 

    mux_2_1 mux4_0(
        //inputs
        .in0(Add_PCOut),
        .in1(memPC),
        .sel(PCSrc),
        //outputs
        .out(PCin)
    ); 

    data_memory  data_memory_0(
        //inputs
        .addr(memAdd_ALU),
        .mem_write(memM[2]),
        .mem_read(memM[1]),
        .write_data(memreadData2),
        //outputs
        .read_data(ReadData)
    ); 

    mux_2_1 mu3_0(
        //inputs
        .in0(wbReadData),
        .in1(wbAdd_ALU),
        .sel(wbWB[1]),
        //outputs
        .out(WriteData_Reg)
    );

endmodule