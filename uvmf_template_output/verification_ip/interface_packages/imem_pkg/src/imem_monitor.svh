//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class receives imem transactions observed by the
//     imem monitor BFM and broadcasts them through the analysis port
//     on the agent. It accesses the monitor BFM through the monitor
//     task. This UVM component captures transactions
//     for viewing in the waveform viewer if the
//     enable_transaction_viewing flag is set in the configuration.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_monitor  extends uvmf_monitor_base #(
                    .CONFIG_T(imem_configuration  ),
                    .BFM_BIND_T(virtual imem_monitor_bfm  ),
                    .TRANS_T(imem_transaction  ));

  `uvm_component_utils( imem_monitor )

// Structure used to pass data from monitor BFM to monitor class in agent.
// Use to_monitor_struct function to pack transaction variables into structure.
// Use from_monitor_struct function to unpack transaction variables from structure.
`imem_MONITOR_STRUCT

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
// ****************************************************************************
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// This function sends configuration object variables to the monitor BFM 
// using the configuration struct.
//
   virtual function void configure(input CONFIG_T cfg);
      bfm.configure( cfg.to_struct() );

   endfunction

// ****************************************************************************
// This function places a handle to this class in the proxy variable in the
// monitor BFM.  This allows the monitor BFM to call the notify_transaction
// function within this class.
//
   virtual function void set_bfm_proxy_handle();
      bfm.proxy = this;   endfunction

// ***************************************************************************              
  virtual task run_phase(uvm_phase phase);                                                   
  // Start monitor BFM thread and don't call super.run() in order to                       
  // override the default monitor proxy 'pull' behavior with the more                      
  // emulation-friendly BFM 'push' approach using the notify_transaction                   
  // function below                                                                        
  bfm.start_monitoring();                                                   
  endtask                                                                                    
  
// **************************************************************************  
  
// This function is called by the monitor BFM.  It receives data observed by the
// monitor BFM.  Data is passed using the imem_monitor_struct.          
 virtual function void notify_transaction(input imem_monitor_s imem_monitor_struct);
 
 
    trans = TRANS_T::type_id::create("trans");
    trans.from_monitor_struct(imem_monitor_struct);
    trans.start_time = time_stamp;                                                          
    trans.end_time = $time;                                                                 
    time_stamp = trans.end_time;
  
   case (trans.Instr_dout[15:12])
      
      4'b0010: begin // LD
         trans.instruction_type = LD;
         trans.dest_reg  = trans.Instr_dout[11:9]; // DR
         trans.pcoffset9 = trans.Instr_dout[8:0];  // Offset9
      end

      4'b0011: begin // ST
         trans.instruction_type = ST;
         trans.src_reg1  = trans.Instr_dout[11:9]; // SR
         trans.pcoffset9 = trans.Instr_dout[8:0];  // Offset9
      end

      4'b1010: begin // LDI
         trans.instruction_type = LDI;
         trans.dest_reg  = trans.Instr_dout[11:9]; // DR
         trans.pcoffset9 = trans.Instr_dout[8:0];  // Offset9
      end

      4'b1011: begin // STI
         trans.instruction_type = STI;
         trans.src_reg1  = trans.Instr_dout[11:9]; // SR
         trans.pcoffset9 = trans.Instr_dout[8:0];  // Offset9
      end

      4'b1110: begin // LEA
         trans.instruction_type = LEA;
         trans.dest_reg  = trans.Instr_dout[11:9]; // DR
         trans.pcoffset9 = trans.Instr_dout[8:0];  // Offset9
      end

      4'b0110: begin // LDR
         trans.instruction_type = LDR;
         trans.dest_reg  = trans.Instr_dout[11:9]; // DR
         trans.baser     = trans.Instr_dout[8:6];  // BaseR (Bits 8:6)
         trans.pcoffset6 = trans.Instr_dout[5:0];  // Offset6
      end

      4'b0111: begin // STR
         trans.instruction_type = STR;
         trans.src_reg1  = trans.Instr_dout[11:9]; // SR
         trans.baser     = trans.Instr_dout[8:6];  // BaseR (Bits 8:6)
         trans.pcoffset6 = trans.Instr_dout[5:0];  // Offset6
      end

      4'b0001: begin // ADD
          trans.instruction_type = ADD;
          trans.dest_reg = trans.Instr_dout[11:9];
          trans.src_reg1 = trans.Instr_dout[8:6];
          trans.imm5     = trans.Instr_dout[5:0]; 
      end
      4'b0101: begin // AND
          trans.instruction_type = AND;
          trans.dest_reg = trans.Instr_dout[11:9];
          trans.src_reg1 = trans.Instr_dout[8:6];
          trans.imm5     = trans.Instr_dout[5:0];
      end
      4'b1001: begin // NOT
          trans.instruction_type = NOT;
          trans.dest_reg = trans.Instr_dout[11:9];
          trans.src_reg1 = trans.Instr_dout[8:6];
      end

      4'b0000: begin // BR
          trans.instruction_type = BR;
          trans.control_nzp      = NZP'(trans.Instr_dout[11:9]); // Extract NZP
          trans.control_pcoffset9= trans.Instr_dout[8:0];  // Extract Offset
      end

      4'b1100: begin // JMP (or RET)
          trans.instruction_type = JMP;
          trans.baser            = trans.Instr_dout[8:6];  // Extract BaseR
      end
      
      // ... (default) ...
      default: begin
         // Handle BR, JMP, or unknown
      end
   endcase
   // -----------------------------------------------------------------------
    analyze(trans);                                                                         
  endfunction  

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

