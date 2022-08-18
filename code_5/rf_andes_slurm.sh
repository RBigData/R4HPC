#!/bin/bash
#SBATCH -J rf
#SBATCH -A CSC143
#SBATCH -p batch
#SBATCH --nodes=1
#SBATCH -t 00:40:00
#SBATCH --mem=0
#SBATCH -e ./rf.e
#SBATCH -o ./rf.o
#SBATCH --open-mode=truncate
#SBATCH --reservation=ost_96
## above reservation valid only during workshop on andes (remove elsewhere)

cd ~/R4HPC/code_5
pwd

## modules are specific to andes.olcf.ornl.gov
module load openblas/0.3.17-omp
module load flexiblas
flexiblas add OpenBLAS $OLCF_OPENBLAS_ROOT/lib/libopenblas.so
export LD_PRELOAD=$OLCF_FLEXIBLAS_ROOT/lib64/libflexiblas.so
module load r
echo -e "loaded R with FlexiBLAS"
module list

time Rscript ../code_2/rf_serial.R
time mpirun --map-by ppr:1:node Rscript rf_mpi.R
time mpirun --map-by ppr:2:node Rscript rf_mpi.R
time mpirun --map-by ppr:4:node Rscript rf_mpi.R
time mpirun --map-by ppr:8:node Rscript rf_mpi.R
time mpirun --map-by ppr:16:node Rscript rf_mpi.R
time mpirun --map-by ppr:32:node Rscript rf_mpi.R
