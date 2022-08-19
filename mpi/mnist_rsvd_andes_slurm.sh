#!/bin/bash
#SBATCH -J hello
#SBATCH -A CSC489
#SBATCH -p batch
#SBATCH --nodes=4
#SBATCH --mem=0
#SBATCH -t 00:00:10
#SBATCH -e ./hello.e
#SBATCH -o ./hello.o
#SBATCH --open-mode=truncate
#SBATCH --reservation=ost_96
## above reservation valid only during workshop on andes (remove elsewhere)

## assumes this repository was cloned in your home area
cd ~/R4HPC/mpi
pwd

## modules are specific to andes.olcf.ornl.gov
module load openblas/0.3.17-omp
module load flexiblas
flexiblas add OpenBLAS $OLCF_OPENBLAS_ROOT/lib/libopenblas.so
export LD_PRELOAD=$OLCF_FLEXIBLAS_ROOT/lib64/libflexiblas.so
export UCX_LOG_LEVEL=error  # no UCX warn messages

module load r
echo -e "loaded R with FlexiBLAS"
module list

time Rscript mnist_rsvd.R
time mpirun --map-by ppr:1:node Rscript mnist_rsvd.R
time mpirun --map-by ppr:2:node Rscript mnist_rsvd.R
time mpirun --map-by ppr:4:node Rscript mnist_rsvd.R
time mpirun --map-by ppr:8:node Rscript mnist_rsvd.R






