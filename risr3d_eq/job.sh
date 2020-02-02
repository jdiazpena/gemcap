#!/bin/bash -l

#$ -P semetergrp

# to use Buyin  #-P burbsp #-l buyin

#$ -l h_rt=12:00:00

# this is total per-node RAM
#$ -l mem_per_core=3G

# send email status
#$ -m ea

# MPI
#$ -pe mpi_8_tasks_per_node 24

echo "NSLOTS = $NSLOTS"

. $HOME/gcccompilers.sh

cd /projectnb/semetergrp/gemcap

$MPI_ROOT/bin/mpiexec -np 24 ../gemini/build_budge/gemini.bin risr3d_in/config.nml ../gemini_sim/risr3d_in
