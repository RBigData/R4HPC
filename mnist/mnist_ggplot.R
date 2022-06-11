## Read the MNIST data
source("mnist_read.R")

## Produces Rplots.pdf
## Plot 36 random images from test data
ivals = sample(nrow(train), 36)

## with ggplot wrap
library(ggplot2)
image = rep(ivals, 28*28)
lab = rep(train_lab[ivals], 28*28)
image = factor(paste(image, lab, sep = ": "))
col = rep(rep(1:28, 28), each = length(ivals))
row = rep(rep(1:28, each = 28), each = length(ivals))
im = data.frame(image = image, row = row, col = col, 
                val = as.numeric(unlist(train[ivals, ])))
ggplot(im, aes(row, col, fill = val)) + geom_tile() + facet_wrap(~ image)
