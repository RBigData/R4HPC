library( pbdMPI , quiet = TRUE)

## Your "Map" code
n <- comm.rank() + 1

## Now "Reduce" but give the result to all
all_sum <- allreduce( n ) # Sum is default

text <- paste( "Hello: n is", n, "sum is", all_sum )
comm.print( text, all.rank = TRUE )

finalize ()
