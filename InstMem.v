module inst_mem
(  
     input   [31:0]  pc,  
     output reg [31:0]  instruction  
);  
     reg [31:0] rom[0:3];

     initial begin  
        rom[0]=32'b00001110000000000000001010001100; //lw  $2,14($0)
        rom[1]=32'b00000010000000000010100101000001; //beq $9,$9,2
        rom[2]=32'b00100000001100000110001000000000; //add $6,$2,$3
        rom[3]=32'b00100010001110001100001000000000; //sub $7,$6,$2
     end  
     always @(pc)
        instruction = rom[pc];
     //    instruction = rom[pc[31:2]];
endmodule