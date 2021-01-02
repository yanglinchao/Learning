readLines("Intima_Media_Thickness.txt", n =5)
IMT <- read.table("Intima_Media_Thickness.txt", sep = " ", dec = ",", header = T)   #由readLines可以看出文件字段之间用空格来分隔，用逗号作为小数点标记
IMT
##worksheet A Part 1
number <- 1:30
treatment <- c(rep(1, 6), rep(2, 6), rep(3, 6), rep(4, 6), rep(5, 6))
days <- c(5, 8, 7, 7, 10, 8, 4, 6, 6, 3, 5, 6, 6, 4, 4, 5, 4, 3, 7, 4, 6, 6, 3, 5, 9, 3, 5, 7, 7, 6)
blisters1 <- data.frame(number, treatment, days)
blisters1$treatment <- as.factor(blisters1$treatment)
Treatment_1 <- blisters1$days[blisters1$treatment == 1]
Treatment_2 <- blisters1$days[blisters1$treatment == 2]
Treatment_3 <- blisters1$days[blisters1$treatment == 3]
Treatment_4 <- blisters1$days[blisters1$treatment == 4]
Treatment_5 <- blisters1$days[blisters1$treatment == 5]
blisters <- data.frame(Treatment_1, Treatment_2, Treatment_3, Treatment_4, Treatment_5)
blisters
write.csv(blisters, file = "blisters.csv")
readLines("blisters.csv", n = 5)
blisters <- read.csv("blisters.csv")[, -1]
##worksheet A part 2
readLines("Intima_ftable-en.txt", n = 5)
