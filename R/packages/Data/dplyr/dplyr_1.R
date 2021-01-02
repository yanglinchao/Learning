library(dplyr)
library(hflights)
data(hflights)   #数据集hflights是2011年从休斯敦机场起飞的航班
head(hflights, 3)

flights <- tbl_df(hflights)
flights

#######################################行过滤
##原始做法
flights[flights$Month==1 & flights$DayofMonth==1, ]
##dplyr包
filter(flight, Month == 1, DayofMonth == 1)   #筛选1月第1天的航班
filter(flights, UniqueCarrier == "AA"|UniqueCarrier == "UA")
filter(flights, UniqueCarrier %in% c("AA", "UA"))

#######################################选择列
##原始做法
flights[, c("DepTime", "ArrTime", "FlightNum")]
##dplyr
select(flights, DepTime, ArrTime, FlightNum)
##":"选择连续列,contains匹配列名
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))
##starts_with, ends_with, matches更精确匹配

#########################################链式操作(管道)
##将多行语句嵌套写入一行，并提高可读性，相当于把上一句的结果传递给下一句
##%>%(读成then)
filter(select(flights, UniqueCarrier, DepDelay), DepDelay>60)
##上述语句用%>%写可以写成如下代码
flights %>% select(UniqueCarrier, DepDelay) %>% filter(DepDelay > 60)
##再例如
x1 <- 1:5; x2 <- 2:6
sqrt(sum((x1 - x2)^2))
(x1 - x2)^2 %>% sum() %>% sqrt()

#########################################arrange:排序
##按照起飞延迟对所有航空公司排序
##原始做法
flights[order(flights$DepDelay), c("UniqueCarrier", "DepDelay")]
##dplyr做法
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)   #正序
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))   #降序

##########################################mutate:添加新变量
##计算航班速度
##AirTime是分钟数,首先要换算成小时
##原始做法
flights$Speed <- flights$Distance/flights$AirTime*60
flights[, c("Distance", "AirTime", "Speed")]
##dplyr做法
flights %>%
  select(Distance, AirTime) %>%
  mutate(Speed = Distance/AirTime*60)
flights <- flights%>%mutate(Speed = Distance/AirTime*60)

##############################################summarise:总结
##对数据进行分组统计,先用group_by()对数据分组,group_by()可以用在select()/arrange()/mutate()/filter()/sample_n()/sample_frac()/slice()/summarise()中
##根据目的地统计平均航班延迟
##原始做法
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm = T)))   #第一种方法
head(aggregate(ArrDelay ~ Dest, flight, mean))   #第二种方法
##dplyr做法
flights %>% group_by(Dest) %>% summarise(avg_delay = mean(ArrDelay, na.rm = T))
##summarise_each允许对多列进行统计,mutate_each也可以
##每个航空公司的平均航班取消与转飞比例
flights %>% group_by(UniqueCarrier) %>% summarise_each(funs(mean), Cancelled, Diverted)
##每个航空公司最大/最小到达/离开延迟
flights %>% group_by(UniqueCarrier) %>% summarise_each(funs(min(., na.rm = T), max(., na.rm = T)), matches("Delay"))
##n()统计组中行数目,n_distinct(vector)统计不同行数目
##统计总航班数目排序
flights %>% group_by(Month, DayofMonth) %>% summarise(flight_count = n()) %>% arrange(desc(flight_count))
##飞往每个目的地的总航班数与不同飞机编号的数目(Tail Num)
flights %>% group_by(Dest) %>% summarise(flight_count = n(), plane_count = n_distinct(TailNum))
##tally可以一步完成计数工作
flights %>% group_by(Month, DayofMonth) %>% tally(sort = TRUE)
##飞往每个目的地的取消航班和未取消航班对比
flights %>% group_by(Dest) %>% select(Cancelled) %>% table() %>% head()

##################################################join
##inner_join:只包含同时出现在x,y表中的行
##left_join:包含所有x中以及y中匹配的行
##semi_join:包含x中,在y中有匹配的行
##anti_join:包含x中不匹配y的行
x <- data.frame(name=c("John", "Paul", "George", "Ringo", "Stuart", "Peta"), instrument=c("guitar", "bass", "guitar", "drums", "bass", "drums"))
y <- data.frame(name=c("John", "Paul", "George", "Ringo", "Brian"), band=c("TRUE", "TRUE", "TRUE", "TRUE", "FALSE"))
x
y
inner_join(x, y, by = "name")
left_join(x, y, by = "name")
semi_join(x, y, by = "name")
anti_join(x, y, by = "name")

###################################################抽样
##sample_n()按数目进行抽样,sample_frac()按比例进行抽样
##参数replace选择是否放回,默认为FALSE
##参数weight可以设定样本权重
flights %>% sample_n(10)
flights %>% sample_frac(0.03, replace = TRUE)

