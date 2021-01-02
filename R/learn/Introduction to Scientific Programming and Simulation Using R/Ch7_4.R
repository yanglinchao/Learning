curve(100*(x^3-x^2)+15, from = 0, to = 1,
      xlab = expression(alpha),
      ylab = expression(100 %*% (alpha^3 - alpha^2) + 15),
      main = expression(paste("Function : ",
                        f(alpha) == 100 %*% (alpha^3 - alpha^2) + 15)))

myMu <- 0.5
mySigma <- 0.25
par(usr = c(0, 1, 0, 1))
text(0.1, 0.1, bquote(sigma[alpha] == .(mySigma)), cex = 1.25)
text(0.6, 0.6, paste("(The mean is ", myMu, ")", sep = ""), cex = 1.25)
text(0.5, 0.9, bquote(paste("sigma^2 = ", sigma^2 == .(format(mySigma^2, 2)))))

