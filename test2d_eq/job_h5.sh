#!/bin/bash -l

# to use Buyin  #-P burbsp #-l buyin

#$ -l h_rt=2:00:00

# this is total per-node RAM
#$ -l mem_per_core=3G

# MPI
#$ -pe mpi_8_tasks_per_node 16

echo "NSLOTS = $NSLOTS"

. $HOME/gcccompilers.sh

cd /projectnb/semetergrp/gemini

python job.py initialize/test2d_eq/config.nml ../gemini_sim/test2d_eq -gemexe=build_budge_h5/gemini.bin
