`timescale  1ns/1ns 
`include    "instruction_head.v"                     // 

module ALu( A, B, Ctrl, C, Zero,beqout );
    /*            IO ports          */
    input   [31:0]          A;                  // the 1st input data
    input   [31:0]          B;                  // the 2nd input data
    input   [2:0]           Ctrl;               // function code
    output  [31:0]          C;                  // calculation result 
    output                  Zero;   
    output beqout;            // 0 indicator

    /* internal registers and wires   */
    reg     [32:0]          tmp_arith ;         // result of arithmetic and logic operations
    
    //
    assign  C           = tmp_arith[31:0] ;
    assign  Zero        = (tmp_arith[31:0]==0) ? 1 : 0 ;
    assign  beqout      =  (tmp_arith[31:0]==0) ? 1 : 0 ;
    
    // Note: "default" clause must be used to prevent a latch be synthesized
    always  @( * )
        case (Ctrl)
            //`ALU_ADD      :   tmp_arith   <= {A[31], A} + {B[31], B} ;
          //  `ALU_SUB    :   tmp_arith   <= {A[31], A} - {B[31], B};//immediate need check
           // `ALU_LUI     :   tmp_arith <= {B[15:0],16'b0};//LUI
            3'b001      :   tmp_arith   <= {A[31], A} + {B[31], B} ;//add
            3'b010    :   tmp_arith   <= {A[31], A} - {B[31], B};//sub
           
           
            // more codes needed
            default     :   tmp_arith   <= B ;
        endcase
        
endmodule