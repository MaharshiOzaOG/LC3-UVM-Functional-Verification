class control_instructions extends imem_responder_sequence;
    `uvm_object_utils(control_instructions)

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
        instruction_type inside {BR,JMP};
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
      endcase
      
      // Set the instruction output
      req.Instr_dout = instruction;
      finish_item(req);
    end
  endtask

endclass