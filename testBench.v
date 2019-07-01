module tb_mips;  
    // Inputs  
    reg clock;  
    reg reset;  
    // Outputs  

    MipsCPU pipeline (  
        .clock(clock),   
        .reset(reset)
    );  
    initial
    begin
        clock = 1;
        reset = 1;
        #15;
        reset = 0;
        forever #15 clock =~clock;
    end
endmodule  