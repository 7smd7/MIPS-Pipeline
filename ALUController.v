module ALUControl( ALUCtl, ALUOp, Func);  
    output reg[1:0] ALUCtl;  
    input [1:0] ALUOp;
    input [5:0] Func;
 
    always @(ALUOp, Func) begin  
        if(ALUOp == 0)
           ALUCtl <= 0;    //LW and SW use add
        else if(ALUOp == 1)
           ALUCtl <= 3;   // branch use subtract
        else
            case(Func)
                32: ALUCtl <= 0; //add
                36: ALUCtl <= 1; //and
                37: ALUCtl <= 2; //or
                34: ALUCtl <= 3; //sub
                default: ALUCtl <=0;
            endcase
    end 
endmodule

/*
    00 add
    01 and
    10 or
    11 sub
*/