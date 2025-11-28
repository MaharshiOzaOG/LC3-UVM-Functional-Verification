 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { fetch_env_agent_in }
wave add uvm_test_top.environment.fetch_env.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group fetch_env_agent_in_bus
wave add -group fetch_env_agent_in_bus hdl_top.fetch_env_agent_in_bus.* -radix hexadecimal -tag F0
wave group fetch_env_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_env_agent_out }
wave add uvm_test_top.environment.fetch_env.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group fetch_env_agent_out_bus
wave add -group fetch_env_agent_out_bus hdl_top.fetch_env_agent_out_bus.* -radix hexadecimal -tag F0
wave group fetch_env_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_agent_in }
wave add uvm_test_top.environment.decode_env.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group decode_env_agent_in_bus
wave add -group decode_env_agent_in_bus hdl_top.decode_env_agent_in_bus.* -radix hexadecimal -tag F0
wave group decode_env_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_agent_out }
wave add uvm_test_top.environment.decode_env.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group decode_env_agent_out_bus
wave add -group decode_env_agent_out_bus hdl_top.decode_env_agent_out_bus.* -radix hexadecimal -tag F0
wave group decode_env_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_agent_in }
wave add uvm_test_top.environment.execute_env.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group execute_env_agent_in_bus
wave add -group execute_env_agent_in_bus hdl_top.execute_env_agent_in_bus.* -radix hexadecimal -tag F0
wave group execute_env_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_agent_out }
wave add uvm_test_top.environment.execute_env.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group execute_env_agent_out_bus
wave add -group execute_env_agent_out_bus hdl_top.execute_env_agent_out_bus.* -radix hexadecimal -tag F0
wave group execute_env_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { mem_access_env_agent_in }
wave add uvm_test_top.environment.mem_access_env.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group mem_access_env_agent_in_bus
wave add -group mem_access_env_agent_in_bus hdl_top.mem_access_env_agent_in_bus.* -radix hexadecimal -tag F0
wave group mem_access_env_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { mem_access_env_agent_out }
wave add uvm_test_top.environment.mem_access_env.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group mem_access_env_agent_out_bus
wave add -group mem_access_env_agent_out_bus hdl_top.mem_access_env_agent_out_bus.* -radix hexadecimal -tag F0
wave group mem_access_env_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_agent_in }
wave add uvm_test_top.environment.control_env.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group control_env_agent_in_bus
wave add -group control_env_agent_in_bus hdl_top.control_env_agent_in_bus.* -radix hexadecimal -tag F0
wave group control_env_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_agent_out }
wave add uvm_test_top.environment.control_env.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group control_env_agent_out_bus
wave add -group control_env_agent_out_bus hdl_top.control_env_agent_out_bus.* -radix hexadecimal -tag F0
wave group control_env_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_agent_in }
wave add uvm_test_top.environment.writeback_env.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group writeback_env_agent_in_bus
wave add -group writeback_env_agent_in_bus hdl_top.writeback_env_agent_in_bus.* -radix hexadecimal -tag F0
wave group writeback_env_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_agent_out }
wave add uvm_test_top.environment.writeback_env.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group writeback_env_agent_out_bus
wave add -group writeback_env_agent_out_bus hdl_top.writeback_env_agent_out_bus.* -radix hexadecimal -tag F0
wave group writeback_env_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { imem_agent }
wave add uvm_test_top.environment.imem_agent.imem_agent_monitor.txn_stream -radix string -tag F0
wave group imem_agent_bus
wave add -group imem_agent_bus hdl_top.imem_agent_bus.* -radix hexadecimal -tag F0
wave group imem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { data_mem_agent }
wave add uvm_test_top.environment.data_mem_agent.data_mem_agent_monitor.txn_stream -radix string -tag F0
wave group data_mem_agent_bus
wave add -group data_mem_agent_bus hdl_top.data_mem_agent_bus.* -radix hexadecimal -tag F0
wave group data_mem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

