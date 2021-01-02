library(ggpubr)

data("ToothGrowth")
head(ToothGrowth)

# 比较独立的两组,绘制箱线图并添加p-value
# step1:绘制箱线图
p <- ggboxplot(ToothGrowth, x = "supp", y = "len", color = "supp", palette = "jco", add = "jitter")
# step2:添加p-value,默认是Wilcoxon text
p + stat_compare_means()
# step2:使用t-test
p + stat_compare_means(method = "t.test")

# 配对样本比较,利用ggpaired()进行可视化,并通过stat_compare_means()添加p-value
ggpaired(ToothGrowth, x = "supp", y = "len", color = "supp", line.color = "grey", line.size = 0.4, palette = "jco") + stat_compare_means(data = ToothGrowth, paired = TRUE)

# 多组比较,并通过stat_compare_means()添加p-value
ggboxplot(ToothGrowth, x = "dose", y = "len", color = "dose", palette = "jco") + stat_compare_means()
# 多组比较,使用anova
ggboxplot(ToothGrowth, x = "dose", y = "len", color = "dose", palette = "jco") + stat_compare_means(method = "anova")

# 成对比较,如果分组变量中包含两个以上水平,会自动进行两两比较
# 第一个stat_compare_means()指定添加那些组的比较,第二个stat_compare_stat()指定添加全局的比较
my_comparision <- list(c("0.5", "1"), c("1", "2"), c("0.5", "2"))
ggboxplot(ToothGrowth, x = "dose", y = "len", color = "dose", palette = "jco") + stat_compare_means(comparisons = my_comparision) + stat_compare_means(label.y = 50)
# 通过ref.group参数设置参考组
ggboxplot(ToothGrowth, x = "dose", y = "len", color = "dose", palette = "jco") + stat_compare_means(label = "p.signif", method = "t.test", ref.group = "0.5") + stat_compare_means(method = "anova", label.y = 40)
# 当组别太多时,如果在组间进行比较,那么两两组合比较的组会过多,这时可以把ref.group参数设置成".all.”,将每组均值都与整体的均值进行比较
ggboxplot(ToothGrowth, x = "dose", y = "len", color = "dose", palette = "jco") + stat_compare_means(label = "p.signif", method = "t.test", ref.group = ".all.") + stat_compare_means(method = "anova", label.y = 40)
# 通过设置hide.ns=TRUE将不显著的去掉
ggboxplot(ToothGrowth, x = "dose", y = "len", color = "dose", palette = "jco") + stat_compare_means(label = "p.signif", method = "t.test", ref.group = ".all.", hide.ns = TRUE) + stat_compare_means(method = "anova", label.y = 40)
