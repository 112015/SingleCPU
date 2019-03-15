`timescale 1ns/1ns  
module testbench ( );
    reg clk;
    reg rst;
    
    
    mips my_mips (clk,rst);
    
    initial begin  
       $readmemh("code.txt",my_mips.U_IM.im);//
           rst= 1 ;
           clk = 0 ;
           #30 rst=0;      
          // all executed at 19000ns
    end
       
    always
       #20 clk = ~clk ;
       
endmodule
           