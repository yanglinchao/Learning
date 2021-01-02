library(foreign)
dat <- read.dta("http://www.ats.ucla.edu/stat/data/ologit.dta")
formula <- as.factor(apply) ~ pared + public + gpa
library(MASS)
orm <- polr(formula = formula, data = dat, method = "logistic", Hess = T)
summary(orm)
orm_p <- polr(formula = formula, data = dat, method = "probit", Hess = T)
summary(orm_p)