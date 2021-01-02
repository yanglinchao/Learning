#3.3 for循环
x_list <- seq(1, 9, by = 2)
sum_x <- 0
for(x in x_list){
  sum_x <- sum_x + x
  cat("The current loop element is", x, "\n")
  cat("The cumulative total is", sum_x, "\n")
}

#3.3.3 养老金例子

#Inputs
r <- 0.11   #Annual interest rate
term <- 10   #Forecast duration (in years)
period <- 1/12   #Time between payments (in years)
payments <- 100   #Amount deposited each period

#Calculations
n <- floor(term/period)
pension <- 0
for(i in 1:n){
  pension[i+1] <- pension[i]*(1+r*period) + payments
}
plot(x = 1:length(pension), y = pension)

#3.4 while循环

#3.4.1 斐波那契数

X <- c(1, 1)
n <- 2
while(X[n] <= 100){
  X[n+1] <- X[n-1] + X[n]
  n <- n+1
}

#3.5 向量化编程
x <- c(-2, -1, 1, 2)
ifelse(x > 0, "Positive", "Negative")

pmax(c(2, 3), c(1, 4))
pmin(c(2, 3), c(1, 4))
