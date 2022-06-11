library( pbdMPI, quiet = TRUE )

if ( comm.rank() == 0 ){
  x <- matrix( 1:4, nrow = 2 )
} else {
  x <- NULL
}

y <- bcast( x )

comm.print( y, all.rank = TRUE )
comm.print( x, all.rank = TRUE )

finalize()
