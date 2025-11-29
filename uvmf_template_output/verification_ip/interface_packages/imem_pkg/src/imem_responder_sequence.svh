//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_responder_sequence 
  extends imem_sequence_base ;

  `uvm_object_utils( imem_responder_sequence )
  
    bit use_immediate_mode;
    bit [15:0] instruction;
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    for (int i=0;i<8;i++) begin
      start_item(req);
      req.Instr_dout = {4'h5, i[2:0], i[2:0], 1'b1, 5'b0};
      req.complete_instr = 1;
      finish_item(req);
    end

    forever begin
      start_item(req);
      // if (!req.randomize() with {
      //   instruction_type inside {ST,STRR,STI};
      //   operation_type == MEMORY_OPERATIONS;
        
      //   dest_reg inside {[0:7]};     // Used for DR (Loads) or SR (Stores)
      //   src_reg1 inside {[0:7]};     // Used for BaseR
      //   pcoffset9 inside {[0:255]}; // 9-bit offset
      //   pcoffset6 inside {[0:31]};   // 6-bit offset
      // }) begin
      //   `uvm_fatal("SEQ", "Failed to randomize MEMORY instruction")
      // end

      // //STORES
      // case (req.instruction_type)
      //   ST: begin
      //     // ST: Store PC-Relative
      //     // Format: 0011 SR PCOffset9
      //     req.instruction_type = ST;
      //     instruction = {4'h3,                // Opcode (3)
      //                        req.src_reg1,           // SR (Data to store)
      //                        req.pcoffset9};    // Offset9
      //   end 

      //   STRR: begin
      //     // STR: Store Base+Offset
      //     // Format: 0111 SR BaseR PCOffset6
      //     req.instruction_type = STRR;
      //     instruction = {4'h7,                // Opcode (7)
      //                        req.dest_reg,           // SR (Data to store)
      //                        req.src_reg1,           // BaseR (Address)
      //                        req.pcoffset6};    // Offset6
      //   end

      //   STI: begin
      //     // STI: Store Indirect
      //     // Format: 1011 SR PCOffset9
      //     req.instruction_type = STI;
      //     instruction = {4'hb,                // Opcode (B)
      //                        req.dest_reg,           // SR (Data to store)
      //                        req.pcoffset9};    // Offset9
      //   end
      // endcase
      if (!req.randomize() with {
        instruction_type inside {LD,LDR,LDI,LEA};
        operation_type == MEMORY_OPERATIONS;
        
        dest_reg inside {[0:7]};     // Used for DR (Loads) or SR (Stores)
        src_reg1 inside {[0:7]};     // Used for BaseR
        pcoffset9 inside {[0:255]}; // 9-bit offset
        pcoffset6 inside {[0:31]};   // 6-bit offset
      }) begin
        `uvm_fatal("SEQ", "Failed to randomize MEMORY instruction")
      end

      //LOADS
      case (req.instruction_type) 
        LD: begin
            // LD: Load PC-Relative
            // Format: 0010 DR PCOffset9
            req.instruction_type = LD;
            instruction = {4'h2,                // Opcode
                               req.dest_reg,             // DR
                               req.pcoffset9};      // Offset9
        end

        LDR: begin
          // LDR: Load Base+Offset
          // Format: 0110 DR BaseR PCOffset6
          req.instruction_type = LDR;
          instruction = {4'h6,                // Opcode
                             req.dest_reg,           // DR
                             req.src_reg1,           // BaseR
                             req.pcoffset6};    // Offset6
        end 

        LDI: begin
          // LDI: Load Indirect
          // Format: 1010 DR PCOffset9
          req.instruction_type = LDI;
          instruction = {4'ha,                // Opcode
                             req.dest_reg,           // DR
                             req.pcoffset9};    // Offset9
        end

        LEA: begin
          // LEA: Load Effective Address
          // Format: 1110 DR PCOffset9
          req.instruction_type = LEA;
          instruction = {4'he,                // Opcode
                             req.dest_reg,           // DR
                             req.pcoffset9};    // Offset9
        end
      endcase

      //ALU Operations 
      // use_immediate_mode = $urandom_range(0, 1);
      // if (!req.randomize() with {
      //   instruction_type inside {ADD,ADDI,AND,ANDI,NOT};
      //   operation_type == ALU_OPERATIONS;        
      //   dest_reg inside {[0:7]};
      //   src_reg1 inside {[0:7]};
      //   src_reg2 inside {[0:7]};
      //   imm5 inside {[0:31]};
      // }) begin
      //   `uvm_fatal("SEQ", "Failed to randomize ADD instruction transaction")
      // end
      
      // case (req.instruction_type)
      //   ADD: begin
      //     // ADD Register-Register mode (Bit 5 = 0)
      //     // Format: 0001 DR SR1 00 0 SR2
      //     req.instruction_type = ADD;
      //     instruction = {4'h1,                    // Bits 15-12: Opcode 0001
      //                       req.dest_reg,              // Bits 11-9:  DR
      //                       req.src_reg1,              // Bits 8-6:   SR1
      //                       2'b00,                     // Bits 5-4:   00
      //                       1'b0,                      // Bit 3:     0
      //                       req.src_reg2};             // Bits 2-0:   SR2
      //   end
      //   ADDI: begin
      //     // ADD Immediate mode (Bit 5 = 1)
      //     // Format: 0001 DR SR1 1 imm5[4:0]
      //     req.instruction_type = ADDI;
      //     instruction = {4'h1,                    // Bits 15-12: Opcode 0001
      //                       req.dest_reg,             // Bits 11-9:  DR
      //                       req.src_reg1,              // Bits 8-6:   SR1
      //                       1'b1,                      // Bit 5:     Immediate mode
      //                       req.imm5[4:0]};            // Bits 4-0:  imm5 (5-bit immediate)
      //   end
      //   AND: begin
      //     // AND Register-Register mode (Bit 5 = 0)
      //     // Format: 0101 DR SR1 00 0 SR2
      //     req.instruction_type = AND;
      //     instruction = {4'h5,                    // Bits 15-12: Opcode 0101
      //                       req.dest_reg,              // Bits 11-9:  DR
      //                       req.src_reg1,              // Bits 8-6:   SR1
      //                       2'b00,                     // Bits 5-4:   00
      //                       1'b0,                      // Bit 3:     0
      //                       req.src_reg2};             // Bits 2-0:   SR2
      //   end
      //   ANDI: begin
      //     // AND Immediate mode (Bit 5 = 1)
      //     // Format: 0101 DR SR1 1 imm5[4:0]
      //     req.instruction_type = ANDI;
      //     instruction = {4'h5,                    // Bits 15-12: Opcode 0101
      //                       req.dest_reg,             // Bits 11-9:  DR
      //                       req.src_reg1,              // Bits 8-6:   SR1
      //                       1'b1,                      // Bit 5:     Immediate mode
      //                       req.imm5[4:0]};            // Bits 4-0:  imm5 (5-bit immediate)
      //   end
      //   NOT: begin
      //     // NOT instruction
      //     // Format: 1001 DR SR1 111111
      //     req.instruction_type = NOT;
      //     instruction = {4'h9,                    // Bits 15-12: Opcode 1001
      //                       req.dest_reg,             // Bits 11-9:  DR
      //                       req.src_reg1,             // Bits 8-6:   SR1
      //                       6'b111111};               // Bits 5-0:   111111
      //   end
      // endcase
      
      // Set the instruction output
      req.Instr_dout = instruction;
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      // pragma uvmf custom body end
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

