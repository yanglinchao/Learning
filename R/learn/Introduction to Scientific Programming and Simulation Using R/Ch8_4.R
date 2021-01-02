trapTransect <- function(distances, seed.counts, trap.area = 0.0001){
  if(length(distances) != length(seed.counts))
    stop("Lengths of distances and counts differ.")
  if(length(trap.area) != 1)
    stop("Ambiguous trap area.")
  trapTransect <- list(distances = distances,
                       seed.counts = seed.counts,
                       trap.area = trap.area)
  class(trapTransect) <- "trapTransect"
  return(trapTransect)
}

print.trapTransect <- function(x, ...){
  str(x)
}

mean.trapTransect <- function(x, ...){
  return(weighted.mean(x$distances, w = x$seed.counts))
}

methods(class = "trapTransect")

s1 <- trapTransect(distances = 1:4, seed.counts = c(4, 3, 2, 0))
s1

is.list(s1)
class(s1)
s1[[1]]

mean(s1)
mean.trapTransect(s1)
