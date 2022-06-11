suppressMessages(library(rhdf5))
suppressMessages(library(pbdIO))
file = "/scratch/project/dd-21-42/data/mnist/train.hdf5"
dat1  = "image"
dat2  = "label"

## get and broadcast dimensions to all processors
if (comm.rank() == 0) {
   h5f = H5Fopen(file, flags="H5F_ACC_RDONLY")
   h5d = H5Dopen(h5f, dat1)
   h5s = H5Dget_space(h5d)
   dims = H5Sget_simple_extent_dims(h5s)$size
   H5Dclose(h5d)
   H5Fclose(h5f)
} else dims = NA
dims = bcast(dims) 

nlast = dims[length(dims)] # last dim moves slowest
my_ind = comm.chunk(nlast, form = "vector")

## parallel read of data columns
my_train = as.double(h5read(file, dat1, index = list(NULL, NULL, my_ind)))
my_train_lab = as.character(h5read(file, dat2, index = list(my_ind)))
H5close()

dim(my_train) = c(prod(dims[-length(dims)]), length(my_ind))
my_train = t(my_train)  # row-major write and column-major read

## plot for debugging
# if(comm.rank() == 0) {
#   ivals = sample(nrow(train), 36)
#   library(ggplot2)
#   image = rep(ivals, 28*28)
#   lab = rep(train_lab[ivals], 28*28)
#   image = factor(paste(image, lab, sep = ": "))
#   col = rep(rep(1:28, 28), each = length(ivals))
#   row = rep(rep(1:28, each = 28), each = length(ivals))
#   im = data.frame(image = image, row = row, col = col, 
#                   val = as.numeric(unlist(train[ivals, ])))
#   ggplot(im, aes(row, col, fill = val)) + geom_tile() + facet_wrap(~ image)
# }

## remove finalize if sourced in another script
# finalize()
