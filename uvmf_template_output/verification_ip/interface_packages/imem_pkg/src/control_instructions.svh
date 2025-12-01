class control_instructions extends imem_responder_sequence;
    `uvm_object_utils(control_instructions)

    bit [15:0] instruction;

    function new (string name = "alu_sequence");
        super.new(name);
    endfunction



  task body();
    // -----------------------------------------------------------------------
    // 0. DECLARATIONS (Use 'int' to prevent infinite loops)
    // -----------------------------------------------------------------------
    int nzp_i;        // Condition Codes (1-7)
    int pcoffset9_i;  // Branch Offset (0-511)
    int base_r_i;     // Jump Base Register (0-7)
    int i;            // Init loop iterator

    // -----------------------------------------------------------------------
    // 1. INITIALIZATION (Clear Registers)
    // -----------------------------------------------------------------------
    repeat(2) begin
       for (i=0; i<8; i++) begin
          req = imem_transaction::type_id::create("req");
          start_item(req);
          req.Instr_dout = {4'h5, i[2:0], i[2:0], 1'b1, 5'b0}; // AND R,R,#0
          req.complete_instr = 1;
          finish_item(req);
       end
    end

    // -----------------------------------------------------------------------
    // 2. CONTROL COVERAGE: BR (Branch)
    //    Cross: NZP x PCOffset9
    //    Total: 7 * 512 = 3584 combinations
    // -----------------------------------------------------------------------
    for (nzp_i = 1; nzp_i <= 7; nzp_i++) begin
       for (pcoffset9_i = 0; pcoffset9_i <= 511; pcoffset9_i++) begin
          
          req = imem_transaction::type_id::create("req");
          start_item(req);

          if (!req.randomize() with {
             instruction_type  == BR;
             operation_type    == CONTROL_OPERATIONS;
             control_nzp       == nzp_i[2:0];        // Iterate NZP
             control_pcoffset9 == pcoffset9_i[8:0];  // Iterate Offset
          }) begin
             `uvm_error("SEQ", "Randomization failed for BR")
          end

          // 
          // Format: 0000 | NZP | PCOffset9
          req.Instr_dout = {4'b0000, req.control_nzp, req.control_pcoffset9};
          finish_item(req);
       end
    end

    // -----------------------------------------------------------------------
    // 3. CONTROL COVERAGE: JMP (Jump)
    //    Cross: BaseR (0-7)
    // -----------------------------------------------------------------------
    for (base_r_i = 0; base_r_i <= 7; base_r_i++) begin
          
       req = imem_transaction::type_id::create("req");
       start_item(req);

       if (!req.randomize() with {
          instruction_type == JMP;
          operation_type   == CONTROL_OPERATIONS;
          baser            == base_r_i[2:0]; // Base Register for JMP
       }) begin
          `uvm_error("SEQ", "Randomization failed for JMP")
       end

       // 
       // Format: 1100 | 000 | BaseR | 000000
       req.Instr_dout = {4'b1100, 3'b000, req.baser, 6'b000000};
       req.complete_instr = 1; // VALID
       finish_item(req);

       // ------------------------------------------
       // 2. Send an IDLE/BUBBLE (Invalid)
       //    This forces the Monitor to see a distinct break.
       // ------------------------------------------
      //  req = imem_transaction::type_id::create("req");
      //  start_item(req);
      //  req.Instr_dout = 16'h0000;
      //  req.complete_instr = 0; // INVALID (Gap)
      //  finish_item(req);
    end
  endtask
// task body();
//     req=imem_transaction::type_id::create("req");
//     repeat(2)begin
//       for (int i=0;i<8;i++) begin
//         start_item(req);
//         req.Instr_dout = {4'h5, i[2:0], i[2:0], 1'b1, 5'b0};
//         req.complete_instr = 1;
//         finish_item(req);
//       end
//     end
    
//     forever begin
//       start_item(req);


//       if (!req.randomize() with {
//         instruction_type inside {BR,JMP};
//         dest_reg inside {[0:7]};     // Used for DR (Loads) or SR (Stores)
//         src_reg1 inside {[0:7]};     // Used for BaseR
//         src_reg2 inside {[0:7]};
//         pcoffset9 inside {[0:511]}; // 9-bit offset
//         pcoffset6 inside {[0:63]};   // 6-bit offset
//         imm5 inside {[0:31]};
//         control_nzp inside {[1:7]};
//         control_pcoffset9 inside {[0:511]};
//       }) begin
//         `uvm_fatal("SEQ", "Failed to randomize MEMORY instruction")
//       end

//       case (req.instruction_type) 
//         BR: begin
//           req.instruction_type = BR;
//           req.operation_type = CONTROL_OPERATIONS;
//           instruction = {4'b0, 
//                           req.control_nzp,
//                           req.control_pcoffset9};
//         end

//         JMP: begin
//           req.instruction_type = JMP;
//           req.operation_type = CONTROL_OPERATIONS;
//           instruction = {4'b1100, 
//                           3'b000, 
//                           req.src_reg1, 
//                           6'b000000};
//         end
//       endcase
      
//       // Set the instruction output
//       req.Instr_dout = instruction;
//       finish_item(req);
//     end
//   endtask

endclass