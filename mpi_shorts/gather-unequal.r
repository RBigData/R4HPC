library( pbdMPI, quiet = TRUE )

comm.set.seed( seed = 1234567, diff = TRUE )

my_rank = comm.rank()
n <- sample( 1:10, size = my_rank + 1 )
comm.print(n, all.rank = TRUE)

gt = gather(n)

obj_len = gather(length(n))
comm.cat("gathered unequal size objects. lengths =", obj_len, "\n")

comm.print( unlist( gt ), all.rank = TRUE )

finalize()
