//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #9ns;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 0; 
    #200ns;
    rst =  1; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  fetch_in_if  fetch_env_agent_in_bus(
     // pragma uvmf custom fetch_env_agent_in_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom fetch_env_agent_in_bus_connections end
     );
  fetch_out_if  fetch_env_agent_out_bus(
     // pragma uvmf custom fetch_env_agent_out_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom fetch_env_agent_out_bus_connections end
     );
  decode_in_if  decode_env_agent_in_bus(
     // pragma uvmf custom decode_env_agent_in_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom decode_env_agent_in_bus_connections end
     );
  decode_out_if  decode_env_agent_out_bus(
     // pragma uvmf custom decode_env_agent_out_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom decode_env_agent_out_bus_connections end
     );
  execute_in_if  execute_env_agent_in_bus(
     // pragma uvmf custom execute_env_agent_in_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_agent_in_bus_connections end
     );
  execute_out_if  execute_env_agent_out_bus(
     // pragma uvmf custom execute_env_agent_out_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_agent_out_bus_connections end
     );
  mem_access_in_if  mem_access_env_agent_in_bus(
     // pragma uvmf custom mem_access_env_agent_in_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom mem_access_env_agent_in_bus_connections end
     );
  mem_access_out_if  mem_access_env_agent_out_bus(
     // pragma uvmf custom mem_access_env_agent_out_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom mem_access_env_agent_out_bus_connections end
     );
  control_in_if  control_env_agent_in_bus(
     // pragma uvmf custom control_env_agent_in_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom control_env_agent_in_bus_connections end
     );
  control_out_if  control_env_agent_out_bus(
     // pragma uvmf custom control_env_agent_out_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom control_env_agent_out_bus_connections end
     );
  writeback_in_if  writeback_env_agent_in_bus(
     // pragma uvmf custom writeback_env_agent_in_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom writeback_env_agent_in_bus_connections end
     );
  writeback_out_if  writeback_env_agent_out_bus(
     // pragma uvmf custom writeback_env_agent_out_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom writeback_env_agent_out_bus_connections end
     );
  imem_if  imem_agent_bus(
     // pragma uvmf custom imem_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom imem_agent_bus_connections end
     );
  data_mem_if  data_mem_agent_bus(
     // pragma uvmf custom data_mem_agent_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom data_mem_agent_bus_connections end
     );
  fetch_in_monitor_bfm  fetch_env_agent_in_mon_bfm(fetch_env_agent_in_bus);
  fetch_out_monitor_bfm  fetch_env_agent_out_mon_bfm(fetch_env_agent_out_bus);
  decode_in_monitor_bfm  decode_env_agent_in_mon_bfm(decode_env_agent_in_bus);
  decode_out_monitor_bfm  decode_env_agent_out_mon_bfm(decode_env_agent_out_bus);
  execute_in_monitor_bfm  execute_env_agent_in_mon_bfm(execute_env_agent_in_bus);
  execute_out_monitor_bfm  execute_env_agent_out_mon_bfm(execute_env_agent_out_bus);
  mem_access_in_monitor_bfm  mem_access_env_agent_in_mon_bfm(mem_access_env_agent_in_bus);
  mem_access_out_monitor_bfm  mem_access_env_agent_out_mon_bfm(mem_access_env_agent_out_bus);
  control_in_monitor_bfm  control_env_agent_in_mon_bfm(control_env_agent_in_bus);
  control_out_monitor_bfm  control_env_agent_out_mon_bfm(control_env_agent_out_bus);
  writeback_in_monitor_bfm  writeback_env_agent_in_mon_bfm(writeback_env_agent_in_bus);
  writeback_out_monitor_bfm  writeback_env_agent_out_mon_bfm(writeback_env_agent_out_bus);
  imem_monitor_bfm  imem_agent_mon_bfm(imem_agent_bus);
  data_mem_monitor_bfm  data_mem_agent_mon_bfm(data_mem_agent_bus);
  imem_driver_bfm  imem_agent_drv_bfm(imem_agent_bus);
  data_mem_driver_bfm  data_mem_agent_drv_bfm(data_mem_agent_bus);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
  verilog_dut         dut_verilog(   .clk(clk), .rst(rst), .in_signal(vhdl_to_verilog_signal), .out_signal(verilog_to_vhdl_signal));
  vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));
  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual fetch_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_agent_in_BFM , fetch_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_agent_out_BFM , fetch_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual decode_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_agent_in_BFM , decode_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual decode_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_agent_out_BFM , decode_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_agent_in_BFM , execute_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_agent_out_BFM , execute_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual mem_access_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , mem_access_env_agent_in_BFM , mem_access_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual mem_access_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , mem_access_env_agent_out_BFM , mem_access_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual control_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_agent_in_BFM , control_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual control_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_agent_out_BFM , control_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual writeback_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_agent_in_BFM , writeback_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual writeback_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_agent_out_BFM , writeback_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual imem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_mon_bfm ); 
    uvm_config_db #( virtual data_mem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , data_mem_agent_BFM , data_mem_agent_mon_bfm ); 
    uvm_config_db #( virtual imem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_drv_bfm  );
    uvm_config_db #( virtual data_mem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , data_mem_agent_BFM , data_mem_agent_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

