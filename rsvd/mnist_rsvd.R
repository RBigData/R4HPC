source("mnist_read_mpi.R") # reads blocks of rows
suppressMessages(library(pbdDMAT))
suppressMessages(library(pbdML))
init.grid()

## construct block-cyclic ddmatrix
bldim = c(allreduce(nrow(my_train), op = "max"), ncol(my_train))
gdim = c(allreduce(nrow(my_train), op = "sum"), ncol(my_train))
dmat_train = new("ddmatrix", Data = my_train, dim = gdim, 
                 ldim = dim(my_train), bldim = bldim, ICTXT = 2)
cyclic_train = as.blockcyclic(dmat_train)

comm.print(comm.size())
t1 = as.numeric(Sys.time())
rsvd_train = rsvd(cyclic_train, k = 10, q = 3, retu = FALSE, retvt = TRUE)
t2 = as.numeric(Sys.time())
t1 = allreduce(t1, op = "min")
t2 = allreduce(t2, op = "max")
comm.cat("Time:", t2 - t1, "seconds\n")
comm.cat("dim(V):", dim(rsvd_train$vt), "\n")

comm.cat("rsvd top 10 singular values:", rsvd_train$d, "\n")

finalize()
