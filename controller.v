module control( input[5:0] opcode, 
                input reset; 
                output reg[3:0] alu_op,  
                output reg reg_dst,mem_to_reg,branch,mem_read,mem_write,alu_src,reg_write                     
);  
// wb[0]=regwrite wb[1]=memtoreg
// m[0]=branch   m[1]=memtoread    m[2]=memtowrite
// exe[0]=regdst   exe[1]=aluop    exe[2]=alusrc
always @(opcode)  
begin   
    case(opcode)   
        0: begin //R-type  
            wb=2 
            m=0;   
            exe=12
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
            begin //BEq
            wb=0;              
            m=4;  
            exe=2;  
            end 
    endcase   
end  
endmodule  