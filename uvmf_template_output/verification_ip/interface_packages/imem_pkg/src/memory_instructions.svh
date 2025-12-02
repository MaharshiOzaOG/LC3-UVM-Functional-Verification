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

//     task body();
//     // -----------------------------------------------------------------------
//     // 0. DECLARATIONS (Use 'int' to prevent infinite loops)
//     // -----------------------------------------------------------------------
//     int dr_sr_i;
//     int base_r_i;
//     int pcoffset9_i;
//     int pcoffset6_i;
//     int i;
    
//     // Arrays to hold the Opcodes we want to iterate over
//     inst_type ops_pcrel[] = {ST, LD, STI, LDI, LEA};
//     inst_type ops_base[]  = {LDR, STRR};

//     // -----------------------------------------------------------------------
//     // 1. INITIALIZATION (Your Fixed Pattern)
//     //    Clears Registers R0-R7 using AND Ri, Ri, #0
//     // -----------------------------------------------------------------------
    
//     repeat(2) begin
//        for (i=0; i<8; i++) begin
//           req = imem_transaction::type_id::create("req");
//           start_item(req);
//           // Manually construct instruction: AND Ri, Ri, #0
//           req.Instr_dout = {4'h5, i[2:0], i[2:0], 1'b1, 5'b0};
//           req.complete_instr = 1;
//           finish_item(req);
//        end
//     end

//     // -----------------------------------------------------------------------
//     // 2. CROSS COVERAGE GENERATION (Randomized with Constraints)
//     // -----------------------------------------------------------------------
    
//     // --- GROUP A: PC-Relative & Indirect Ops (LD, ST, LDI, STI, LEA) ---
//     for (dr_sr_i = 0; dr_sr_i <= 7; dr_sr_i++) begin
//       for (pcoffset9_i = 0; pcoffset9_i <= 511; pcoffset9_i++) begin
        
//         // Loop through the 5 opcodes in this group
//         foreach (ops_pcrel[op_idx]) begin
//             req = imem_transaction::type_id::create("req");
//             start_item(req);

//             // RANDOMIZE with Inline Constraints
//             if (!req.randomize() with {
//                 instruction_type == ops_pcrel[op_idx];
//                 operation_type   == MEMORY_OPERATIONS;
                
//                 // Constrain the Register (SR for Stores, DR for Loads)
//                 if (instruction_type inside {ST, STI})
//                     src_reg1 == dr_sr_i[2:0];
//                 else
//                     dest_reg == dr_sr_i[2:0];

//                 // Constrain the Offset
//                 pcoffset9 == pcoffset9_i[8:0];
//             }) begin
//                 `uvm_error("SEQ", "Randomization failed for PC-Relative Ops")
//             end

//             // PACK THE HEX (Sync Instr_dout with the randomized fields)
//             case (req.instruction_type)
//                 ST:  req.Instr_dout = {4'h3, req.src_reg1, req.pcoffset9};
//                 LD:  req.Instr_dout = {4'h2, req.dest_reg, req.pcoffset9};
//                 STI: req.Instr_dout = {4'hB, req.src_reg1, req.pcoffset9};
//                 LDI: req.Instr_dout = {4'hA, req.dest_reg, req.pcoffset9};
//                 LEA: req.Instr_dout = {4'hE, req.dest_reg, req.pcoffset9};
//             endcase

//             finish_item(req);
//         end
//       end
//     end

//     // --- GROUP B: Base + Offset Ops (LDR, STRR) ---
//     for (dr_sr_i = 0; dr_sr_i <= 7; dr_sr_i++) begin
//       for (base_r_i = 0; base_r_i <= 7; base_r_i++) begin
//         for (pcoffset6_i = 0; pcoffset6_i <= 63; pcoffset6_i++) begin
            
//             // Loop through the 2 opcodes in this group
//             foreach (ops_base[op_idx]) begin
//                 req = imem_transaction::type_id::create("req");
//                 start_item(req);

//                 if (!req.randomize() with {
//                     instruction_type == ops_base[op_idx];
//                     operation_type   == MEMORY_OPERATIONS;

//                     // Constrain Data Register (DR or SR)
//                     dest_reg == dr_sr_i[2:0]; 
                    
//                     // Constrain Base Register
//                     baser == base_r_i[2:0];

//                     // Constrain Offset
//                     pcoffset6 == pcoffset6_i[5:0];
//                 }) begin
//                     `uvm_error("SEQ", "Randomization failed for Base-Offset Ops")
//                 end

//                 // PACK THE HEX
//                 case (req.instruction_type)
//                     STRR: req.Instr_dout = {4'h7, req.dest_reg, req.baser, req.pcoffset6};
//                     LDR:  req.Instr_dout = {4'h6, req.dest_reg, req.baser, req.pcoffset6};
//                 endcase

//                 finish_item(req);
//             end
//         end 
//       end 
//     end

//     `uvm_info("SEQ", "Finished Randomized Cross-Coverage Generation", UVM_LOW)
//   endtask

      

// //   //     // Start generating transactions to cover all combinations
      
// //   //     // Loop 1: Iterate through all possible DR/SR values (8 combinations)
// //   //     for (dr_sr_val = 0; dr_sr_val <= 7; dr_sr_val++) begin
        
