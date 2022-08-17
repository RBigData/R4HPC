#!/bin/bash
#SBATCH -J package
#SBATCH -A CSC489
#SBATCH -p batch
#SBATCH --nodes=1
#SBATCH --mem=0
#SBATCH -t 00:05:00
#SBATCH -e ./package.e
#SBATCH -o ./package.o
#SBATCH --open-mode=truncate
#SBATCH --reservation=ost_96
## above reservation valid only during workshop on andes (remove elsewhere)

## above we request 4 nodes and all memory on the nodes

## assumes this repository was cloned in your home area
cd ~/R4HPC/code_0
pwd

## modules are specific to andes.olcf.ornl.gov
module load openblas/0.3.17-omp
module load flexiblas
flexiblas add OpenBLAS $OLCF_OPENBLAS_ROOT/lib/libopenblas.so
export LD_PRELOAD=$OLCF_FLEXIBLAS_ROOT/lib64/libflexiblas.so
module load r
echo -e "loaded R with FlexiBLAS"
module list

Rscript package_installs.R
