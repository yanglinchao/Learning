# test the accuracy of Simpson's rule
# using the integral of 1/x from 0.01 to 1

source("C://Users//ylc//nutstore//R-work//learn//Introduction to Scientific Programming and Simulation Using R//Ch11_2 simpson_n.R")

ftn <- function(x) return(1/x)
S <- function(n) simpson_n(ftn, 0.01, 1, n)

n.vec <- seq(10, 1000, by = 10)
S.vec <- sapply(n.vec, S)

opar <- par(mfrow = c(1, 2), pty = "s", mar = c(4, 4, 2, 1), las = 1)
plot(n.vec, S.vec + log(0.01), type = "l", xlab = "n", ylab = "error")
plot(log(n.vec), log(S.vec + log(0.01)), type = "l", xlab = "log(n)", ylab = "log(error)")
par(opar)