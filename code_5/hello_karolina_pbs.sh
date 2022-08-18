#!/bin/bash
#PBS -N hello
#PBS -l select=1:ncpus=32
#PBS -l walltime=00:05:00
#PBS -q qexp
#PBS -e hello.e
#PBS -o hello.o

cd ~/R4HPC/code_5
pwd

module load R
echo "loaded R"

mpirun --map-by ppr:32:node Rscript hello_world.R
