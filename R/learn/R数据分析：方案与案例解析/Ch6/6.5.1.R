y<-function(x){
  ifelse(x>3, y<-2*x-0.5*x^2, y<-3*x+2)
}
y <- Vectorize(y)
curve(y, 0, 6)