#!/bin/bash
#PBS -N hello
#PBS -A DD-21-42
#PBS -l select=4:mpiprocs=16
#PBS -l walltime=00:00:10
#PBS -q qprod
#PBS -e hello.e
#PBS -o hello.o

cat $BASH_SOURCE 
cd ~/R4HPC/code_1
pwd

## module names can vary on different platforms
module load R
echo "loaded R"

## prevent warning when fork is used with MPI
export OMPI_MCA_mpi_warn_on_fork=0
export RDMAV_FORK_SAFE=1

# Fix for warnings from libfabric/1.12 on Karolina
module swap libfabric/1.12.1-GCCcore-10.3.0 libfabric/1.13.2-GCCcore-11.2.0 

time mpirun --map-by ppr:4:node Rscript hello_balance.R
