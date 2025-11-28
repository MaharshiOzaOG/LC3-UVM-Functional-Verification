//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the mem_access_in interface signals.
//      It is instantiated once per mem_access_in bus.  Bus Functional Models, 
//      BFM's named mem_access_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named mem_access_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(mem_access_in_bus.mem_state), // Agent output 
// .dut_signal_port(mem_access_in_bus.m_control), // Agent output 
// .dut_signal_port(mem_access_in_bus.m_addr), // Agent output 
// .dut_signal_port(mem_access_in_bus.m_data), // Agent output 
// .dut_signal_port(mem_access_in_bus.dmem_dout), // Agent output 

import uvmf_base_pkg_hdl::*;
import mem_access_in_pkg_hdl::*;

interface  mem_access_in_if 

  (
  input tri clk, 
  input tri rst,
  inout tri [1:0] mem_state,
  inout tri  m_control,
  inout tri [15:0] m_addr,
  inout tri [15:0] m_data,
  inout tri [15:0] dmem_dout
  );

modport monitor_port 
  (
  input clk,
  input rst,
  input mem_state,
  input m_control,
  input m_addr,
  input m_data,
  input dmem_dout
  );

modport initiator_port 
  (
  input clk,
  input rst,
  output mem_state,
  output m_control,
  output m_addr,
  output m_data,
  output dmem_dout
  );

modport responder_port 
  (
  input clk,
  input rst,  
  input mem_state,
  input m_control,
  input m_addr,
  input m_data,
  input dmem_dout
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

