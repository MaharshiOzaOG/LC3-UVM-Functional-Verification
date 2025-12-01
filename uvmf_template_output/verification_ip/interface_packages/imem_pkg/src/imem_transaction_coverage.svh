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
  bit [2:0] src_reg;
  // pragma uvmf custom class_item_additional begin
  protected inst_type          op_cov;
  protected bit [2:0]          data_reg_cov; // Unified SR and DR
  protected bit [2:0]          base_reg_cov; // Base Register
  protected bit [8:0]          off9_cov;
  protected bit [5:0]          off6_cov;

  protected bit [2:0]          nzp_cov;      // NEW: For Branch Condition Codes
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup imem_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    // option.auto_bin_max=1024;
    option.per_instance=1;
    option.name = "memory_cross_coverage";

    // 1. Opcode Coverpoint
    cp_op: coverpoint op_cov {
      bins pcrel_ind[] = {LD, ST, LDI, STI, LEA}; // Uses Offset9
      bins base_off[]  = {LDR, STRR};             // Uses BaseR + Offset6
      bins control[]   = {BR, JMP}; // Added Control Opcodes
    }

    // 2. Data Register (SR or DR) Coverpoint
    // We sample the normalized 'data_reg_cov' here
    cp_data_reg: coverpoint data_reg_cov {
      bins regs[] = {[0:7]};
    }

    // 3. Base Register Coverpoint
    cp_base_reg: coverpoint base_reg_cov {
      bins regs[] = {[0:7]};
    }

    // 4. Offset 9 Coverpoint
    cp_off9: coverpoint off9_cov {
      option.auto_bin_max = 512; // Ensure bin for every value (0-511)
    }

    // 5. Offset 6 Coverpoint
    cp_off6: coverpoint off6_cov {
      option.auto_bin_max = 64;  // Ensure bin for every value (0-63)
    }

    // 6. NZP (New for BR)
    cp_nzp: coverpoint nzp_cov {
       bins valid_nzp[] = {[1:7]}; // 0 is usually NOP, 1-7 are valid branches
    }

    // ----------------------------------------------------------------------
    // CROSS COVERAGE
    // ----------------------------------------------------------------------

    // CROSS 1: PC-Relative & Indirect (LD, ST, LDI, STI, LEA)
    // Structure: Opcode x DataReg x Offset9
    cross_pcrel_ind: cross cp_op, cp_data_reg, cp_off9 {
      // Only apply this cross to the relevant instructions
      ignore_bins valid_ops = !binsof(cp_op) intersect {LD, ST, LDI, STI, LEA};
    }

    // CROSS 2: Base + Offset (LDR, STRR)
    // Structure: Opcode x DataReg x BaseReg x Offset6
    cross_base_off: cross cp_op, cp_data_reg, cp_base_reg, cp_off6 {
      // Only apply this cross to LDR and STRR
      ignore_bins valid_ops = !binsof(cp_op) intersect {LDR, STRR};
    }
    
    // CROSS 3: Control Branch (BR)
    // Opcode x NZP x Offset9
    cross_br: cross cp_op, cp_nzp, cp_off9 {
       // Only for BR
       ignore_bins invalid = !binsof(cp_op) intersect {BR};
    }

    // CROSS 4: Control Jump (JMP)
    // Opcode x BaseReg
    cross_jmp: cross cp_op, cp_base_reg {
       // Only for JMP
       ignore_bins invalid = !binsof(cp_op) intersect {JMP};
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
    // coverage_trans = t;
    // 1. Copy simple fields
    op_cov   = t.instruction_type;
    off6_cov = t.pcoffset6;
    // off9_cov = t.pcoffset9;


    // --- OFFSET 9 Handling ---
    if (t.instruction_type == BR) begin
      // For BR, use the control offset
      off9_cov = t.control_pcoffset9;
    end
    else begin
      // For LD/ST/etc, use the standard pcoffset9
      off9_cov = t.pcoffset9;
    end
    
    
    if (t.instruction_type == BR) nzp_cov = t.control_nzp;

    // 2. Normalize "Data Register" (SR or DR) logic
    // Based on your specific transaction definitions:
    if (t.instruction_type == ST || t.instruction_type == STI || t.instruction_type == STRR) begin
      // For ST/STI, the Source Register is in src_reg1
      data_reg_cov = t.src_reg1;
    end
    else begin
      // For LD, LDI, LEA, LDR, the reg of interest is in dest_reg
      // (Recall: Your STRR code put SR into dest_reg)
      data_reg_cov = t.dest_reg;
    end

    // 3. Normalize "Base Register" logic
    // For LDR/STRR, BaseR is always in src_reg1
    base_reg_cov = t.baser;

    // 4. Sample the coverage
    imem_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

