module control( input[5:0] opcode,  
                output reg[1:0] alu_op,  
                output reg reg_dst,mem_to_reg,branch,mem_read,mem_write,alu_src,reg_write                     
);  
always @(opcode)  
begin   
    case(opcode)   
        0: begin //R-type  
            reg_dst = 1;  
            alu_src = 0;  
            mem_to_reg = 0;  
            reg_write = 1;  
            mem_read = 0;  
            mem_write = 0;  
            branch = 0;  
            alu_op = 2;  
            end  
        35: begin //LW 
            reg_dst = 0;  
            alu_src = 1;  
            mem_to_reg = 1;  
            reg_write = 1;  
            mem_read = 1;  
            mem_write = 0;  
            branch = 0;  
            alu_op = 0;  
            end  
        43: begin //SW
            reg_dst = 0;  
            alu_src = 1;  
            mem_to_reg = 0;  
            reg_write = 0;  
            mem_read = 0;  
            mem_write = 1;  
            branch = 0;  
            alu_op = 0;  
            end  
        default: begin //BEq
            reg_dst = 0;  
            alu_src = 0;  
            mem_to_reg = 0;  
            reg_write = 0;  
            mem_read = 0;  
            mem_write = 0;  
            branch = 1;  
            alu_op = 1;  
            end  
    endcase   
end  
endmodule  