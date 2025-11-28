 

onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider fetch_env_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.fetch_env/agent_in/agent_in_monitor/txn_stream
add wave -noupdate -group fetch_env_agent_in_bus /hdl_top/fetch_env_agent_in_bus/*
add wave -noupdate -divider fetch_env_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.fetch_env/agent_out/agent_out_monitor/txn_stream
add wave -noupdate -group fetch_env_agent_out_bus /hdl_top/fetch_env_agent_out_bus/*
add wave -noupdate -divider decode_env_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.decode_env/agent_in/agent_in_monitor/txn_stream
add wave -noupdate -group decode_env_agent_in_bus /hdl_top/decode_env_agent_in_bus/*
add wave -noupdate -divider decode_env_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.decode_env/agent_out/agent_out_monitor/txn_stream
add wave -noupdate -group decode_env_agent_out_bus /hdl_top/decode_env_agent_out_bus/*
add wave -noupdate -divider execute_env_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.execute_env/agent_in/agent_in_monitor/txn_stream
add wave -noupdate -group execute_env_agent_in_bus /hdl_top/execute_env_agent_in_bus/*
add wave -noupdate -divider execute_env_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.execute_env/agent_out/agent_out_monitor/txn_stream
add wave -noupdate -group execute_env_agent_out_bus /hdl_top/execute_env_agent_out_bus/*
add wave -noupdate -divider mem_access_env_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.mem_access_env/agent_in/agent_in_monitor/txn_stream
add wave -noupdate -group mem_access_env_agent_in_bus /hdl_top/mem_access_env_agent_in_bus/*
add wave -noupdate -divider mem_access_env_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.mem_access_env/agent_out/agent_out_monitor/txn_stream
add wave -noupdate -group mem_access_env_agent_out_bus /hdl_top/mem_access_env_agent_out_bus/*
add wave -noupdate -divider control_env_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.control_env/agent_in/agent_in_monitor/txn_stream
add wave -noupdate -group control_env_agent_in_bus /hdl_top/control_env_agent_in_bus/*
add wave -noupdate -divider control_env_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.control_env/agent_out/agent_out_monitor/txn_stream
add wave -noupdate -group control_env_agent_out_bus /hdl_top/control_env_agent_out_bus/*
add wave -noupdate -divider writeback_env_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.writeback_env/agent_in/agent_in_monitor/txn_stream
add wave -noupdate -group writeback_env_agent_in_bus /hdl_top/writeback_env_agent_in_bus/*
add wave -noupdate -divider writeback_env_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.writeback_env/agent_out/agent_out_monitor/txn_stream
add wave -noupdate -group writeback_env_agent_out_bus /hdl_top/writeback_env_agent_out_bus/*
add wave -noupdate -divider imem_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment/imem_agent/imem_agent_monitor/txn_stream
add wave -noupdate -group imem_agent_bus /hdl_top/imem_agent_bus/*
add wave -noupdate -divider data_mem_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment/data_mem_agent/data_mem_agent_monitor/txn_stream
add wave -noupdate -group data_mem_agent_bus /hdl_top/data_mem_agent_bus/*



TreeUpdate [SetDefaultTree]
quietly wave cursor active 0
configure wave -namecolwidth 472
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {27 ns} {168 ns}

