library(cop, quiet = TRUE)

rank = comm.rank()
size = comm.size()

rows = 3
cols = 3
xb = matrix((1:(rows*cols*size))^2, ncol = cols) # a full matrix
xa = xb[(1:rows) + rank*rows, ]  # split by row blocks

comm.print(xa, all.rank = TRUE)
comm.print(xb)

## compute usual QR from full matrix
rb = qr.R(qr(xb))
comm.print(rb) 

## compute QR from gathered local QRs
rloc = qr.R(qr(xa))  # compute local QRs
rra = allgather(rloc)  # gather them into a list
rra = do.call(rbind, rra)  # rbind list elements
comm.print(rra)  # print combined local QRs
ra = qr.R(qr(rra)) # QR the combined local QRs
comm.print(ra)

## use cop package to do it again via qr_allreduce
ra = qr_allreduce(xa)
comm.print(ra)

finalize()
