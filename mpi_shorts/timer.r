library( pbdMPI, quiet = TRUE )

comm.set.seed( seed = 1234567, diff = T )

test <- function( timed )
{
  ltime <- system.time( timed )[ 3 ]

  mintime <- allreduce( ltime, op='min' )
  maxtime <- allreduce( ltime, op='max' )
  meantime <- allreduce( ltime, op='sum' ) / comm.size()

  return( data.frame( min = mintime, mean = meantime, max = maxtime ) )
}

# generate 10,000,000 random normal values (total)
times <- test( rnorm( 1e7/comm.size() ) ) # ~76 MiB of data
comm.print( times )

finalize()
