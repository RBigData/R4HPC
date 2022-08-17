#!/bin/bash
#SBATCH -J rf
#SBATCH -A ccsd
#SBATCH -p burst
#SBATCH --nodes=1
#SBATCH -t 00:40:00
#SBATCH --mem=0
#SBATCH -e ./rf.e
#SBATCH -o ./rf.o
#SBATCH --open-mode=truncate

cd ~/R4HPC/code_2
pwd

## modules are specific to andes.olcf.ornl.gov
module load openblas/0.3.17-omp
module load flexiblas
flexiblas add OpenBLAS $OLCF_OPENBLAS_ROOT/lib/libopenblas.so
export LD_PRELOAD=$OLCF_FLEXIBLAS_ROOT/lib64/libflexiblas.so
module load r
echo -e "loaded R with FlexiBLAS"
module list

time Rscript rf_serial.r
time Rscript rf_mc.r --args 1
time Rscript rf_mc.r --args 2
time Rscript rf_mc.r --args 4
time Rscript rf_mc.r --args 8
time Rscript rf_mc.r --args 16
time Rscript rf_mc.r --args 32
time Rscript rf_mc.r --args 64

