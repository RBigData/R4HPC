suppressPackageStartupMessages(library(randomForest))
data(LetterRecognition, package = "mlbench")
library(pbdMPI, quiet = TRUE)                #<<
comm.set.seed(seed = 7654321, diff = FALSE)      #<<

n = nrow(LetterRecognition)
n_test = floor(0.2 * n)
i_test = sample.int(n, n_test)
train = LetterRecognition[-i_test, ]
test = LetterRecognition[i_test, ][comm.chunk(n_test, form = "vector"), ]    #<<

comm.set.seed(seed  = 1234, diff = TRUE)          #<<
my.rf = randomForest(lettr ~ ., train, ntree = comm.chunk(500), norm.votes = FALSE) #<<
rf.all = allgather(my.rf)                  #<<
rf.all = do.call(combine, rf.all)          #<<
pred = as.vector(predict(rf.all, test))

correct = allreduce(sum(pred == test$lettr))  #<<
comm.cat("Proportion Correct:", correct/(n_test), "\n")

finalize()          #<<
