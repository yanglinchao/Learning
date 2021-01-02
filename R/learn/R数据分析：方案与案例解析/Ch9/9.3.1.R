x <- scan(file = "9.3.1.txt")
group <- c(rep(1, 11), rep(2, 9), rep(3,11))
oneway.test(x ~ group, var.equal = T)