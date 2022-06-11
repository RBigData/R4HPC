library( pbdMPI, quiet = TRUE )

comm.set.seed( seed = 1234567, diff = TRUE )

## Generate 10 rows and 3 columns of data per process
my.X <- matrix( rnorm(10*3), ncol = 3 )

## Compute mean
N <- allreduce( nrow( my.X ), op = "sum" )
mu <- allreduce( colSums( my.X ) / N, op = "sum" )

## Sweep out mean and compute crossproducts sum
my.X <- sweep( my.X, STATS = mu, MARGIN = 2 )
Cov.X <- allreduce( crossprod( my.X ), op = "sum" ) / ( N - 1 )

comm.print( Cov.X )

finalize()
