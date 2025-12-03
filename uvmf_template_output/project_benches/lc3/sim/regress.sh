#!/bin/bash
module load questa
make clean
make cli TEST_NAME=alu_seq_test TEST_SEED=368284781
cp transcript transcript_alu_seq_test
make run_cli TEST_NAME=control_seq_test TEST_SEED=3368036630
cp transcript transcript_control_seq_test
make run_cli TEST_NAME=memory_seq_test TEST_SEED=2023179633
cp transcript transcript_memory_seq_test
make merge_coverage
make view_coverage