library(randomForest)
data(diamonds, package = "ggplot2")
library(pbdMPI)
comm.set.seed(seed = 7654321, diff = FALSE)

n = nrow(diamonds)
n_test = floor(0.5 * n)
i_test = sample.int(n, n_test)
train = diamonds[-i_test, ]
test = diamonds[i_test, ][get.jid(n_test), ]

comm.set.seed(seed = 1e6 * runif(1), diff = TRUE)
my.rf = randomForest(price ~ ., train, ntree = 100 %/% comm.size(), norm.votes = FALSE)
rf.all = allgather(my.rf)
rf.all = do.call(combine, rf.all)
pred = as.vector(predict(rf.all, test))

sse = sum((pred - test$price)^2)
comm.cat("MSE =", reduce(sse)/n_test, "\n")

finalize()
