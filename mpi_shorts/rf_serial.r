### file "RF_example.r"
library(randomForest)
library(mlbench)
data(LetterRecognition)
set.seed(seed = 123)

n <- nrow(LetterRecognition)
n_test <- floor(0.2 * n)
i_test <- sample.int(n, n_test)
train <- LetterRecognition[-i_test,]
test <- LetterRecognition[i_test,]

rf.all <- randomForest(lettr ~ ., train, ntree = 500, norm.votes = FALSE)
pred <- predict(rf.all, test)

correct <- sum(pred == test$lettr)
cat("Proportion Correct:", correct/(n_test), "\n")
