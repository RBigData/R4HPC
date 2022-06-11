dir = "/scratch/project/dd-21-42/data/mnist/"
## Data from:
## https://www.kaggle.com/benedictwilkinsai/mnist-hd5f0
## There is also a csv version
## https://www.kaggle.com/oddrationale/mnist-in-csv
## Requires kaggle log on
## 
library(rhdf5)
## read 60000 training images
h5tr = H5Fopen(paste0(dir, "train.hdf5"), flags="H5F_ACC_RDONLY")
train = as.double(h5tr$image)
dim(train) = c(28*28, 60000)
train = as.data.frame(t(train))  # Transpose needed: row major to col major
train_lab = factor(as.character(h5tr$label))

## read 10000 testing images
h5ts = H5Fopen(paste0(dir, "test.hdf5"), flags="H5F_ACC_RDONLY")
test = as.double(h5ts$image)
dim(test) = c(28*28, 10000)
test = as.data.frame(t(test))
test_lab = factor(as.character(h5ts$label))

## each image is an observation, so each row is an image
## image pixels are variables, so they are columns
## conversion as.double() is needed because original storage is raw bytes
## 