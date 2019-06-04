module data_memory  
(    
     input  [31:0]  addr,   
     input  [31:0]  write_data,  
     input          mem_write,  
     input          mem_read,  
     output [31:0]  read_data  
);  
     
     integer i;
     reg [31:0] a;
     reg [31:0] ram [0:15];  
     initial begin  
          a=5;
          for(i=0;i<16;i=i+1) begin
               ram[i] <= a;  
               a=a+5;
          end
     end  

     always @(addr,write_data,mem_write,mem_read) begin  
          if (mem_write)  
               ram[addr] = write_data;
     end 
     assign read_data = (mem_read==1'b1) ? ram[addr]: 32'd0;
endmodule   