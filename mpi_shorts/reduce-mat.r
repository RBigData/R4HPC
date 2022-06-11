library( pbdMPI, quiet = TRUE )

x <- matrix( 10*comm.rank() + (1:6), nrow = 2 )

comm.print( x, all.rank = TRUE )

z <- allreduce( x ) # knows it's a matrix

comm.print( z, all.rank = TRUE )

finalize()
