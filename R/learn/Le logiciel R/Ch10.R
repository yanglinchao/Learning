lambda <- 2   #创建一个标量
A <- matrix(c(2, 3, 5, 4), nrow = 2, ncol = 2)   #创建实矩阵A
A
B <- matrix(c(1, 2, 2, 7), nrow = 2, ncol = 2)   #创建实矩阵B
B
C <- matrix(c(1, 1i, -1i, 3), ncol = 2)   #Hermite复矩阵C
C
lambda + A
A + B
A - B
lambda * A
t(A)
Conj(A)   
A * B
A %*% B
A/B
solve(B)
A %*% solve(B)
crossprod(A, B)
x <- seq(1, 4); y <- seq(4, 7)   #x, y均为列向量
outer(x, y, FUN = "*")   #求列向量的外积
A <- matrix(1:4, nrow = 2); B = matrix(5:8, nrow = 2)
A
B
kronecker(A, B)
M <- matrix(1:16, nrow = 4)
lower.tri(M)
upper.tri(M, diag = TRUE)
M[lower.tri(M)] <- 0   #得到上三角矩阵
M
det(M)
sum(diag(M))
kappa(M, exact = TRUE)
scale(M, scale = FALSE)   #中心化
scale(M, center = FALSE, scale = apply(M, MARGIN = 2, FUN = sd))   #尺度化
eigen(M)
res <- svd(M)
res
all.equal(M, res$u %*% diag(res$d) %*% t(Conj(res$v)))
B <- matrix(c(1, 2, 2, 7), ncol = 2)
U <- chol(B)
L <- t(U)
U
all.equal(B, t(U) %*% U)
A <- matrix(c(2, 3, 7, 5), ncol = 2)
res <- qr(A)
Q <- qr.Q(res)
Q
R <- qr.R(res)
R
D(expression(sin(cos(x + y^2))), "x")   #对x微分
D(expression(sin(cos(x + y^2))), "y")   #对y微分
require(numDeriv)
f <- function(x) x^2
grad(f, c(2, 1, 3, 5))   #计算某几个点（标量）处的导数值
g <- function(x) x[1]*x[2]^2   #二元函数
grad(g, c(2, 1))   #计算一个单（矢量的）点处的导数值
hessian(g, c(2, 1))   #计算一个单（矢量的）点处的二阶导数值
h <- function(x, y) x*y^2   #二元函数
x <- c(2, 3)
y <- c(1, 4)
attributes(numericDeriv(quote(h(x, y)), c("x", "y")))$gradient
myf <- function(x) {exp(-x^2/2)/sqrt(2*pi)}
integrate(myf, lower = -Inf, upper = Inf)$value
myf <- function(x){
  res <- vector("integer", length(x))
  for(i in 1:length(x)){
    res[i] <- integrate(f = function(y, x){cos(x+y)},
                        lower = 2, upper = 3, x=x[i])$value
  }
return(res)
}
integrate(myf, lower = 0, upper = 1)$value
2*cos(3)-cos(4)-cos(2)
curve(cos(x^2), from = 0, to = 2)
abline(h = 0, v = 0)
optimize(f = function(x){cos(x^2)}, lower = 0, upper = 2)
##绘图
x <- seq(-10, 10, length = 30); y <- x
f <- function(x, y, alpha = 1.1){
  r <- sqrt((x-3)^2 + (y-4)^2)
  10*sin(r)/r^alpha
}
z <- outer(x, y, f)
save_par <- par(no.readonly = TRUE) 
z[is.na(z)] <- 1; op <- par(bg = "white")
persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "lightblue", ticktype = "detailed")
par(save_par)
f <- function(z, alpha = 1.1){
  x <- z[1]
  y <- z[2]
  r <- sqrt((x-3)^2 + (y-4)^2)
  -10 * sin(r)/r^alpha
}
res <- nlm(f, c(0, 0))
res
##绘图
f <- function(x, y) exp(-(x-1.2)^2-(y-2)^2)*cos((x-1.2)*pi*2)
x <- seq(-1, 3, 0.1)
y <- seq(0, 4, 0.1)
persp(x, y, outer(x, y, f), theta = 30, phi = 30, expand = 0.5, col = "lightblue", ticktype = "detailed")
##首先搜索全局极大值
f <- function(x) -exp(-(x[1]-1.2)^2-(x[2]-2)^2)*cos(2*pi*(x[1]-1.2))
nlminb(c(0.8, 0), f, lower = c(0.5, 0), upper = c(1.5, 4))
uniroot(f = function(x){cos(x^2)}, lower = 0, upper = 2, tol = 0.00001)$root
polyroot(c(3, -8, 1))
