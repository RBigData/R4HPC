### Compute pi by simulaton
library( pbdMPI, quiet = TRUE )

comm.set.seed( seed = 1234567, diff = TRUE )

my.N <- 1e7 %/% comm.size()
my.X <- matrix( runif( my.N * 2 ), ncol = 2 )
my.r <- sum( rowSums( my.X^2 ) <= 1 )
r <- allreduce( my.r )
PI <- 4*r / ( my.N * comm.size() )
comm.print( PI )

finalize()
