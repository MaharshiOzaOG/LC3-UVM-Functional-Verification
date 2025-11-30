#!/bin/bash

export QUESTA_HOME=/mnt/apps/public/COE/mg_apps/questa2025.1_1/questasim 

echo "Starting UVMF Simulation..."
echo "UVMF_HOME: $UVMF_HOME"
echo "QUESTA_HOME: $QUESTA_HOME"

# 5. Run the UVMF Build/Compile/Run script
python3.9 $UVMF_HOME/scripts/uvmf_bcr.py questa live:True enable_trlog:True use_vis_uvm:True