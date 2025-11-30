class alu_instructions extends imem_responder_sequence;
    `uvm_object_utils(alu_instructions)

    bit [15:0] instruction;
    int iterations;
    function new (string name = "alu_sequence");
        super.new(name);
        iterations = 1;
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
    
    // forever begin
    //   start_item(req);


    //   if (!req.randomize() with {
    //     instruction_type inside {ADD,ADDI,AND,ANDI,NOT/*,ST,STRR,STI,LD,LDR,LDI,LEA,BR,JMP*/};
    //     // operation_type == MEMORY_OPERATIONS;
    //     dest_reg inside {[0:7]};     // Used for DR (Loads) or SR (Stores)
    //     src_reg1 inside {[0:7]};     // Used for BaseR
    //     src_reg2 inside {[0:7]};
    //     pcoffset9 inside {[0:511]}; // 9-bit offset
    //     pcoffset6 inside {[0:63]};   // 6-bit offset
    //     imm5 inside {[0:31]};
    //     control_nzp inside {[1:7]};
    //     control_pcoffset9 inside {[0:511]};
    //   }) begin
    //     `uvm_fatal("SEQ", "Failed to randomize MEMORY instruction")
    //   end

    //   case (req.instruction_type) 
    //     ADD: begin
    //       // ADD Register-Register mode (Bit 5 = 0)
    //       // Format: 0001 DR SR1 00 0 SR2
    //       req.instruction_type = ADD;
    //       req.operation_type = ALU_OPERATIONS;
    //       instruction = {4'h1,                    // Bits 15-12: Opcode 0001
    //                         req.dest_reg,              // Bits 11-9:  DR
    //                         req.src_reg1,              // Bits 8-6:   SR1
    //                         2'b00,                     // Bits 5-4:   00
    //                         1'b0,                      // Bit 3:     0
    //                         req.src_reg2};             // Bits 2-0:   SR2
    //     end  

    //     ADDI: begin
    //       // ADD Immediate mode (Bit 5 = 1)
    //       // Format: 0001 DR SR1 1 imm5[4:0]
    //       req.instruction_type = ADDI;
    //       req.operation_type = ALU_OPERATIONS;
    //       instruction = {4'h1,                    // Bits 15-12: Opcode 0001
    //                         req.dest_reg,             // Bits 11-9:  DR
    //                         req.src_reg1,              // Bits 8-6:   SR1
    //                         1'b1,                      // Bit 5:     Immediate mode
    //                         req.imm5[4:0]};            // Bits 4-0:  imm5 (5-bit immediate)
    //     end
    //     AND: begin
    //       // AND Register-Register mode (Bit 5 = 0)
    //       // Format: 0101 DR SR1 00 0 SR2
    //       req.instruction_type = AND;
    //       req.operation_type = ALU_OPERATIONS;
    //       instruction = {4'h5,                    // Bits 15-12: Opcode 0101
    //                      req.dest_reg,              // Bits 11-9:  DR
    //                      req.src_reg1,              // Bits 8-6:   SR1
    //                      2'b00,                     // Bits 5-4:   00
    //                      1'b0,                      // Bit 3:     0
    //                      req.src_reg2};             // Bits 2-0:   SR2
    //     end
    //     ANDI: begin
    //       // AND Immediate mode (Bit 5 = 1)
    //       // Format: 0101 DR SR1 1 imm5[4:0]
    //       req.instruction_type = ANDI;
    //       req.operation_type = ALU_OPERATIONS;
    //       instruction = {4'h5,                    // Bits 15-12: Opcode 0101
    //                         req.dest_reg,             // Bits 11-9:  DR
    //                         req.src_reg1,              // Bits 8-6:   SR1
    //                         1'b1,                      // Bit 5:     Immediate mode
    //                         req.imm5[4:0]};            // Bits 4-0:  imm5 (5-bit immediate)
    //     end
    //     NOT: begin
    //       // NOT instruction
    //       // Format: 1001 DR SR1 111111
    //       req.instruction_type = NOT;
    //       req.operation_type = ALU_OPERATIONS;
    //       instruction = {4'h9,                    // Bits 15-12: Opcode 1001
    //                         req.dest_reg,             // Bits 11-9:  DR
    //                         req.src_reg1,             // Bits 8-6:   SR1
    //                         6'b111111};               // Bits 5-0:   111111
    //     end   
    //   endcase
      
    //   // Set the instruction output
    //   req.Instr_dout = instruction;
    //   finish_item(req);
    // end

    for (int i=0;i<8;i++) begin
      for (int j=0;j<8;j++) begin
        for (int k=0;k<8;k++) begin
          $display("No of Iterations: %d", iterations++);
          start_item(req);
          // ADD Register-Register mode (Bit 5 = 0)
          // Format: 0001 DR SR1 00 0 SR2
          req.instruction_type = ADD;
          req.operation_type = ALU_OPERATIONS;
          instruction = {4'h1,                    // Bits 15-12: Opcode 0001
                         i[2:0],              // Bits 11-9:  DR
                         j[2:0],              // Bits 8-6:   SR1
                         2'b00,                     // Bits 5-4:   00
                         1'b0,                      // Bit 3:     0
                         k[2:0]};             // Bits 2-0:   SR2 
          req.Instr_dout = instruction;   
          finish_item(req);     
        end
      end
    end
  endtask
endclass