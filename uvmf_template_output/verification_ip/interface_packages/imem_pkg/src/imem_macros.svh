//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the imem package.
//   These macros include packed struct definitions.  These structs are
//   used to pass data between classes, hvl, and BFM's, hdl.  Use of 
//   structs are more efficient and simpler to modify.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_struct
//      and from_struct methods defined in the macros below that are used in  
//      the imem_configuration class.
//
  `define imem_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } imem_configuration_s;

  `define imem_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function imem_configuration_s to_struct();\
    imem_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( imem_configuration_struct );\
  endfunction

  `define imem_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(imem_configuration_s imem_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = imem_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the imem_transaction class.
//
  `define imem_MONITOR_STRUCT typedef struct packed  { \
  bit [15:0] PC ; \
  bit instrmem_rd ; \
  bit [15:0] Instr_dout ; \
  bit complete_instr ; \
  op_type operation_type ; \
  inst_type instruction_type ; \
  bit [15:0] npc ; \
  bit [3:0] instr_opcode ; \
  bit [2:0] dest_reg ; \
  bit [2:0] src_reg1 ; \
  bit [2:0] src_reg2 ; \
  bit [5:0] imm5 ; \
  bit [2:0] mem_dest_reg ; \
  bit [2:0] mem_src_reg ; \
  bit [8:0] pcoffset9 ; \
  int signed_pcoffset9 ; \
  bit [2:0] baser ; \
  bit [5:0] pcoffset6 ; \
  NZP control_nzp ; \
  bit [8:0] control_pcoffset9 ; \
  bit [2:0] control_baser ; \
     } imem_monitor_s;

  `define imem_TO_MONITOR_STRUCT_FUNCTION \
  virtual function imem_monitor_s to_monitor_struct();\
    imem_monitor_struct = \
            { \
            this.PC , \
            this.instrmem_rd , \
            this.Instr_dout , \
            this.complete_instr , \
            this.operation_type , \
            this.instruction_type , \
            this.npc , \
            this.instr_opcode , \
            this.dest_reg , \
            this.src_reg1 , \
            this.src_reg2 , \
            this.imm5 , \
            this.mem_dest_reg , \
            this.mem_src_reg , \
            this.pcoffset9 , \
            this.signed_pcoffset9 , \
            this.baser , \
            this.pcoffset6 , \
            this.control_nzp , \
            this.control_pcoffset9 , \
            this.control_baser  \
            };\
    return ( imem_monitor_struct);\
  endfunction\

  `define imem_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(imem_monitor_s imem_monitor_struct);\
            {\
            this.PC , \
            this.instrmem_rd , \
            this.Instr_dout , \
            this.complete_instr , \
            this.operation_type , \
            this.instruction_type , \
            this.npc , \
            this.instr_opcode , \
            this.dest_reg , \
            this.src_reg1 , \
            this.src_reg2 , \
            this.imm5 , \
            this.mem_dest_reg , \
            this.mem_src_reg , \
            this.pcoffset9 , \
            this.signed_pcoffset9 , \
            this.baser , \
            this.pcoffset6 , \
            this.control_nzp , \
            this.control_pcoffset9 , \
            this.control_baser  \
            } = imem_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the imem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define imem_INITIATOR_STRUCT typedef struct packed  { \
  bit [15:0] PC ; \
  bit instrmem_rd ; \
  bit [15:0] Instr_dout ; \
  bit complete_instr ; \
  op_type operation_type ; \
  inst_type instruction_type ; \
  bit [15:0] npc ; \
  bit [3:0] instr_opcode ; \
  bit [2:0] dest_reg ; \
  bit [2:0] src_reg1 ; \
  bit [2:0] src_reg2 ; \
  bit [5:0] imm5 ; \
  bit [2:0] mem_dest_reg ; \
  bit [2:0] mem_src_reg ; \
  bit [8:0] pcoffset9 ; \
  int signed_pcoffset9 ; \
  bit [2:0] baser ; \
  bit [5:0] pcoffset6 ; \
  NZP control_nzp ; \
  bit [8:0] control_pcoffset9 ; \
  bit [2:0] control_baser ; \
     } imem_initiator_s;

  `define imem_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function imem_initiator_s to_initiator_struct();\
    imem_initiator_struct = \
           {\
           this.PC , \
           this.instrmem_rd , \
           this.Instr_dout , \
           this.complete_instr , \
           this.operation_type , \
           this.instruction_type , \
           this.npc , \
           this.instr_opcode , \
           this.dest_reg , \
           this.src_reg1 , \
           this.src_reg2 , \
           this.imm5 , \
           this.mem_dest_reg , \
           this.mem_src_reg , \
           this.pcoffset9 , \
           this.signed_pcoffset9 , \
           this.baser , \
           this.pcoffset6 , \
           this.control_nzp , \
           this.control_pcoffset9 , \
           this.control_baser  \
           };\
    return ( imem_initiator_struct);\
  endfunction

  `define imem_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(imem_initiator_s imem_initiator_struct);\
           {\
           this.PC , \
           this.instrmem_rd , \
           this.Instr_dout , \
           this.complete_instr , \
           this.operation_type , \
           this.instruction_type , \
           this.npc , \
           this.instr_opcode , \
           this.dest_reg , \
           this.src_reg1 , \
           this.src_reg2 , \
           this.imm5 , \
           this.mem_dest_reg , \
           this.mem_src_reg , \
           this.pcoffset9 , \
           this.signed_pcoffset9 , \
           this.baser , \
           this.pcoffset6 , \
           this.control_nzp , \
           this.control_pcoffset9 , \
           this.control_baser  \
           } = imem_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the imem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define imem_RESPONDER_STRUCT typedef struct packed  { \
  bit [15:0] PC ; \
  bit instrmem_rd ; \
  bit [15:0] Instr_dout ; \
  bit complete_instr ; \
  op_type operation_type ; \
  inst_type instruction_type ; \
  bit [15:0] npc ; \
  bit [3:0] instr_opcode ; \
  bit [2:0] dest_reg ; \
  bit [2:0] src_reg1 ; \
  bit [2:0] src_reg2 ; \
  bit [5:0] imm5 ; \
  bit [2:0] mem_dest_reg ; \
  bit [2:0] mem_src_reg ; \
  bit [8:0] pcoffset9 ; \
  int signed_pcoffset9 ; \
  bit [2:0] baser ; \
  bit [5:0] pcoffset6 ; \
  NZP control_nzp ; \
  bit [8:0] control_pcoffset9 ; \
  bit [2:0] control_baser ; \
     } imem_responder_s;

  `define imem_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function imem_responder_s to_responder_struct();\
    imem_responder_struct = \
           {\
           this.PC , \
           this.instrmem_rd , \
           this.Instr_dout , \
           this.complete_instr , \
           this.operation_type , \
           this.instruction_type , \
           this.npc , \
           this.instr_opcode , \
           this.dest_reg , \
           this.src_reg1 , \
           this.src_reg2 , \
           this.imm5 , \
           this.mem_dest_reg , \
           this.mem_src_reg , \
           this.pcoffset9 , \
           this.signed_pcoffset9 , \
           this.baser , \
           this.pcoffset6 , \
           this.control_nzp , \
           this.control_pcoffset9 , \
           this.control_baser  \
           };\
    return ( imem_responder_struct);\
  endfunction

  `define imem_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(imem_responder_s imem_responder_struct);\
           {\
           this.PC , \
           this.instrmem_rd , \
           this.Instr_dout , \
           this.complete_instr , \
           this.operation_type , \
           this.instruction_type , \
           this.npc , \
           this.instr_opcode , \
           this.dest_reg , \
           this.src_reg1 , \
           this.src_reg2 , \
           this.imm5 , \
           this.mem_dest_reg , \
           this.mem_src_reg , \
           this.pcoffset9 , \
           this.signed_pcoffset9 , \
           this.baser , \
           this.pcoffset6 , \
           this.control_nzp , \
           this.control_pcoffset9 , \
           this.control_baser  \
           } = imem_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
