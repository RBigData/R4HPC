library( pbdMPI, quiet = TRUE )

k <- get.jid( 10 )   # note: pbdIO has comm.chunk()
my.rank <- comm.rank()
comm.cat( my.rank, ":", k, "\n", all.rank = TRUE, quiet = TRUE )

finalize()
