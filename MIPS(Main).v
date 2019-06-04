module MipsCPU(clock, reset); 
    
    input clock;
    input reset; 

    wire [31:0] WriteData_Reg;
    wire [4:0]  WriteReg;
    wire [31:0] Add_PCOut;

    wire [31:0] PCin, PCout;
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

    wire RegDst, RegWrite, ALUSrc, MemtoReg, MemRead, MemWrite, Branch; 
    wire [1:0] ALUOp;
    control main_control_0(
        //inputs
        .opcode(inst[31:26]),
        //outputs
        .reg_dst(RegDst), .reg_write(RegWrite),
        .alu_src(ALUSrc), .branch(Branch), .alu_op(ALUOp),
        .mem_to_reg(MemtoReg), .mem_read(MemRead), .mem_write(MemWrite)
    );

    //Mux InstMem - RegisterFile 
    mux_2_1 mux0(
            //input
            .in0(inst[20:16]),
            .in1(inst[15:11]),
            .sel(RegDst),
            //output
            .out(WriteReg)
            );
    
    wire [31:0] ReadData1, ReadData2; 
    ReqFile regfile_0(
        //inputs
        .rd_reg1(inst[25:21]), 
        .rd_reg2(inst[20:16]),
        .RegWrite(RegWrite),
        .wr_reg(WriteReg),
        .wr_data(WriteData_Reg), 
        //outputs
        .rd_data1(ReadData1),
        .rd_data2(ReadData2)
    ); 

    wire [31:0] Extend32; 
    signext sign_extend_0(
        //inputs
        .ip(inst[15:0]),
        //outputs
        .op(Extend32)
    );

    wire [31:0] ALU_B;
    mux_2_1 mux2_0(
        //inputs
        .sel(ALUSrc),
        .in0(ReadData2),
        .in1(Extend32),
        //outputs
        .out(ALU_B)
    );   

    wire [31:0] ShiftOut;
    lshift shift_left2_0(
        //inputs
        .ip(Extend32),
        //outputs
        .op(ShiftOut)
    ); 

    wire [1:0] ALUCtl;
    ALUControl alu_control_0(
        //inputs
        .ALUOp(ALUOp),
        .Func(inst[5:0]),
        //outputs
        .ALUCtl(ALUCtl)
    );

    wire Zero;
    wire [31:0] ALUOut;
    ALU alu_0(
        //inputs
        .r1(ReadData1),
        .r2(ALU_B),
        .OP(ALUCtl),
        //outputs
        .result(ALUOut),
        .zero(Zero)
    ); 

    wire [31:0] Add_ALUOut;
    adder add_alu_0(
        //inputs
        .ip1(Add_PCOut),
        .ip2(ShiftOut),
        //outputs
        .out(Add_ALUOut)
    );

    //wire [31:0] Add_PCOut;
    adder add_alu(
        //inputs
        .ip1(PCout),
        .ip2(1),
        //outputs
        .out(Add_PCOut)
    );

    wire AndGateOut;
    AndGate and_gate_0(
        //inputs
        .Branch(Branch),
        .Zero(Zero),
        //outputs
        .AndGateOut(AndGateOut)
    ); 

    mux_2_1 mux4_0(
        //inputs
        .in0(Add_PCOut),
        .in1(Add_ALUOut),
        .sel(AndGateOut),
        //outputs
        .out(PCin)
    ); 

    wire [31:0] ReadData;
    data_memory  data_memory_0(
        //inputs
        .addr(ALUOut),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .write_data(ReadData2),
        //outputs
        .read_data(ReadData)
    ); 

    mux_2_1 mu3_0(
        //inputs
        .in0(ALUOut),
        .in1(ReadData),
        .sel(MemtoReg),
        //outputs
        .out(WriteData_Reg)
    );

endmodule
