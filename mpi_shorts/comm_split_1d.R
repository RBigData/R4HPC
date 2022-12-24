## Splits the world communicator into two sets of smaller communicators and
## demonstrates how a sum collective works 
library(pbdMPI)
.pbd_env$SPMD.CT
comm_world = .pbd_env$SPMD.CT$comm  # default communicator
my_rank = comm.rank(comm_world) # my default rank in world communicator
comm_new = 5L       # new communicators can be 5 and up (0-4 are taken)

row_color = my_rank %/% 2L # set new partition colors and split accordingly
comm.split(comm_world, color = row_color, key = my_rank, newcomm = comm_new)
barrier()
my_newrank = comm.rank(comm_new)
comm.cat("comm_world:", comm_world, "comm_new", comm_new, "row_color:",
         row_color, "my_rank:", my_rank, "my_newrank", my_newrank, "\n",
         all.rank = TRUE)
x = my_rank + 1
comm.cat("x", x, "\n", all.rank = TRUE, comm = comm_world)
xa = allreduce(x, comm = comm_world)
xb = allreduce(x, comm = comm_new)

comm.cat("xa", xa, "xb", xb, "\n", all.rank = TRUE, comm = comm_world)
comm.free(comm_new)


finalize()