library( pbdMPI, quiet = TRUE )

print( "Hello, world print" )

comm.print( "Hello, world comm.print" )

comm.print( "Hello from all", all.rank = TRUE, quiet = TRUE )

finalize()
