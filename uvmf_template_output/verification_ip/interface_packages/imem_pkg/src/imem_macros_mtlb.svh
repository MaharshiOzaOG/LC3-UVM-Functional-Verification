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
  bit [15:0] _PC ; \
  bit _instrmem_rd ; \
  bit [15:0] _Instr_dout ; \
  bit _complete_instr ; \
  op_type _operation_type ; \
  inst_type _instruction_type ; \
  bit [15:0] _npc ; \
  bit [3:0] _instr_opcode ; \
  bit [2:0] _dest_reg ; \
  bit [2:0] _src_reg1 ; \
  bit [2:0] _src_reg2 ; \
  bit [5:0] _imm5 ; \
  bit [2:0] _mem_dest_reg ; \
  bit [2:0] _mem_src_reg ; \
  bit [8:0] _pcoffset9 ; \
  int _signed_pcoffset9 ; \
  bit [2:0] _baser ; \
  bit [5:0] _pcoffset6 ; \
  NZP _control_nzp ; \
  bit [8:0] _control_pcoffset9 ; \
  bit [2:0] _control_baser ; \
     } imem_monitor_s;

  `define imem_TO_MONITOR_STRUCT_FUNCTION \
  virtual function imem_monitor_s to_monitor_struct();\
    imem_monitor_struct = \
            { \
            this._PC , \
            this._instrmem_rd , \
            this._Instr_dout , \
            this._complete_instr , \
            this._operation_type , \
            this._instruction_type , \
            this._npc , \
            this._instr_opcode , \
            this._dest_reg , \
            this._src_reg1 , \
            this._src_reg2 , \
            this._imm5 , \
            this._mem_dest_reg , \
            this._mem_src_reg , \
            this._pcoffset9 , \
            this._signed_pcoffset9 , \
            this._baser , \
            this._pcoffset6 , \
            this._control_nzp , \
            this._control_pcoffset9 , \
            this._control_baser  \
            };\
    return ( imem_monitor_struct);\
  endfunction\

  `define imem_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(imem_monitor_s imem_monitor_struct);\
            {\
            this._PC , \
            this._instrmem_rd , \
            this._Instr_dout , \
            this._complete_instr , \
            this._operation_type , \
            this._instruction_type , \
            this._npc , \
            this._instr_opcode , \
            this._dest_reg , \
            this._src_reg1 , \
            this._src_reg2 , \
            this._imm5 , \
            this._mem_dest_reg , \
            this._mem_src_reg , \
            this._pcoffset9 , \
            this._signed_pcoffset9 , \
            this._baser , \
            this._pcoffset6 , \
            this._control_nzp , \
            this._control_pcoffset9 , \
            this._control_baser  \
            } = imem_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the imem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define imem_INITIATOR_STRUCT typedef struct packed  { \
  bit [15:0] _PC ; \
  bit _instrmem_rd ; \
  bit [15:0] _Instr_dout ; \
  bit _complete_instr ; \
  op_type _operation_type ; \
  inst_type _instruction_type ; \
  bit [15:0] _npc ; \
  bit [3:0] _instr_opcode ; \
  bit [2:0] _dest_reg ; \
  bit [2:0] _src_reg1 ; \
  bit [2:0] _src_reg2 ; \
  bit [5:0] _imm5 ; \
  bit [2:0] _mem_dest_reg ; \
  bit [2:0] _mem_src_reg ; \
  bit [8:0] _pcoffset9 ; \
  int _signed_pcoffset9 ; \
  bit [2:0] _baser ; \
  bit [5:0] _pcoffset6 ; \
  NZP _control_nzp ; \
  bit [8:0] _control_pcoffset9 ; \
  bit [2:0] _control_baser ; \
     } imem_initiator_s;

  `define imem_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function imem_initiator_s to_initiator_struct();\
    imem_initiator_struct = \
           {\
           this._PC , \
           this._instrmem_rd , \
           this._Instr_dout , \
           this._complete_instr , \
           this._operation_type , \
           this._instruction_type , \
           this._npc , \
           this._instr_opcode , \
           this._dest_reg , \
           this._src_reg1 , \
           this._src_reg2 , \
           this._imm5 , \
           this._mem_dest_reg , \
           this._mem_src_reg , \
           this._pcoffset9 , \
           this._signed_pcoffset9 , \
           this._baser , \
           this._pcoffset6 , \
           this._control_nzp , \
           this._control_pcoffset9 , \
           this._control_baser  \
           };\
    return ( imem_initiator_struct);\
  endfunction

  `define imem_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(imem_initiator_s imem_initiator_struct);\
           {\
           this._PC , \
           this._instrmem_rd , \
           this._Instr_dout , \
           this._complete_instr , \
           this._operation_type , \
           this._instruction_type , \
           this._npc , \
           this._instr_opcode , \
           this._dest_reg , \
           this._src_reg1 , \
           this._src_reg2 , \
           this._imm5 , \
           this._mem_dest_reg , \
           this._mem_src_reg , \
           this._pcoffset9 , \
           this._signed_pcoffset9 , \
           this._baser , \
           this._pcoffset6 , \
           this._control_nzp , \
           this._control_pcoffset9 , \
           this._control_baser  \
           } = imem_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the imem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define imem_RESPONDER_STRUCT typedef struct packed  { \
  bit [15:0] _PC ; \
  bit _instrmem_rd ; \
  bit [15:0] _Instr_dout ; \
  bit _complete_instr ; \
  op_type _operation_type ; \
  inst_type _instruction_type ; \
  bit [15:0] _npc ; \
  bit [3:0] _instr_opcode ; \
  bit [2:0] _dest_reg ; \
  bit [2:0] _src_reg1 ; \
  bit [2:0] _src_reg2 ; \
  bit [5:0] _imm5 ; \
  bit [2:0] _mem_dest_reg ; \
  bit [2:0] _mem_src_reg ; \
  bit [8:0] _pcoffset9 ; \
  int _signed_pcoffset9 ; \
  bit [2:0] _baser ; \
  bit [5:0] _pcoffset6 ; \
  NZP _control_nzp ; \
  bit [8:0] _control_pcoffset9 ; \
  bit [2:0] _control_baser ; \
     } imem_responder_s;

  `define imem_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function imem_responder_s to_responder_struct();\
    imem_responder_struct = \
           {\
           this._PC , \
           this._instrmem_rd , \
           this._Instr_dout , \
           this._complete_instr , \
           this._operation_type , \
           this._instruction_type , \
           this._npc , \
           this._instr_opcode , \
           this._dest_reg , \
           this._src_reg1 , \
           this._src_reg2 , \
           this._imm5 , \
           this._mem_dest_reg , \
           this._mem_src_reg , \
           this._pcoffset9 , \
           this._signed_pcoffset9 , \
           this._baser , \
           this._pcoffset6 , \
           this._control_nzp , \
           this._control_pcoffset9 , \
           this._control_baser  \
           };\
    return ( imem_responder_struct);\
  endfunction

  `define imem_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(imem_responder_s imem_responder_struct);\
           {\
           this._PC , \
           this._instrmem_rd , \
           this._Instr_dout , \
           this._complete_instr , \
           this._operation_type , \
           this._instruction_type , \
           this._npc , \
           this._instr_opcode , \
           this._dest_reg , \
           this._src_reg1 , \
           this._src_reg2 , \
           this._imm5 , \
           this._mem_dest_reg , \
           this._mem_src_reg , \
           this._pcoffset9 , \
           this._signed_pcoffset9 , \
           this._baser , \
           this._pcoffset6 , \
           this._control_nzp , \
           this._control_pcoffset9 , \
           this._control_baser  \
           } = imem_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
