system.time(runif(1e8))

library(rbenchmark)

bench1 <- benchmark(runif(1e8), replications = 10)
bench1
within(bench1, {
  elapsed.mean <- elapsed/replications
  user.self.mean <- user.self/replications
  sys.self.mean <- sys.self/replications
})

library(microbenchmark)
microbenchmark(runif(1e8), times = 10)

sampvar <- function(x){
  my.sum <- function(x){
    sum <- 0
    for(i in x){
      sum <- sum + i
    }
    sum
  }
  sq.var <- function(x, mu){
    sum <- 0
    for(i in x){
      sum <- sum + (i-mu)^2
    }
    sum
  }
  mu <- my.sum(x)/length(x)
  sq <- sq.var(x, mu)
  sq/(length(x)-1)
}
x <- runif(1e7)
Rprof("Rprof.out")   #通知R开始性能分析。Rprof.out是储存性能分析文件的文件名。
y <- sampvar(x)
Rprof(NULL)   #通知R停止性能分析
summaryRprof("Rprof.out")   #将分析结果打印出来
install.packages("proftools")
source("http://bioconductor.org/biocLite.R")
biocLite(c("graph", "Rgraphviz"))
library(proftools)
p <- readProfileData(filename = "Rprof.out")
plotProfileCallGraph(p, style = google.style, scorce = "total")

x <- runif(1e7)
Rprof("Rprof-mem.out", memory.profiling = TRUE)
y <- sampvar(x)
Rprof(NULL)
summaryRprof("Rprof-mem.out", memory = "both")

gcinfo(TRUE) 
y <- sampvar(x)
gcinfo(FALSE)

