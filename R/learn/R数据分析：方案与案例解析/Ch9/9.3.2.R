weight <- c(30, 31, 32, 31, 36, 32, 27, 29, 28)
A <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
B <- c(1, 2, 3, 1, 2, 3, 1, 2, 3)
A <- factor(A); B <- factor(B)
weight.aov <- aov(weight ~ A + B)
summary(weight.aov)