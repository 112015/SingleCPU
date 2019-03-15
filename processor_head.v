//////////////////////////////////////////////////////////////////////////////////
// This is part of COCOA project, which covers the 5 basic disciplines in computer
// science: digital logic, computer organization, compiler, computer architecture, 
// and operating system.
//
// Copy right belongs to SCSE of BUAA, 2011
// Author:          Gao Xiaopeng
// Design Name: 	MIPS-C processor head file
// Module Name:     MIPS-C processor head file
// Description:     This module is the head file of MIPS-C processor core where
//                  exception, CP0, ALU operations, etc.
//////////////////////////////////////////////////////////////////////////////////

/*---------- debug version switch-------------*/
`define SIMULATION

////simulation macro
`define DELAY(x) `ifdef SIMULATION #(x); `endif

/* exception types and their vectors */
//`define EXC_REBOOT          2'b00               // reset, NMI
//`define EXC_TLB             2'b01               // TLB miss
//`define EXC_HWINT           2'b10               // hardware interrupts
//`define EXC_NORMAL          2'b10               // other exceptions

`define VECTOR_REBOOT       32'hBFC00000        // reset, NMI
`define VECTOR_TLB_BEV_0    32'h80000000        // BEV=0 : TLB               
`define VECTOR_INT_BEV_0    32'h80000200        // BEV=0 : hardware interrupt
`define VECTOR_EXC_BEV_0    32'h80000180        // BEV=0 : other exceptions  
`define VECTOR_TLB_BEV_1    32'hBFC00200        // BEV=1 : TLB
`define VECTOR_INT_BEV_1    32'hBFC00400        // BEV=1 : hardware interrupt
`define VECTOR_EXC_BEV_1    32'hBFC00380        // BEV=1 : other exceptions

/*--------------------------- ExcCode --------------------------------------
  --------------------------------------------------------------------------*/
`define EXCCODE_INT         5'd0        // interrupt
`define EXCCODE_SC          5'd8        // system call
`define EXCCODE_BP          5'd9        // break instruction
`define EXCCODE_RI          5'd10       // undefined instruction
`define EXCCODE_RSV         5'd31       // reserved

/*--------------------------- Register Offsets Declaration -------------------
  Note: All registers of devices are aligned on 32-bit boundaries. As a result, 
        A[1:0](the lowest 2bits of address bus) are ignored
  --------------------------------------------------------------------------*/
/* Interrupt Controller Register Offset in 32bit address bound */
`define OFF_INTC_IRR        'h0     // IRR : interrupt requirement register
`define OFF_INTC_IMR        'h1     // IMR : interrupt mask register
`define OFF_INTC_ISR        'h2     // ISR : interrupt service register
`define OFF_INTC_ISO        'h3     // ISO : interrupt service over register


/* 
 * Timer/Counter Register offset in 32bit address bound 
 * offsets of 9 register 
 */
 `define TC0_CTRL   'h0
 `define TC0_PRESET 'h1
 `define TC0_COUNT  'h2
 `define TC1_CTRL   'h3
 `define TC1_PRESET 'h4
 `define TC1_COUNT  'h5
 `define TC2_CTRL   'h6
 `define TC2_PRESET 'h7
 `define TC2_COUNT  'h8

/*
 * macros for the multiplier
 */
`define MUL_MUL	'b0
`define MUL_DIV	'b1

`define MUL_SEL_HIGH	'b1
`define MUL_SEL_LOW	'b0

/*
 * CP0 processor's register offsets
 */
`define CP0_SR	        12
`define CP0_CAUSE       13
`define CP0_EPC         14
`define CP0_PRID	    15

///*
// *	control signal of the Multiplicant and division
// */
// `define ALU_HI     'h1
// `define ALU_MUX    'h0
// `define ALU_DIV    'h8
// `define ALU_SLL    'h1
// `define ALU_SLR    'h2
// `define ALU_SRA    'h3

/*
 *	instructions index in decoding module
 */

