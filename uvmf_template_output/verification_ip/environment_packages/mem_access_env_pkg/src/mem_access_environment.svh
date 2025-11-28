//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class mem_access_environment  extends uvmf_environment_base #(
    .CONFIG_T( mem_access_env_configuration 
  ));
  `uvm_component_utils( mem_access_environment )





  typedef mem_access_in_agent  mem_access_in_agent_t;
  mem_access_in_agent_t mem_access_in_agent;

  typedef mem_access_out_agent  mem_access_out_agent_t;
  mem_access_out_agent_t mem_access_out_agent;




  typedef mem_access_predictor #(
                .CONFIG_T(CONFIG_T)
                )
 mem_access_pred_t;
  mem_access_pred_t mem_access_pred;

  typedef uvmf_in_order_scoreboard #(.T(mem_access_out_transaction))  mem_access_sb_t;
  mem_access_sb_t mem_access_sb;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(mem_access_env_configuration)) mem_access_vsqr_t;
  mem_access_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    mem_access_in_agent = mem_access_in_agent_t::type_id::create("mem_access_in_agent",this);
    mem_access_in_agent.set_config(configuration.mem_access_in_agent_config);
    mem_access_out_agent = mem_access_out_agent_t::type_id::create("mem_access_out_agent",this);
    mem_access_out_agent.set_config(configuration.mem_access_out_agent_config);
    mem_access_pred = mem_access_pred_t::type_id::create("mem_access_pred",this);
    mem_access_pred.configuration = configuration;
    mem_access_sb = mem_access_sb_t::type_id::create("mem_access_sb",this);

    vsqr = mem_access_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    mem_access_in_agent.monitored_ap.connect(mem_access_pred.analysis_export);
    mem_access_pred.predict_ap.connect(mem_access_sb.expected_analysis_export);
    mem_access_out_agent.monitored_ap.connect(mem_access_sb.actual_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.mem_access_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

