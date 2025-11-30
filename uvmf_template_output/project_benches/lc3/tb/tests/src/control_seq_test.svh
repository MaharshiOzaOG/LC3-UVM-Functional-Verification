class control_seq_test extends test_top;
    `uvm_component_utils(control_seq_test)
    
    function new( string name = "control_seq_test", uvm_component parent = null);
        super.new(name,parent);
  	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
        imem_responder_sequence::type_id::set_type_override(control_instructions::get_type());
	endfunction
endclass