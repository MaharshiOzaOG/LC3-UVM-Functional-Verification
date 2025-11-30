//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records imem transaction information using
//       a covergroup named imem_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_transaction_coverage  extends uvm_subscriber #(.T(imem_transaction ));

  `uvm_component_utils( imem_transaction_coverage )

  T coverage_trans;
  bit [3:0] Instr_opcode;
  bit [15:0] ANDI_cp;
  bit [15:0] ADDI_cp;

  

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup imem_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    // PC: coverpoint coverage_trans.PC;
    // instrmem_rd: coverpoint coverage_trans.instrmem_rd;
    // Instr_dout: coverpoint coverage_trans.Instr_dout;
    // complete_instr: coverpoint coverage_trans.complete_instr;
    // operation_type: coverpoint coverage_trans.operation_type;
    // instruction_type: coverpoint coverage_trans.instruction_type;
    // npc: coverpoint coverage_trans.npc;
    // instr_opcode: coverpoint coverage_trans.instr_opcode;
    // dest_reg: coverpoint coverage_trans.dest_reg;
    // src_reg1: coverpoint coverage_trans.src_reg1;
    // src_reg2: coverpoint coverage_trans.src_reg2;
    // imm5: coverpoint coverage_trans.imm5;
    // mem_dest_reg: coverpoint coverage_trans.mem_dest_reg;
    // mem_src_reg: coverpoint coverage_trans.mem_src_reg;
    // pcoffset9: coverpoint coverage_trans.pcoffset9;
    // signed_pcoffset9: coverpoint coverage_trans.signed_pcoffset9;
    // baser: coverpoint coverage_trans.baser;
    // pcoffset6: coverpoint coverage_trans.pcoffset6;
    // control_nzp: coverpoint coverage_trans.control_nzp;
    // control_pcoffset9: coverpoint coverage_trans.control_pcoffset9;
    // control_baser: coverpoint coverage_trans.control_baser;
    // pragma uvmf custom covergroup end

    //covergroup imem_transaction_cg;
    Instr_opcode : coverpoint coverage_trans.Instr_dout[15:12] {
      bins ADD  = {4'b0001};
      bins AND  = {4'b0101};
      bins NOT  = {4'b1001};
      bins LD   = {4'b0010};
      bins LDR  = {4'b0110};
      bins LDI  = {4'b1010};
      bins LEA  = {4'b1110};
      bins ST   = {4'b0011};
      bins STR  = {4'b0111};
      bins STI  = {4'b1011};
      bins BR   = {4'b0000};
      bins JMP  = {4'b1100};
    }

    ADDI_cp : coverpoint coverage_trans.Instr_dout {
      bins addi = { [16'h0000 : 16'hFFFF] } iff 
                  (coverage_trans.Instr_dout[15:12] == 4'b0001 &&
                  coverage_trans.Instr_dout[5]     == 1'b1);
    }

    ANDI_cp : coverpoint coverage_trans.Instr_dout {
      bins andi = { [16'h0000 : 16'hFFFF] } iff 
                  (coverage_trans.Instr_dout[15:12] == 4'b0101 &&
                  coverage_trans.Instr_dout[5]     == 1'b1);
    }


    
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    imem_transaction_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that transaction variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    imem_transaction_cg.set_inst_name($sformatf("imem_transaction_cg_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    imem_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

