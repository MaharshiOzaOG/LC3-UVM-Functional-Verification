make clean
make cli TEST_NAME=alu_seq_test CODE_COVERAGE_ENABLE=1 UVM_VERBOSITY=UVM_MEDIUM BATCH_DO_COMMANDS='-do "set NoQuitOnFinish 1; run -all; coverage attribute -name TESTNAME -value $(TEST_NAME).$(TEST_SEED); coverage save $(TEST_NAME).$(TEST_SEED).ucdb; quit -f"'
cp transcript transcript_alu_seq_test
make run_cli TEST_NAME=control_seq_test  CODE_COVERAGE_ENABLE=1 UVM_VERBOSITY=UVM_MEDIUM BATCH_DO_COMMANDS='-do "set NoQuitOnFinish 1; run -all; coverage attribute -name TESTNAME -value $(TEST_NAME).$(TEST_SEED); coverage save $(TEST_NAME).$(TEST_SEED).ucdb; quit -f"'
cp transcript transcript_control_seq_test
make run_cli TEST_NAME=memory_seq_test CODE_COVERAGE_ENABLE=1 UVM_VERBOSITY=UVM_MEDIUM BATCH_DO_COMMANDS='-do "set NoQuitOnFinish 1; run -all; coverage attribute -name TESTNAME -value $(TEST_NAME).$(TEST_SEED); coverage save $(TEST_NAME).$(TEST_SEED).ucdb; quit -f"'
cp transcript transcript_memory_seq_test
make merge_coverage
make view_coverage