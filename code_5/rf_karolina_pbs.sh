#!/bin/bash
#PBS -N rf
#PBS -l select=1:ncpus=32
#PBS -l walltime=00:05:00
#PBS -q qexp
#PBS -e rf.e
#PBS -o rf.o

cd ~/R4HPC/code_5
pwd

module load R
echo "loaded R"

time Rscript ../code_2/rf_serial.R
time mpirun --map-by ppr:1:node Rscript rf_mpi.R
time mpirun --map-by ppr:2:node Rscript rf_mpi.R
time mpirun --map-by ppr:4:node Rscript rf_mpi.R
time mpirun --map-by ppr:8:node Rscript rf_mpi.R
time mpirun --map-by ppr:16:node Rscript rf_mpi.R
time mpirun --map-by ppr:32:node Rscript rf_mpi.R
