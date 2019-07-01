module inst_mem
(  
    input   [31:0]  pc,  
    output reg [31:0]  instruction  
);  
    reg [31:0] rom[0:3];

    integer i;
    integer j;
    integer k;
    integer h;
        
    initial begin  
        //lw  $2,14($0)
        rom[0] = 8'b10001100;

        rom[1] = 8'b00000010;
    
        rom[2] = 8'b00000000;
    
        rom[3] = 8'b00001110;
        
        //beq $9,$9,2;
        rom[4] = 8'b01000001;
    
        rom[5] = 8'b00101001;
    
        rom[6] = 8'b00000000;
    
        rom[7] = 8'b00000010;

        //nop
        rom[8] = 8'b00000000;

        rom[9] = 8'b00000000;

        rom[10] = 8'b00000000;

        rom[11] = 8'b00000000;
        
        //add $6,$2,$3;
        rom[12] = 8'b00000000;
    
        rom[13] = 8'b01100010;
    
        rom[14] = 8'b00110000;
    
        rom[15] = 8'b00100000;
    
        //sub $7,$6,$8;
        rom[16] = 8'b00000000;
    
        rom[17] = 8'b11001000;
    
        rom[18] = 8'b00111000;
    
        rom[19] = 8'b00100010;
        
        //add $15,$8,$4;
        rom[20] = 8'b00000001;
        
        rom[21] = 8'b00000100;
        
        rom[22] = 8'b01111000;
        
        rom[23] = 8'b00100000;
        
    end  
    always @(pc)
    begin
        for(h = 0; h <= 7; h = h + 1)
            instruction[h] = rom[pc + 3][h];
        
        for(k = 8; k <= 15; k = k + 1)
            instruction[k] = rom[pc + 2][k - 8];

        for(j = 16; j <= 23; j = j + 1)
            instruction[j] = rom[pc + 1][j - 16];
            
        for(i = 24; i < 32; i = i + 1)
            instruction[i] = rom[pc][i - 24];
    end
endmodule