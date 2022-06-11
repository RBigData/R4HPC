library( pbdMPI, quiet = TRUE )

text <- paste( "Hello, world from", comm.rank() )
print( text )

finalize()
