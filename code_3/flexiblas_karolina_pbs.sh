#!/bin/bash
#PBS -N fx
#PBS -l select=1:ncpus=128,walltime=00:50:00
#PBS -q qexp
#PBS -e fx.e
#PBS -o fx.o

cd ~/R4HPC/code_3
pwd

module load R
echo "loaded R"

time Rscript flexiblas_bench2.R

