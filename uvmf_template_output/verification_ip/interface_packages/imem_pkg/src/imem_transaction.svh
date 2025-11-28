//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an imem
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( imem_transaction )

  bit [15:0] PC ;
  bit instrmem_rd ;
  rand bit [15:0] Instr_dout ;
  rand bit complete_instr ;
  rand op_type operation_type ;
  rand inst_type instruction_type ;
  bit [15:0] npc ;
  rand bit [3:0] instr_opcode ;
  rand bit [2:0] dest_reg ;
  rand bit [2:0] src_reg1 ;
  rand bit [2:0] src_reg2 ;
  rand bit [5:0] imm5 ;
  rand bit [2:0] mem_dest_reg ;
  rand bit [2:0] mem_src_reg ;
  rand bit [8:0] pcoffset9 ;
  int signed_pcoffset9 ;
  rand bit [2:0] baser ;
  rand bit [5:0] pcoffset6 ;
  rand NZP control_nzp ;
  rand bit [8:0] control_pcoffset9 ;
  rand bit [2:0] control_baser ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in imem_macros.svh

  //*******************************************************************
  // Monitor macro used by imem_monitor and imem_monitor_bfm
  // This struct is defined in imem_macros.svh
  `imem_MONITOR_STRUCT
    imem_monitor_s imem_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a imem_monitor_s
  // structure.  The function returns the handle to the imem_monitor_struct.
  // This function is defined in imem_macros.svh
  `imem_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in imem_macros.svh
  `imem_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by imem_driver and imem_driver_bfm
  // to communicate initiator driven data to imem_driver_bfm.
  // This struct is defined in imem_macros.svh
  `imem_INITIATOR_STRUCT
    imem_initiator_s imem_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a imem_initiator_s
  // structure.  The function returns the handle to the imem_initiator_struct.
  // This function is defined in imem_macros.svh
  `imem_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in imem_macros.svh
  `imem_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by imem_driver and imem_driver_bfm
  // to communicate Responder driven data to imem_driver_bfm.
  // This struct is defined in imem_macros.svh
  `imem_RESPONDER_STRUCT
    imem_responder_s imem_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a imem_responder_s
  // structure.  The function returns the handle to the imem_responder_struct.
  // This function is defined in imem_macros.svh
  `imem_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in imem_macros.svh
  `imem_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("PC:0x%x instrmem_rd:0x%x Instr_dout:0x%x complete_instr:0x%x operation_type:0x%x instruction_type:0x%x npc:0x%x instr_opcode:0x%x dest_reg:0x%x src_reg1:0x%x src_reg2:0x%x imm5:0x%x mem_dest_reg:0x%x mem_src_reg:0x%x pcoffset9:0x%x signed_pcoffset9:0x%x baser:0x%x pcoffset6:0x%x control_nzp:0x%x control_pcoffset9:0x%x control_baser:0x%x ",PC,instrmem_rd,Instr_dout,complete_instr,operation_type,instruction_type,npc,instr_opcode,dest_reg,src_reg1,src_reg2,imm5,mem_dest_reg,mem_src_reg,pcoffset9,signed_pcoffset9,baser,pcoffset6,control_nzp,control_pcoffset9,control_baser);
    // pragma uvmf custom convert2string end
  endfunction

  //*******************************************************************
  // FUNCTION: do_print()
  // This function is automatically called when the .print() function
  // is called on this class.
  //
  virtual function void do_print(uvm_printer printer);
    // pragma uvmf custom do_print begin
    // UVMF_CHANGE_ME : Current contents of do_print allows for the use of UVM 1.1d, 1.2 or P1800.2.
    // Update based on your own printing preference according to your preferred UVM version
    $display(convert2string());
    // pragma uvmf custom do_print end
  endfunction

  //*******************************************************************
  // FUNCTION: do_compare()
  // This function is automatically called when the .compare() function
  // is called on this class.
  //
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    imem_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    imem_transaction  RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.PC = RHS.PC;
    this.instrmem_rd = RHS.instrmem_rd;
    this.Instr_dout = RHS.Instr_dout;
    this.complete_instr = RHS.complete_instr;
    this.operation_type = RHS.operation_type;
    this.instruction_type = RHS.instruction_type;
    this.npc = RHS.npc;
    this.instr_opcode = RHS.instr_opcode;
    this.dest_reg = RHS.dest_reg;
    this.src_reg1 = RHS.src_reg1;
    this.src_reg2 = RHS.src_reg2;
    this.imm5 = RHS.imm5;
    this.mem_dest_reg = RHS.mem_dest_reg;
    this.mem_src_reg = RHS.mem_src_reg;
    this.pcoffset9 = RHS.pcoffset9;
    this.signed_pcoffset9 = RHS.signed_pcoffset9;
    this.baser = RHS.baser;
    this.pcoffset6 = RHS.pcoffset6;
    this.control_nzp = RHS.control_nzp;
    this.control_pcoffset9 = RHS.control_pcoffset9;
    this.control_baser = RHS.control_baser;
    // pragma uvmf custom do_copy end
  endfunction

  // ****************************************************************************
  // FUNCTION: add_to_wave()
  // This function is used to display variables in this class in the waveform 
  // viewer.  The start_time and end_time variables must be set before this 
  // function is called.  If the start_time and end_time variables are not set
  // the transaction will be hidden at 0ns on the waveform display.
  // 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    `ifdef QUESTA
    if (transaction_view_h == 0) begin
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"imem_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,PC,"PC");
    $add_attribute(transaction_view_h,instrmem_rd,"instrmem_rd");
    $add_attribute(transaction_view_h,Instr_dout,"Instr_dout");
    $add_attribute(transaction_view_h,complete_instr,"complete_instr");
    $add_attribute(transaction_view_h,operation_type,"operation_type");
    $add_attribute(transaction_view_h,instruction_type,"instruction_type");
    $add_attribute(transaction_view_h,npc,"npc");
    $add_attribute(transaction_view_h,instr_opcode,"instr_opcode");
    $add_attribute(transaction_view_h,dest_reg,"dest_reg");
    $add_attribute(transaction_view_h,src_reg1,"src_reg1");
    $add_attribute(transaction_view_h,src_reg2,"src_reg2");
    $add_attribute(transaction_view_h,imm5,"imm5");
    $add_attribute(transaction_view_h,mem_dest_reg,"mem_dest_reg");
    $add_attribute(transaction_view_h,mem_src_reg,"mem_src_reg");
    $add_attribute(transaction_view_h,pcoffset9,"pcoffset9");
    $add_attribute(transaction_view_h,signed_pcoffset9,"signed_pcoffset9");
    $add_attribute(transaction_view_h,baser,"baser");
    $add_attribute(transaction_view_h,pcoffset6,"pcoffset6");
    $add_attribute(transaction_view_h,control_nzp,"control_nzp");
    $add_attribute(transaction_view_h,control_pcoffset9,"control_pcoffset9");
    $add_attribute(transaction_view_h,control_baser,"control_baser");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

