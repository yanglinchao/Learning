result <- matrix(nrow = 9, ncol = 9)
num <- 1:9
for(i in 1:9){
  multiplication <- num*1
  result[ , i] <- multiplication
}
print(result)