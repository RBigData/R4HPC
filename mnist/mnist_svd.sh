#!/bin/bash
#PBS -N mnist_svd
#PBS -l select=1:ncpus=128,walltime=00:50:00
#PBS -q qexp
#PBS -e mnist_svd.e
#PBS -o mnist_svd.o

cd ~/ROBUST2022/mnist
pwd

module load R
echo "loaded R"

time Rscript mnist_svd.R


