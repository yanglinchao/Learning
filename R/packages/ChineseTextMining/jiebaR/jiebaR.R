# 分词

# 对文本进行分词
worker <- worker() # 分词器
segment("这是一段测试文本！", worker)

# 分行输出
worker <- worker()
worker$bylines = TRUE
segment(c("这是第一行文本。", "这是第二行文本。"), worker)

# 保留符号
worker <- worker()
worker$symbol = TRUE
segment(c("Hi, 这是第一行文本。"), worker)

# 添加新词到已经新建的分词器中new_user_word()
worker = worker()
segment("这是一个新词", worker)
new_user_word(worker, "这是一个新词", "n") # 其中第三个参数"n"代表新词的词性标记
segment("这是一个新词", worker)

# 添加停止词worker(stop_word="...")
readLines("stop.txt", encoding = "UTF-8") # 目录下有一个stop.txt文件(只有一个词"停止")
worker <- worker(stop_word = "stop.txt")
segment("这是一个停止词", worker)
# 注意：对于分词，请不要修改默认加载的停止词文本，即jiebaR::STOPPATH，请使用自定义的停止词路径



# 标记和关键词

# 标记
words <- "我爱北京天安门"
worker <- worker("tag") # 此时的worker是分词器+标记器
result <- tagging(words, worker)
print(result)

worker <- worker() # 分词器
result <- segment(words, worker)
result
worker_tag <- worker("tag")
vector_tag(result, worker_tag)

# 关键词
worker <- worker("keywords", topn = 1) # 提取器
keywords("我爱北京天安门", worker)

worker <- worker() # 分词器
result <- segment(words, worker)
result
worker_keywords <- worker("keywords", topn=1) # 提取器
vector_keywords(result, worker_keywords)

# Simhash与海明距离
worker = worker("simhash", topn=2) # 摘要器
simhash("江州市长江大桥参加了长江大桥的通车仪式", worker)
distance("hello world!", "江州市长江大桥参加了长江大桥的通车仪式" ,worker)
vector_simhash(c("今天", "天气", "真的", "十分", "不错", "的", "感觉"), worker)
vector_distance(c("今天", "天气", "真的", "十分", "不错", "的", "感觉"),
                c("今天", "天气", "真的", "十分", "不错", "的", "感觉"),
                worker)

# tobin进行Simhash数值的二进制转换
tobin("12098690169796312660")

# 词频统计
freq(c("测试", "测试", "文本"))

# 生成IDF文件get_idf()
# 根据多文档词条结果计算IDF值。输入一个包含多个文本向量的list,每一个文本向量代表一个文档,可自定义停止词列表
filesite = tempfile() # 临时输出目录
a_big_list = list(c("测试", "一下"), c("测试"))
get_idf(a_big_list, stop = jiebaR::STOPPATH, path = filesite)
readLines(filesite)
