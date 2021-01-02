N <- 1e7
data <- sample(1:30, size = N, replace = T)
system.time({
  data_sq1 <- numeric(N)
  for(j in 1:N){
    data_sq1[j] <- data[j]^2
  }
})
system.time(data_sq2 <- data^2)

data <- rnorm(1e4*1000)
dim(data) <- c(1e4, 1000)
system.time(data_sum1 <- apply(data, 1, sum))
system.time(data_sum2 <- rowSums(data))

N <- 1e4
data_series1 <- 1
system.time({
  for(j in 2:N){
    data_series1 <- c(data_series1, 
                      data_series1[j-1] + sample(-5:5, size = 1))
  }
})
data_series2 <- numeric(N)
data_series2[1] <- 1
system.time({
  for(j in 2:N){
    data_series2[j] <- data_series2[j-1] + sample(-5:5, size = 1)
  }
})

data <- rnorm(1e4*1000)
dim(data) <- c(1e4, 1000)
system.time(data_rs1 <- rowSums(data))
data_df <- data.frame(data)
system.time(data_rs2 <- rowSums(data_df))

data <- rnorm(1e5*1000)
dim(data) <- c(1e5, 1000)
data_df <- data.frame(data)
system.time(rowSums(data_df[which(data_df$X100 > 0 & data_df$X500 < 0), ]))
system.time(rowSums(data_df[data_df$X100 > 0 & data_df$X500 < 0, ]))

mov.avg <- function(x, n = 20){
  total <- numeric(length(x) - n + 1)
  for(i in 1:n){
    total <- total + x[i:(length(x) - n + i)]
  }
  total/n
}
library(compiler)
mov.avg.compiled0 <- cmpfun(mov.avg, options = list(optimize = 0))
mov.avg.compiled1 <- cmpfun(mov.avg, options = list(optimize = 1))
mov.avg.compiled2 <- cmpfun(mov.avg, options = list(optimize = 2))
mov.avg.compiled3 <- cmpfun(mov.avg, options = list(optimize = 3))
library(microbenchmark)
x <- runif(100)
bench <- microbenchmark(mov.avg(x),
                        mov.avg.compiled0(x),
                        mov.avg.compiled1(x),
                        mov.avg.compiled2(x),
                        mov.avg.compiled3(x))
bench

library(compiler)
enableJIT(level = 3)
microbenchmark(mov.avg(x))
