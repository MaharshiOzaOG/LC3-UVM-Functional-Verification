//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the mem_access_out interface signals.
//      It is instantiated once per mem_access_out bus.  Bus Functional Models, 
//      BFM's named mem_access_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named mem_access_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(mem_access_out_bus.dmem_addr), // Agent input 
// .dut_signal_port(mem_access_out_bus.dmem_din), // Agent input 
// .dut_signal_port(mem_access_out_bus.dmem_rd), // Agent input 
// .dut_signal_port(mem_access_out_bus.memout), // Agent input 

import uvmf_base_pkg_hdl::*;
import mem_access_out_pkg_hdl::*;

interface  mem_access_out_if 

  (
  input tri clk, 
  input tri rst,
  inout tri [15:0] dmem_addr,
  inout tri [15:0] dmem_din,
  inout tri  dmem_rd,
  inout tri [15:0] memout
  );

modport monitor_port 
  (
  input clk,
  input rst,
  input dmem_addr,
  input dmem_din,
  input dmem_rd,
  input memout
  );

modport initiator_port 
  (
  input clk,
  input rst,
  input dmem_addr,
  input dmem_din,
  input dmem_rd,
  input memout
  );

modport responder_port 
  (
  input clk,
  input rst,  
  output dmem_addr,
  output dmem_din,
  output dmem_rd,
  output memout
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

