`include    "instruction_head.v"

module nPC (imm_16,imm_26,PC,nPCop,nPC,PC_add_4,GPR_rs);
    input [25:0]  imm_26 ;
    input [15:0]  imm_16 ;
    input [31:0]  PC;
    input  [1:0]  nPCop;    
    input  [31:0] GPR_rs;     
    output [31:0] nPC;                //output to IM
    output [31:0] PC_add_4;          //output to $31
                                     //zero and IFbeq are transmitted to Controller to effect nPCop
    
    assign PC_add_4 = PC+'h4;             // it's diffrent from single-cycle cpu
    
    assign nPC = (nPCop == 2'b00)?PC_add_4:
                 (nPCop == 2'b01)?{PC[31:28],imm_26,2'b00}://j
                 (nPCop == 2'b10&&GPR_rs>0)?(PC+{{14{imm_16[15]}},imm_16,2'b00}): //`DEBUG_DEV_DATA ;
                 (nPCop == 2'b10&&GPR_rs<=0)?(PC_add_4):
                 (nPCop == 2'b11)?(PC_add_4+{{14{imm_16[15]}},imm_16,2'b00}):`DEBUG_DEV_DATA ; //beq,rs = pc //???//
endmodule
    