/////I-type
//`define INS_LUI	10'b00000_00001
//`define INS_ADDUI	10'b00000_00010
//`define INS_ADDI	10'b00000_00011
//`define INS_ANDI	10'b00000_00100
//`define INS_ORI	10'b00000_00101
//`define INS_XORI	10'b00000_00110
//`define INS_SLTIU	10'b00000_00111
//`define INS_SLTI	10'b00000_01000
//////load and save
//`define INS_LB	10'b00000_01001
//`define INS_LBU	10'b00000_01010
//`define INS_LH	10'b00000_01011
//`define INS_LHU	10'b00000_01100
//`define INS_LW	10'b00000_01101
//`define INS_SB	10'b00000_01110
//`define INS_SH	10'b00000_01111
//`define INS_SW	10'b00000_10001
//////branch
//`define INS_BEQ	10'b00000_10010
//`define INS_BGEZ	10'b00000_10011
//`define INS_BGEZAL	10'b00000_10100
//`define INS_BGTZ	10'b00000_10101
//`define INS_BLEZ	10'b00000_10110
//`define INS_BLTZAL	10'b00000_10111
//`define INS_BLTZ	10'b00000_11000
//`define INS_BNE	10'b00000_11001
//////R-type
//`define INS_ADDU	10'b00000_11010
//`define INS_ADD	10'b00000_11011
//`define INS_SUBU	10'b00000_11100
//`define INS_SUB	10'b00000_11101
//`define INS_AND	10'b00000_11110
//`define INS_NOR	10'b00000_11111
//`define INS_OR	10'b00001_00000
//`define INS_XOR	10'b00001_00001
//`define INS_SLTU	10'b00001_00010
//`define INS_SLT	10'b00001_00011
//`define INS_DIV	10'b00001_00100
//`define INS_DIVU	10'b00001_00101
//`define INS_SLL	10'b00001_00110
//`define INS_SLLV	10'b00001_00111
//`define INS_SRA	10'b00001_01000
//`define INS_SRAV	10'b00001_01001
//`define INS_SRL	10'b00001_01010
//`define INS_SRLV	10'b00001_01011
//`define INS_MULT	10'b00001_01100
//`define INS_MULTU	10'b00001_01101
//`define INS_MFHI	10'b00001_01110
//`define INS_MFLO	10'b00001_01111
//`define INS_MTHI	10'b00001_10000
//`define INS_MTLO	10'b00001_10001
//////CP0 type
//`define INS_MFC0	10'b00001_10010
//`define INS_MTC0	10'b00001_10011
//`define INS_ERET	10'b00001_10100
//////jump 
//`define INS_J		10'b00001_10101
//`define INS_JAL	10'b00001_10110
//`define INS_JALR	10'b00001_10111
//`define INS_JR	10'b00001_11000
//////exception
//`define INS_BREAK	10'b00001_11001
//`define INS_SYSCALL	10'b00001_11010
//////nop
//`define INS_NOP	10'b00001_11011

/**	byte enable for the memory bus
 */
`define WORD			4'b1111
`define HALF_WORD			4'b0011
`define BYTE			4'b0001

/*
 *	ALU function code
    GXP    
 */
`define ALU_NOP         5'b00000    // pass through (C <- B)
`define ALU_ADDU        5'b00001    // add : unsigned
`define ALU_ADD         5'b00010    // add
`define ALU_SUBU		5'b00011    // sub : unsigned
`define	ALU_SUB         5'b00100    // sub
`define	ALU_AND			5'b00101    // and
`define	ALU_OR			5'b00110    // or
`define	ALU_NOR			5'b00111    // nor
`define	ALU_XOR			5'b01000    // xor
`define	ALU_SLTU		5'b01001    // set : when A is smaller than B(unsigned)
`define	ALU_SLT         5'b01010    // set : when A is smaller than B
`define ALU_LTZ         5'b01101    // cmp : A less than 0
`define	ALU_LEZ			5'b01100    // cmp : A less than or equal to 0
`define	ALU_GTZ			5'b01011    // cmp : A greater than 0
`define	ALU_GEZ			5'b01110    // cmp : A greater than or equal to 0
`define	ALU_EQ			5'b01111    // cmp : A equal to B
`define	ALU_NEQ			5'b10000    // cmp : A not equal to B
`define ALU_SLL         5'b10001    // shift left logical
`define ALU_SRL         5'b10010    // shift right logical
`define ALU_SRA         5'b10011    // shift right arithmetic

/*
    Sign extend
    GXP
 */
`define EXT_ZERO        2'b00
`define EXT_SIGN        2'b01       // sign extend 
`define EXT_SL16        2'b10       // shift left 16-bit

/*
 */
`define EXT_M_NOP       2'b00       // don't extend
`define EXT_M_8BIT      2'b01       // keep lower 8bit, higher 24bits are zero
`define EXT_M_16BIT     2'b10       // keep lower 16bit, higher 16bits are zero