proptest <- function(x, n, p, alternative){
  Se <- sqrt(p*(1-p)/n)
  u <- (x/n-p)/Se
  if(alternative=="twoside")
    p <- 2*(1-pnorm(abs(u)))
  else if(alternative=="less")
    p <- pnorm(u)
  else
    p <- 1-pnorm(u)
  return(list(u<-u, p<-p))
}
proptest(445, 500, 0.85, alternative="twoside")
