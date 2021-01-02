data("TravelMode", package = "AER")
##用with()函数对数据进行转换，对data进行表达式运算
TravelMode$avincome <- with(TravelMode, income*(mode=="air"))
TravelMode$time <- with(TravelMode, travel + wait)/60
TravelMode$timeair <- with(TravelMode, time*I(mode=="air"))
TravelMode$income <- with(TravelMode, income/10)
TravelMode$incomeother <- with(TravelMode, ifelse(mode %in% c('air', 'car'), income, 0))
head(TravelMode)
nl <- mlogit(choice ~ gcost + wait + incomeother, TravelMode, shape='long', alt.var='mode',nests = list(public=c('train', 'bus'), other=c('car', 'air')))
summary(nl)