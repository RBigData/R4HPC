library( pbdMPI, quiet = TRUE )

comm.set.seed( seed = 1234567, diff = TRUE )

my_rank = comm.rank()
n <- sample( 1:10, size = my_rank + 1 )
names(n) = paste0("a", 1:(my_rank + 1))
comm.print(n, all.rank = TRUE)

gt <- gather( n )

comm.print( unlist( gt ), all.rank = TRUE )

finalize()
