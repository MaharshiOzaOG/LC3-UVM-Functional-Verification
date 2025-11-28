//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: THis is the configuration for the lc3 environment.
//  it contains configuration classes for each agent.  It also contains
//  environment level configuration variables.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class lc3_env_configuration 
extends uvmf_environment_configuration_base;

  `uvm_object_utils( lc3_env_configuration )


//Constraints for the configuration variables:


  covergroup lc3_configuration_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    // pragma uvmf custom covergroup end
  endgroup

typedef fetch_env_configuration fetch_env_config_t;
rand fetch_env_config_t fetch_env_config;

typedef decode_env_configuration decode_env_config_t;
rand decode_env_config_t decode_env_config;

typedef execute_env_configuration execute_env_config_t;
rand execute_env_config_t execute_env_config;

typedef mem_access_env_configuration mem_access_env_config_t;
rand mem_access_env_config_t mem_access_env_config;

typedef control_env_configuration control_env_config_t;
rand control_env_config_t control_env_config;

typedef writeback_env_configuration writeback_env_config_t;
rand writeback_env_config_t writeback_env_config;


    typedef imem_configuration imem_agent_config_t;
    rand imem_agent_config_t imem_agent_config;

    typedef data_mem_configuration data_mem_agent_config_t;
    rand data_mem_agent_config_t data_mem_agent_config;


    string                fetch_env_interface_names[];
    uvmf_active_passive_t fetch_env_interface_activity[];
    string                decode_env_interface_names[];
    uvmf_active_passive_t decode_env_interface_activity[];
    string                execute_env_interface_names[];
    uvmf_active_passive_t execute_env_interface_activity[];
    string                mem_access_env_interface_names[];
    uvmf_active_passive_t mem_access_env_interface_activity[];
    string                control_env_interface_names[];
    uvmf_active_passive_t control_env_interface_activity[];
    string                writeback_env_interface_names[];
    uvmf_active_passive_t writeback_env_interface_activity[];


  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(lc3_env_configuration)) lc3_vsqr_t;
  lc3_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
// This function constructs the configuration object for each agent in the environment.
//
  function new( string name = "" );
    super.new( name );

   fetch_env_config = fetch_env_config_t::type_id::create("fetch_env_config");
   decode_env_config = decode_env_config_t::type_id::create("decode_env_config");
   execute_env_config = execute_env_config_t::type_id::create("execute_env_config");
   mem_access_env_config = mem_access_env_config_t::type_id::create("mem_access_env_config");
   control_env_config = control_env_config_t::type_id::create("control_env_config");
   writeback_env_config = writeback_env_config_t::type_id::create("writeback_env_config");

    imem_agent_config = imem_agent_config_t::type_id::create("imem_agent_config");
    data_mem_agent_config = data_mem_agent_config_t::type_id::create("data_mem_agent_config");


    lc3_configuration_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that configuration variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")

  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
// FUNCTION : set_vsqr()
// This function is used to assign the vsqr handle.
  virtual function void set_vsqr( lc3_vsqr_t vsqr);
     this.vsqr = vsqr;
  endfunction : set_vsqr

// ****************************************************************************
// FUNCTION: post_randomize()
// This function is automatically called after the randomize() function 
// is executed.
//
  function void post_randomize();
    super.post_randomize();
    // pragma uvmf custom post_randomize begin
    // pragma uvmf custom post_randomize end
  endfunction
  
// ****************************************************************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for
// logfile reporting. This function concatenates the convert2string result for
// each agent configuration in this configuration class.
//
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    return {
     
     "\n", imem_agent_config.convert2string,
     "\n", data_mem_agent_config.convert2string,
     "\n", fetch_env_config.convert2string,
     "\n", decode_env_config.convert2string,
     "\n", execute_env_config.convert2string,
     "\n", mem_access_env_config.convert2string,
     "\n", control_env_config.convert2string,
     "\n", writeback_env_config.convert2string

       };
    // pragma uvmf custom convert2string end
  endfunction
// ****************************************************************************
// FUNCTION: initialize();
// This function configures each interface agents configuration class.  The 
// sim level determines the active/passive state of the agent.  The environment_path
// identifies the hierarchy down to and including the instantiation name of the
// environment for this configuration class.  Each instance of the environment 
// has its own configuration class.  The string interface names are used by 
// the agent configurations to identify the virtual interface handle to pull from
// the uvm_config_db.  
//
  function void initialize(uvmf_sim_level_t sim_level, 
                                      string environment_path,
                                      string interface_names[],
                                      uvm_reg_block register_model = null,
                                      uvmf_active_passive_t interface_activity[] = {}
                                     );

    super.initialize(sim_level, environment_path, interface_names, register_model, interface_activity);

  // Interface initialization for sub-environments
    fetch_env_interface_names    = new[2];
    fetch_env_interface_activity = new[2];

    fetch_env_interface_names     = interface_names[0:1];
    fetch_env_interface_activity  = interface_activity[0:1];
    decode_env_interface_names    = new[2];
    decode_env_interface_activity = new[2];

    decode_env_interface_names     = interface_names[2:3];
    decode_env_interface_activity  = interface_activity[2:3];
    execute_env_interface_names    = new[2];
    execute_env_interface_activity = new[2];

    execute_env_interface_names     = interface_names[4:5];
    execute_env_interface_activity  = interface_activity[4:5];
    mem_access_env_interface_names    = new[2];
    mem_access_env_interface_activity = new[2];

    mem_access_env_interface_names     = interface_names[6:7];
    mem_access_env_interface_activity  = interface_activity[6:7];
    control_env_interface_names    = new[2];
    control_env_interface_activity = new[2];

    control_env_interface_names     = interface_names[8:9];
    control_env_interface_activity  = interface_activity[8:9];
    writeback_env_interface_names    = new[2];
    writeback_env_interface_activity = new[2];

    writeback_env_interface_names     = interface_names[10:11];
    writeback_env_interface_activity  = interface_activity[10:11];


  // Interface initialization for local agents
     imem_agent_config.initialize( interface_activity[12], {environment_path,".imem_agent"}, interface_names[12]);
     imem_agent_config.initiator_responder = RESPONDER;
     // imem_agent_config.has_coverage = 1;
     data_mem_agent_config.initialize( interface_activity[13], {environment_path,".data_mem_agent"}, interface_names[13]);
     data_mem_agent_config.initiator_responder = RESPONDER;
     // data_mem_agent_config.has_coverage = 1;


     fetch_env_config.initialize( sim_level, {environment_path,".fetch_env"}, fetch_env_interface_names, null,   fetch_env_interface_activity);
     decode_env_config.initialize( sim_level, {environment_path,".decode_env"}, decode_env_interface_names, null,   decode_env_interface_activity);
     execute_env_config.initialize( sim_level, {environment_path,".execute_env"}, execute_env_interface_names, null,   execute_env_interface_activity);
     mem_access_env_config.initialize( sim_level, {environment_path,".mem_access_env"}, mem_access_env_interface_names, null,   mem_access_env_interface_activity);
     control_env_config.initialize( sim_level, {environment_path,".control_env"}, control_env_interface_names, null,   control_env_interface_activity);
     writeback_env_config.initialize( sim_level, {environment_path,".writeback_env"}, writeback_env_interface_names, null,   writeback_env_interface_activity);



  // pragma uvmf custom initialize begin
  // pragma uvmf custom initialize end

  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

