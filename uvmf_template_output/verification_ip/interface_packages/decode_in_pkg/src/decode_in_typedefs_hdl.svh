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
                                                                               

typedef enum bit [3:0] {BR=4'h0, ADD=4'h1, LD=4'h2, ST=4'h3, AND=4'h5, LDR=4'h6, STR=4'h7, NOT=4'h9, LDI=4'ha, STI=4'hb, JMP=4'hc, LEA=4'he} op_t;
typedef bit [2:0] dest_f;
typedef bit [2:0] src1_f;
typedef bit [2:0] src2_f;
typedef bit [2:0] baser_f;
typedef bit [8:0] pcoffset9_f;
typedef bit [5:0] pcoffset6_f;
typedef bit [4:0] imm5_f;
typedef bit n_f;
typedef bit z_f;
typedef bit p_f;

// pragma uvmf custom additional begin
// pragma uvmf custom additional end