// //   //       // Loop 2: Iterate through all PCOffset9 values (512 combinations)
// //   //       for (pcoffset9_val = 0; pcoffset9_val <= 511; pcoffset9_val++) begin
          
// //   //         // --- Instructions using DR/SR and PCOffset9 (LD, ST, LDI, STI, LEA) ---
          
// //   //         req=imem_transaction::type_id::create("req");
// //   //             // 1. ST: Store PC-Relative (Opcode 3)
// //   //             start_item(req);
// //   //             req.instruction_type = ST;
// //   //             req.operation_type = MEMORY_OPERATIONS;
// //   //             req.src_reg1 = dr_sr_val;     // SR (Source Register for data)
// //   //             req.pcoffset9 = pcoffset9_val;
// //   //             instruction = {4'h3, req.src_reg1, req.pcoffset9};
// //   //             req.Instr_dout = instruction;
// //   //             finish_item(req);

// //   //             // 2. LD: Load PC-Relative (Opcode 2)
// //   //             start_item(req);
// //   //             req.instruction_type = LD;
// //   //             req.operation_type = MEMORY_OPERATIONS;
// //   //             req.dest_reg = dr_sr_val;     // DR (Destination Register for data)
// //   //             req.pcoffset9 = pcoffset9_val;
// //   //             instruction = {4'h2, req.dest_reg, req.pcoffset9};
// //   //             req.Instr_dout = instruction;
// //   //             finish_item(req);

// //   //             // 3. STI: Store Indirect (Opcode B)
// //   //             start_item(req);
// //   //             req.instruction_type = STI;
// //   //             req.operation_type = MEMORY_OPERATIONS;
// //   //             req.src_reg1 = dr_sr_val;     // SR
// //   //             req.pcoffset9 = pcoffset9_val;
// //   //             instruction = {4'hB, req.src_reg1, req.pcoffset9};
// //   //             req.Instr_dout = instruction;
// //   //             finish_item(req);

// //   //             // 4. LDI: Load Indirect (Opcode A)
// //   //             start_item(req);
// //   //             req.instruction_type = LDI;
// //   //             req.operation_type = MEMORY_OPERATIONS;
// //   //             req.dest_reg = dr_sr_val;     // DR
// //   //             req.pcoffset9 = pcoffset9_val;
// //   //             instruction = {4'hA, req.dest_reg, req.pcoffset9};
// //   //             req.Instr_dout = instruction;
// //   //             finish_item(req);

// //   //             // 5. LEA: Load Effective Address (Opcode E)
// //   //             start_item(req);
// //   //             req.instruction_type = LEA;
// //   //             req.operation_type = MEMORY_OPERATIONS;
// //   //             req.dest_reg = dr_sr_val;     // DR
// //   //             req.pcoffset9 = pcoffset9_val;
// //   //             instruction = {4'hE, req.dest_reg, req.pcoffset9};
// //   //             req.Instr_dout = instruction;
// //   //             finish_item(req);

// //   //         end // end PCOffset9 loop

          

// //   //         // // Loop 3: Iterate through all BaseR values (8 combinations)
// //   //         // for (base_r_val = 0; base_r_val <= 7; base_r_val++) begin

// //   //         //     // Loop 4: Iterate through all PCOffset6 values (64 combinations)
// //   //         //     for (pcoffset6_val = 0; pcoffset6_val <= 63; pcoffset6_val++) begin

// //   //         //         // --- Instructions using DR/SR, BaseR, and PCOffset6 (LDR, STRR) ---

// //   //         //         // 6. STRR: Store Base+Offset (Opcode 7)
// //   //         //         start_item(req);
// //   //         //         req.instruction_type = STRR;
// //   //         //         req.operation_type = MEMORY_OPERATIONS;
// //   //         //         req.dest_reg = dr_sr_val;     // SR
// //   //         //         req.src_reg1 = base_r_val;    // BaseR
// //   //         //         req.pcoffset6 = pcoffset6_val;
// //   //         //         instruction = {4'h7, req.dest_reg, req.src_reg1, req.pcoffset6};
// //   //         //         req.Instr_dout = instruction;
// //   //         //         finish_item(req);

// //   //         //         // 7. LDR: Load Base+Offset (Opcode 6)
// //   //         //         start_item(req);
// //   //         //         req.instruction_type = LDR;
// //   //         //         req.operation_type = MEMORY_OPERATIONS;
// //   //         //         req.dest_reg = dr_sr_val;     // DR
// //   //         //         req.src_reg1 = base_r_val;    // BaseR
// //   //         //         req.pcoffset6 = pcoffset6_val;
// //   //         //         instruction = {4'h6, req.dest_reg, req.src_reg1, req.pcoffset6};
// //   //         //         req.Instr_dout = instruction;
// //   //         //         finish_item(req);

// //   //         //     end // end PCOffset6 loop
// //   //         // end // end BaseR loop

// //   //     end // end DR/SR loop

// //   //     // Pragma body end (original code)
// //   //     // The UVM info is now inside the loop to report on generated transactions.
// //   //     `uvm_info("SEQ",$sformatf("Completed generation of all memory instruction cross-coverage combinations."),UVM_HIGH)
// //   //     // pragma uvmf custom body end

// //   // endtask

endclass