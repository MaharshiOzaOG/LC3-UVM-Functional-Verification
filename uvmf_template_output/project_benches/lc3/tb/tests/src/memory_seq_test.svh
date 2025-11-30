class memory_seq_test extends test_top;
    `uvm_component_utils(memory_seq_test)
    
    function new( string name = "memory_seq_test", uvm_component parent = null);
        super.new(name,parent);
  	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
        imem_responder_sequence::type_id::set_type_override(memory_instructions::get_type());
	endfunction
endclass