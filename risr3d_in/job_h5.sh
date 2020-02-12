#!/bin/bash -l

# to use Buyin  #-P burbsp #-l buyin

#$ -l h_rt=1:00:00

# this is total per-node RAM
#$ -l mem_per_core=3G

# MPI
#$ -pe mpi_8_tasks_per_node 24

echo "NSLOTS = $NSLOTS"

. $HOME/gcccompilers.sh

cd /projectnb/semetergrp/gemcap

$MPI_ROOT/bin/mpiexec -np 24 ../gemini/build_budge_h5/gemini.bin risr3d_in/config_hdf5.nml ../gemini_sim/risr3d_in
