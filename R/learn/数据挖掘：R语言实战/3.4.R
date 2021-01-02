library(XML)
u1 <- "http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=000002&type=1&date =2013.06.30"
tables1 <- readHTMLTable(u1)
names(tables1)
tables1[[2]]   #读取tables1第2维度中的内容