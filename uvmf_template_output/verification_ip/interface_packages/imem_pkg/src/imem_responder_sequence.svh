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

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_responder_sequence");
    super.new(name);
  endfunction

  task body();
    bit [15:0] mem_instruction; // Variable to hold the packed instruction

    // --- 1. Initial Fixed Instructions ---
    for (int i = 0; i < 8; i++) begin
        // ALWAYS create a new object
        req = imem_transaction::type_id::create("req");
        
        start_item(req);
        // AND instruction example: Opcode 5, DR=i, SR1=i, imm5=0
        req.Instr_dout = {4'h5, i[2:0], i[2:0], 1'b1, 5'b0};
        req.complete_instr = 1;
        finish_item(req);
    end

    // --- 2. Random Memory Operations Loop ---
    forever begin
        req = imem_transaction::type_id::create("req");
        start_item(req);

        // Fix: Use the variable names exactly as defined in 'imem_transaction'
        if (!req.randomize() with {
            instruction_type == LEA;           //inside {LD, LDR, ST, STR, LDI, STI, LEA};
            operation_type == MEMORY_OPERATIONS;        
            
            // Constrain constraints to valid register ranges
            dest_reg inside {[0:7]};
            src_reg1 inside {[0:7]};
            baser    inside {[0:7]}; // Changed from base_reg
            
            // Note: 2's complement constraints on unsigned bits work 
            // but ensure your specific simulator handles the cast correctly.
            pcoffset6 inside {[0:63]};   // Changed from offset6
            pcoffset9 inside {[0:511]}; // Changed from pc_offset9
        }) begin
            `uvm_fatal("SEQ", "Failed to randomize memory operation transaction")
        end

        // Construct the 16-bit instruction based on the randomized type
        case (req.instruction_type)
            // LD - Load PC-Relative
            LD: begin
                // Format:            0010            DR      PCoffset9
                mem_instruction = {4'b0010, req.dest_reg, req.pcoffset9};
            end

            // LDR - Load Base+Offset
            LDR: begin
                // Format:            0110            DR      BaseR        offset6
                mem_instruction = {4'b0110, req.dest_reg, req.baser, req.pcoffset6};
            end

            // ST - Store PC-Relative
            ST: begin
                // Format:            0011            SR      PCoffset9
                mem_instruction = {4'b0011, req.src_reg1, req.pcoffset9};
            end

            // STR - Store Base+Offset
            STRR: begin
                // Format:            0111            SR      BaseR        offset6
                mem_instruction = {4'b0111, req.src_reg1, req.baser, req.pcoffset6};
            end

            // LDI - Load Indirect
            LDI: begin
                // Format:            1010            DR      PCoffset9
                mem_instruction = {4'b1010, req.dest_reg, req.pcoffset9};
            end

            // STI - Store Indirect
            STI: begin
                // Format:            1011            SR      PCoffset9
                mem_instruction = {4'b1011, req.src_reg1, req.pcoffset9};
            end

            // LEA - Load Effective Address
            LEA: begin
                // Format:            1110            DR      PCoffset9
                mem_instruction = {4'b1110, req.dest_reg, req.pcoffset9};
            end
        endcase

        // Assign the packed instruction to the transaction
        req.Instr_dout = mem_instruction;
        req.complete_instr = 1;

        finish_item(req);

        // Logging
        case (req.instruction_type)
            LD, LDI, LEA: begin
                `uvm_info("SEQ", $sformatf("Memory Instruction: 0x%04x (%s, DR=R%0d, PCoffset9=%0d)", 
                          req.Instr_dout, req.instruction_type.name(), req.dest_reg, $signed(req.pcoffset9)), UVM_MEDIUM)
            end
            LDR: begin
                `uvm_info("SEQ", $sformatf("Memory Instruction: 0x%04x (%s, DR=R%0d, BaseR=R%0d, offset6=%0d)", 
                          req.Instr_dout, req.instruction_type.name(), req.dest_reg, req.baser, $signed(req.pcoffset6)), UVM_MEDIUM)
            end
            ST, STI: begin
                `uvm_info("SEQ", $sformatf("Memory Instruction: 0x%04x (%s, SR=R%0d, PCoffset9=%0d)", 
                          req.Instr_dout, req.instruction_type.name(), req.src_reg1, $signed(req.pcoffset9)), UVM_MEDIUM)
            end
            STRR: begin
                `uvm_info("SEQ", $sformatf("Memory Instruction: 0x%04x (%s, SR=R%0d, BaseR=R%0d, offset6=%0d)", 
                          req.Instr_dout, req.instruction_type.name(), req.src_reg1, req.baser, $signed(req.pcoffset6)), UVM_MEDIUM)
            end
        endcase
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

