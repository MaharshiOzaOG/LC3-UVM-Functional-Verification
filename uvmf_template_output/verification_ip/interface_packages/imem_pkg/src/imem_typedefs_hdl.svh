//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains defines and typedefs to be compiled for use in
// the simulation running on the emulator when using Veloce.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
                                                                               

typedef enum bit [1:0] {ALU_OPERATIONS,MEMORY_OPERATIONS,CONTROL_OPERATIONS} op_type;
typedef enum bit [3:0] {ADD,ADDI,AND,ANDI,NOT,LD,LDR,LDI,LEA,ST,STR,STI,BR,JMP} inst_type;
typedef enum bit [2:0] {BRP=3'b001,BRZ,BRZP,BRN,BRNP,BRNZ,BRNZP} NZP;
typedef enum bit [2:0] {R0,R1,R2,R3,R4,R5,R6,R7} src_dst_reg;

// pragma uvmf custom additional begin
// pragma uvmf custom additional end

