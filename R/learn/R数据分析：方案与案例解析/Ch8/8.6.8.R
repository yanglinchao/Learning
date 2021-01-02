x <- scan(file = "8.6.8.txt")
X <- matrix(x, 8)
X
friedman.test(X)