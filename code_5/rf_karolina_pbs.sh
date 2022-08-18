#!/bin/bash
#PBS -N rf
#PBS -l select=1:ncpus=128
#PBS -l walltime=00:05:00
#PBS -q qexp
#PBS -e rf.e
#PBS -o rf.o

cd ~/R4HPC/code_2
pwd

module load R
echo "loaded R"

time Rscript rf_serial.r
time Rscript rf_mpi.r --args 1
time Rscript rf_mpi.r --args 2
time Rscript rf_mpi.r --args 4
time Rscript rf_mpi.r --args 8
time Rscript rf_mpi.r --args 16
time Rscript rf_mpi.r --args 32
