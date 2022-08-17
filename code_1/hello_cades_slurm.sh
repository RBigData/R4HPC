#!/bin/bash
#SBATCH -J hello
#SBATCH -A ccsd
#SBATCH -p batch
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=4
#SBATCH --mem=0
#SBATCH -t 00:00:10
#SBATCH -e ./hello.e
#SBATCH -o ./hello.o

## above we request 4 nodes and all memory on the nodes

cd ~/R4HPC/code_1
pwd

## modules are specific to or-slurm-login.ornl.gov (CADES SHPC condos)
source /software/cades-open/spack-envs/base/root/linux-centos7-x86_64/gcc-6.3.0/lmod-8.5.6-wdngv4jylfvg2j6jt7xrtugxggh5lpm5/lmod/lmod/init/bash
export MODULEPATH=/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core
module load gcc
module load openmpi
module load r/4.1.0-py3-X-flexiblas 
echo "loaded R with flexiblas"
module list

## above supplies your R code with FlexiBLAS-OpenBLAS on Andes
## but matrix computation is not used in the R illustration below

## prevent warning when fork is used with MPI
#export OMPI_MCA_mpi_warn_on_fork=0

# An illustration of fine control of R scripts and cores on several nodes
# This runs 4 R sessions on each of 4 nodes (for a total of 16).
#
# Each of the 16 hello_world.R scripts will calculate how many cores are
# available per R session from environment variables and use that many
# in mclapply.
# 
# NOTE: center policies may require dfferent parameters
#
# runs 4 R sessions per node
mpirun --map-by ppr:4:node Rscript hello_balance.R
