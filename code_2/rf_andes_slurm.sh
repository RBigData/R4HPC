#!/bin/bash
#SBATCH -J rf
#SBATCH -A ccsd
#SBATCH -p burst
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --ntasks-per-node=1
#SBATCH -t 00:40:00
#SBATCH --mem=120G
#SBATCH -e ./rf.e
#SBATCH -o ./rf.o

cd ~/ROBUST2022/code
pwd

module load PE-gnu/4.0
module load R/4.1
echo "loaded R"
module list

time Rscript rf_serial.r
time Rscript rf_mc.r --args 1
#time Rscript rf_mc.r --args 2
#time Rscript rf_mc.r --args 4
#time Rscript rf_mc.r --args 8
#time Rscript rf_mc.r --args 16
#time Rscript rf_mc.r --args 32
#time Rscript rf_mc.r --args 64

