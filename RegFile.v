module RegFile(clock,RegWrite,rd_reg1,rd_reg2,wr_reg,wr_data,rd_data1,rd_data2);

    input RegWrite, clock;
    input  [4:0] rd_reg1;
    input  [4:0] rd_reg2;
    input  [4:0] wr_reg;
    input  [31:0] wr_data;
    output reg [31:0] rd_data1;
    output reg [31:0] rd_data2;

    reg  [31:0] registers [0:31];
    integer i;
    reg [31:0] a;
    initial
    begin
        a = 32'b0;
        for(i = 0; i < 32; i = i + 1)
        begin
            registers[i] = a;
            a = a + 1;
        end
    end

    always@(posedge clock) begin
        if((RegWrite==1'b1) && (wr_reg!=5'd0)) begin
            registers[wr_reg] = wr_data;
        end
    end

    always @(negedge clock) begin    
        rd_data1 = (rd_reg1==5'd0) ? 32'd0 : registers[rd_reg1];   
        rd_data2 = (rd_reg2==5'd0) ? 32'd0 : registers[rd_reg2];
    end

endmodule
