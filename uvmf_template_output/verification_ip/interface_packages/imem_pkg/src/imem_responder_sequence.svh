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
    bit [2:0] NZP = 3'b1;
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    repeat(2)begin
      for (int i=0;i<8;i++) begin
        start_item(req);
        req.Instr_dout = {4'h5, i[2:0], i[2:0], 1'b1, 5'b0};
        req.complete_instr = 1;
        finish_item(req);
    end
    end

    forever begin
      start_item(req);
      if (!req.randomize() with {
        instruction_type inside {ADD,ADDI,AND,ANDI,NOT,ST,STRR,STI,LD,LDR,LDI,LEA,BR,JMP};
        // operation_type == MEMORY_OPERATIONS;
        
        dest_reg inside {[0:7]};     // Used for DR (Loads) or SR (Stores)
        src_reg1 inside {[0:7]};     // Used for BaseR
        src_reg2 inside {[0:7]};
        pcoffset9 inside {[0:511]}; // 9-bit offset
        pcoffset6 inside {[0:63]};   // 6-bit offset
        imm5 inside {[0:31]};
        control_nzp inside {[1:7]};
        control_pcoffset9 inside {[0:511]};
      }) begin
        `uvm_fatal("SEQ", "Failed to randomize MEMORY instruction")
      end

      //STORES
      case (req.instruction_type)    // Offset9
        // end 
        BR: begin
          req.instruction_type = BR;
          req.operation_type = CONTROL_OPERATIONS;
          instruction = {4'b0, 
                          req.control_nzp,
                          req.control_pcoffset9};
        end

        JMP: begin
          req.instruction_type = JMP;
          req.operation_type = CONTROL_OPERATIONS;
          instruction = {4'b1100, 
                          3'b000, 
                          req.src_reg1, 
                          6'b000000};
        end

        STRR: begin
          // STR: Store Base+Offset
          // Format: 0111 SR BaseR PCOffset6
          req.instruction_type = STRR;
          req.operation_type = MEMORY_OPERATIONS;
          instruction = {4'h7,                // Opcode (7)
                             req.dest_reg,          // SR (Data to store)
                             req.src_reg1,           // BaseR (Address)
                             req.pcoffset6};    // Offset6
        // end               req.src_reg1,           // SR (Data to store)
                            //  req.pcoffset9};    // Offset9
        end 

        STI: begin
          // STI: Store Indirect
          // Format: 1011 SR PCOffset9
          req.instruction_type = STI;
          req.operation_type = MEMORY_OPERATIONS;
          instruction = {4'b1011,                // Opcode (B)
                             req.src_reg1,           // SR (Data to store)
                             req.pcoffset9};    // Offset9
        end

        ST: begin
          // ST: Store PC-Relative
          // Format: 0011 SR PCOffset9
          req.instruction_type = ST;
          req.operation_type = MEMORY_OPERATIONS;
          instruction = {4'h3,                // Opcode (3)
                          req.src_reg1,
                          req.pcoffset9};
        end

      // //LOADS
      // case (req.instruction_type) 
        LD: begin
            // LD: Load PC-Relative
            // Format: 0010 DR PCOffset9
            req.instruction_type = LD;
            req.operation_type = MEMORY_OPERATIONS;
            instruction = {4'h2,                // Opcode
                               req.dest_reg,             // DR
                               req.pcoffset9};      // Offset9
        end

        LDR: begin
          // LDR: Load Base+Offset
          // Format: 0110 DR BaseR PCOffset6
          req.instruction_type = LDR;
          req.operation_type = MEMORY_OPERATIONS;
          instruction = {4'h6,                // Opcode
                             req.dest_reg,           // DR
                             req.src_reg1,           // BaseR
                             req.pcoffset6};    // Offset6
        end 

        LDI: begin
          // LDI: Load Indirect
          // Format: 1010 DR PCOffset9
          req.instruction_type = LDI;
          req.operation_type = MEMORY_OPERATIONS;
          instruction = {4'ha,                // Opcode
                             req.dest_reg,           // DR
                             req.pcoffset9};    // Offset9
        end

        LEA: begin
          // LEA: Load Effective Address
          // Format: 1110 DR PCOffset9
          req.instruction_type = LEA;
          req.operation_type = MEMORY_OPERATIONS;
          instruction = {4'he,                // Opcode
                             req.dest_reg,           // DR
                             req.pcoffset9};    // Offset9
        end

        ADD: begin
          // ADD Register-Register mode (Bit 5 = 0)
          // Format: 0001 DR SR1 00 0 SR2
          req.instruction_type = ADD;
          req.operation_type = ALU_OPERATIONS;
          instruction = {4'h1,                    // Bits 15-12: Opcode 0001
                            req.dest_reg,              // Bits 11-9:  DR
                            req.src_reg1,              // Bits 8-6:   SR1
                            2'b00,                     // Bits 5-4:   00
                            1'b0,                      // Bit 3:     0
                            req.src_reg2};             // Bits 2-0:   SR2
        end
        ADDI: begin
          // ADD Immediate mode (Bit 5 = 1)
          // Format: 0001 DR SR1 1 imm5[4:0]
          req.instruction_type = ADDI;
          req.operation_type = ALU_OPERATIONS;
          instruction = {4'h1,                    // Bits 15-12: Opcode 0001
                            req.dest_reg,             // Bits 11-9:  DR
                            req.src_reg1,              // Bits 8-6:   SR1
                            1'b1,                      // Bit 5:     Immediate mode
                            req.imm5[4:0]};            // Bits 4-0:  imm5 (5-bit immediate)
        end
        AND: begin
          // AND Register-Register mode (Bit 5 = 0)
          // Format: 0101 DR SR1 00 0 SR2
          req.instruction_type = AND;
          req.operation_type = ALU_OPERATIONS;
          instruction = {4'h5,                    // Bits 15-12: Opcode 0101
                            req.dest_reg,              // Bits 11-9:  DR
                            req.src_reg1,              // Bits 8-6:   SR1
                            2'b00,                     // Bits 5-4:   00
                            1'b0,                      // Bit 3:     0
                            req.src_reg2};             // Bits 2-0:   SR2
        end
        ANDI: begin
          // AND Immediate mode (Bit 5 = 1)
          // Format: 0101 DR SR1 1 imm5[4:0]
          req.instruction_type = ANDI;
          req.operation_type = ALU_OPERATIONS;
          instruction = {4'h5,                    // Bits 15-12: Opcode 0101
                            req.dest_reg,             // Bits 11-9:  DR
                            req.src_reg1,              // Bits 8-6:   SR1
                            1'b1,                      // Bit 5:     Immediate mode
                            req.imm5[4:0]};            // Bits 4-0:  imm5 (5-bit immediate)
        end
        NOT: begin
          // NOT instruction
          // Format: 1001 DR SR1 111111
          req.instruction_type = NOT;
          req.operation_type = ALU_OPERATIONS;
          instruction = {4'h9,                    // Bits 15-12: Opcode 1001
                            req.dest_reg,             // Bits 11-9:  DR
                            req.src_reg1,             // Bits 8-6:   SR1
                            6'b111111};               // Bits 5-0:   111111
        end
      endcase
      
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

