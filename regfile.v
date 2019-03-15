`timescale 1ns/1ns

/* 
    This module 
 */
module RegFile( CLK_I, RS1_I, RS2_I, RD_I, RegWr_I,WData_I,RS1_O, RS2_O);
    input               CLK_I;          // system clock
    input [4:0]         RS1_I;          // the index of the 1st register
    input [4:0]         RS2_I;          // the index of the 2nd register
    input [4:0]         RD_I;           // the index of the target register to be writen
    input               RegWr_I;        // write enable
    input [31:0]        WData_I;        // the data to be writen into the register
    
    output [31:0]       RS1_O;          // 1st register's content 
    output [31:0]       RS2_O;          // 2nd register's content

    /* internal registers and wires */
    reg    [31:0]       gpr[31:1] ;     // ????????[**&& COCOA &&**] why we only define 31 general purpose registers?
   // integer             j, m, n ;       // used to address regitsers

    /* read from register file */
   // assign gpr[0] = 32'b00000000000000000000000000000000;
    assign RS1_O = (RS1_I==0)?32'b00000000000000000000000000000000:gpr[RS1_I];
    assign RS2_O = (RS2_I==0)?32'b00000000000000000000000000000000:gpr[RS2_I];
 //   assign toPC = register[A1];   // redundant singal
    
    // [**&& COCOA &&**] more codes needed
    
    // generate register indexs
   // always  @( * )
      //  j <= RD_I ;
        // [**&& COCOA &&**] more codes needed

    // write to register file
    always @( posedge CLK_I ) 
        if ( RegWr_I )
            begin
                gpr[RD_I] <= WData_I ;
                `ifdef DEBUG
                    $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", 0, gpr[1], gpr[2], gpr[3], gpr[4], gpr[5], gpr[6], gpr[7]);
                    // [**&& COCOA &&**] more codes needed
                `endif
            end
    
endmodule