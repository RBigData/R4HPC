## Read the MNIST data
source("mnist_read.R")

## Produces Rplots.pdf
## Plot 36 random images from test data
ivals = sample(nrow(train), 36)

for(i in ivals) {
  im = matrix(as.numeric(train[i, ]), nrow = 28, ncol = 28, byrow = TRUE)
  lab = paste("image", i, "digit", train_lab[i])
  image(im, xlab = lab)
}
