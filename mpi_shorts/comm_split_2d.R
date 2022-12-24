## Run with:
## mpiexec -np 32 Rscript comm_split8x4.R
##
## Splits a 32-rank communicator into 4 row-communicators of size 8 and
## othogonal to them 8 column communicators of size 4. Prints rank assignments,
## and demonstrates how sum collectives work in each set of communicators.
##
## Useful row ooperations or column operations on tile-distrobued matrices. But
## note there is package pbdDMAT that already has these operations powered by
## ScaLAPACK.
## It can also serve for any two levels of distributed parallelism that are
## nested.
##
library(pbdMPI)

ncol = 8
nrow = 4
if(comm.size() != ncol*nrow) stop("Error: Must run with -np 32")

## Get world communicator rank
comm_w = .pbd_env$SPMD.CT$comm # world communicator (normallly assigned 0)
rank_w = comm.rank(comm_w)  # world rank

## Split comm_w into ncol communicators of size nrow
comm_c = 5L               # assign them a number
color_c = rank_w %/% nrow # ranks of same color are in same communicator
comm.split(comm_w, color = color_c, key = rank_w, newcomm = comm_c)

## Split comm_w into nrow communicators of size ncol
comm_r = 6L               # assign them a number
color_r = rank_w %% nrow  # make these orthogonal to the row communicators
comm.split(comm_w, color = color_r, key = rank_w, newcomm = comm_r)

## Print the resulting communicator colors and ranks
comm.cat(comm.rank(comm = comm_w),
         paste0("(", color_r, ":", comm.rank(comm = comm_r), ")"),
         paste0("(", color_c, ":", comm.rank(comm = comm_c), ")"),
         "\n", all.rank = TRUE, quiet = TRUE, comm = comm_w)

## Print sums of rank numbers across each communicator to illustrate collectives
x = comm.rank(comm_w)
w = allreduce(x, op = "sum", comm = comm_w)
comm.cat(" ", w, all.rank = TRUE, quiet = TRUE)
comm.cat("\n", quiet = TRUE)

r = allreduce(x, op = "sum", comm = comm_r)
comm.cat(" ", r, all.rank = TRUE, quiet = TRUE)
comm.cat("\n", quiet = TRUE)

c = allreduce(x, op = "sum", comm = comm_c)
comm.cat(" ", c, all.rank = TRUE, quiet = TRUE)
comm.cat("\n", quiet = TRUE)


#comm.free(comm_c)
#comm.free(comm_r)

finalize()