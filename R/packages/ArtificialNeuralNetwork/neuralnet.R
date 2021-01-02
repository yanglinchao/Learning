data(infert, package = "datasets")
str(infert)

library(neuralnet)
infert$education <- as.numeric(infert$education)
formula <- education ~ age + parity + induced + spontaneous

train_nrow <- sample(nrow(infert), 200)
trainData <- infert[train_nrow, ]
testData <- infert[-train_nrow, ]
net.infert <- neuralnet(formula = formula, data = trainData, hidden = 4, algorithm = "backprop", linear.output = FALSE, likelihood = TRUE, learningrate = 0.03)
plot(net.infert)

pre <- compute(net.infert, testData[ , c("age", "parity", "induced", "spontaneous")], rep = 1)
pre.result <- pre$net.result
