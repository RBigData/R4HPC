library( pbdMPI, quiet = TRUE )

my.rank <- comm.rank()
comm.print( my.rank, all.rank = TRUE )

finalize()
