## This script describes two levels of parallelism:
## Top level: Distributed MPI runs several copies of this entire script.
##            Instances differ by their comm.rank() designation.
## Inner level: The unix fork (copy-on-write) shared memory parallel execution
##            of the mc.function() managed by parallel::mclapply()
## Further levels are possible: multithreading in compiled code and communicator
## splitting at the distributed MPI level.

suppressMessages(library(pbdMPI))
comm.print(sessionInfo())

## get node name
host = system("hostname", intern = TRUE)

mc.function = function(x) {
    Sys.sleep(1) # replace with your function for mclapply cores here
    Sys.getpid() # returns process id
}

## Compute how many cores per R session are on this node
local_ranks_query = "echo $OMPI_COMM_WORLD_LOCAL_SIZE"
ranks_on_my_node = as.numeric(system(local_ranks_query, intern = TRUE))
cores_on_my_node = parallel::detectCores()
cores_per_R = floor(cores_on_my_node/ranks_on_my_node)
cores_total = allreduce(cores_per_R)  # adds up over ranks

## Run mclapply on allocated cores to demonstrate fork pids
my_pids = parallel::mclapply(1:cores_per_R, mc.function, mc.cores = cores_per_R)
my_pids = do.call(paste, my_pids) # combines results from mclapply
##
## Same cores are shared with OpenBLAS (see flexiblas package)
##            or for other OpenMP enabled codes outside mclapply.
## If BLAS functions are called inside mclapply, they compete for the
##            same cores: avoid or manage appropriately!!!

## Now report what happened and where
msg = paste0("Hello World from rank ", comm.rank(), " on host ", host,
             " with ", cores_per_R, " cores allocated\n",
             "            (", ranks_on_my_node, " R sessions sharing ",
             cores_on_my_node, " cores on this host node).\n",
             "      pid: ", my_pids, "\n")
comm.cat(msg, quiet = TRUE, all.rank = TRUE)


comm.cat("Total R sessions:", comm.size(), "Total cores:", cores_total, "\n",
         quiet = TRUE)
comm.cat("\nNotes: cores on node obtained by: detectCores {parallel}\n",
         "       ranks (R sessions) per node: OMPI_COMM_WORLD_LOCAL_SIZE\n",
         "       pid to core map changes frequently during mclapply\n",
         quiet = TRUE)

finalize()

