#Creating a parallel backend

library(doParallel)

#Find out how many cores are avaiable
detectCores()

#Create cluster with desired number of cores
cl <- makeCluster(3)

#Create cluster with desired number of cores
registerDoParallel(cl)

#Find out how many cores are being used
getDoParWorkers()

#When you're done, be sure to close the parallel backend
stopCluster(cl)


#Executing computation in parallel

#Using foreach
library(foreach)
x <- foreach(i = 1:3) %dopar% sqrt(i)
x
#Use the concatenate function to combine results
x <- foreach(i = 1:3, .combine = c) %dopar% sqrt(i)
x
#Can also use + or * to combine results
x <- foreach(i = 1:3, .combine = "+") %dopar% sqrt(i)
x




#Parallel apply functions

parLapply(cl, list(1, 2, 3), sqrt)


#Random number generation

library(doRNG)

#Set the random number seed
set.seed(123)
#Replace %dopar% with %dorng%
rand1 <- foreach(i = 1:5) %dorng% runif(3)

#Or set seed using .optins.RNG option in foreach
rand2 <- foreach(i = 1:5, .options.RNG = 123) %dorng% runif(3)

#The two sets of random numbers are identical (i.e. reproducible)
identical(rand1, rand2)



#example

#Generate fake tree data set with 100 observations for 100 species
tree.df <- data.frame(species = rep(c(1:100), each = 100), girth = runif(10000, 7, 40))
tree.df$volume <- tree.df$species/10 + 5*tree.df$girth + rnorm(1000, 0, 3)

#Extract species IDs to iterate over
species <- unique(tree.df$species)

#Run foreach loop and store results in fits object
library(foreach)
fits <- foreach(i = species, .combine = rbind) %dopar% {
  sp <- subset(tree.df, subset = species == i)
  fit <- lm(volume ~ girth, data = sp)
  return(c(i, fit$coefficients))
}
head(fits)

#What if we want all of the info from the lm object? Change .combine
fullfits <- foreach(i = species) %dopar% {
  sp <- subset(tree.df, subset = species == i)
  fit <- lm(volume ~ girth, data = sp)
  return(fit)
}
attributes(fullfits[[1]])
