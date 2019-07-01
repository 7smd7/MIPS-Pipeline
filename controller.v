module control( input [31:0] inst, 
                output reg [1:0] wb,
                output reg [2:0] m,  
                output reg [3:0] exe                  
);  
// wb[0]=regwrite wb[1]=memtoreg
// m[0]=branch   m[1]=memtoread    m[2]=memtowrite
// exe[0]=regdst   exe[12]=aluop    exe[3]=alusrc
wire reg[5:0] opcode = inst[31:26];

always @(opcode)  
begin
    if(inst==0) begin //nop
        wb=0;
        m=0;   
        exe=0;
    end
    else begin
        case(opcode)   
            0: begin //R-type  
                wb=2;
                m=0;   
                exe=12;
                end 
            35: begin //LW 
                wb=3; 
                m=2;
                exe=1; 
                end 
            43: begin //SW
                wb=0;  
                m=1; 
                exe=1;  
                end   
            default: begin //BEq
                wb=0;              
                m=4;  
                exe=2;  
                end 
        endcase   
    end
end  
endmodule  