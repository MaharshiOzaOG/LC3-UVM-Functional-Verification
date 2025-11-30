class memory_instructions extends imem_responder_sequence;
    `uvm_object_utils(memory_instructions)

    bit [15:0] instruction;

    function new (string name = "alu_sequence");
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
        instruction_type inside {ST,STRR,STI,LD,LDR,LDI,LEA};
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

      case (req.instruction_type) 
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
      endcase
      
      // Set the instruction output
      req.Instr_dout = instruction;
      finish_item(req);
    end
  endtask

endclass