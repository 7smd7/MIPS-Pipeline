module Beq (reg1, reg2, out);
    input [32:0] reg1;
    input [32:0] reg2;
    output reg out;

    always @ (*) 
        out = (reg1==reg2);
endmodule
