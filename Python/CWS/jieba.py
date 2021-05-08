# -*- coding: utf-8 -*-
"""
Created on Sat Apr  3 16:34:45 2021

@author: xinx_
"""

## 分词
import jieba

seg_list = jieba.cut("我来到北京清华大学", cut_all=True)
print("全模式： " + "/".join(seg_list)) # 全模式
seg_list = jieba.cut("我来到北京清华大学", cut_all=False)
print("精准模式： " + "/".join(seg_list)) # 精确模式
seg_list = jieba.cut("他来到了网易杭研大厦") # 默认是精确模式
print(", ".join(seg_list))
seg_list = jieba.cut_for_search("小明硕士毕业于中国科学院计算所，后在日本京都大学深造") # 搜索引擎模式
print(", ".join(seg_list))

## 添加自定义词典
import jieba
# 获取自定义词典
jieba.load_userdict("C:/Users/ylc/Documents/GitHub/Learning/Python/CWS/dict/jieba.txt")
# 添加词
jieba.add_word('石墨烯')
jieba.add_word('凯瑟琳')
# 删除词
jieba.del_word('自定义词')
# 元组类型的测试数据
test_sent = (
    "李小福是创新办主任也是云计算方面的专家；什么是八一双鹿\n"
    "例如我输入一个带“韩玉赏鉴”的标题，在自定义词库中也增加了此词为N类\n"
    "【台中】正确应该不会被切开。mac上可分出【石墨烯】；此时又可以分出来凯瑟琳了。"
    )
# 默认分词
words = jieba.cut(test_sent)
print('/'.join(words)) # 使用/把分词的结果分开

print('/'.join(jieba.cut('如果放到post中将出错。', HMM=False)))
jieba.suggest_freq(('中', '将'), True)
print('/'.join(jieba.cut('如果放到post中将出错。', HMM=False)))
print('/'.join(jieba.cut('【台中】正确应该不会被切开', HMM=False)))
jieba.suggest_freq('台中', True)
print('/'.join(jieba.cut('【台中】正确应该不会被切开', HMM=False)))


# 词性标注
import jieba.posseg as pseg
result = pseg.cut(test_sent)
# 使用for循环把分出的词及其词性用/隔开，并添加，和空格
for w in result:
    print(w.word, "/", w.flag, ",", end=' ')
import jieba.posseg as pseg
words = pseg.cut("我爱北京天安门")
for word, flag in words:
    print('%s %s' % (word, flag))


## 关键词提取

# 基于TF-IDF算法的关键词提取
import jieba
import jieba.analyse
# 读取文件，返回一个字符串
content = open('人民的名义.txt', 'r').read()
tags = jieba.analyse.extract_tags(content, topK=10)
print(",".join(tags))

# 停用词
import jieba
import jieba.analyse
# 读取文件，返回一个字符串
content = open(u'人民的名义.txt', 'r').read()
jieba.analyse.set_stop_words("stopword.txt")
tags = jieba.analyse.extract_tags(content, topK=10)
print(",".join(tags))
# 返回权重值
import jieba
import jieba.analyse
content = open(u'人民的名义.txt', 'r').read()
jieba.analyse.set_stop_words('stopword.txt')
tags = jieba.analyse.extract_tags(content, topK=10, withWeight=True)
for tag in tags:
    print("tag:%s\t\t weight:%f"%(tag[0],tag[1]))


# 返回词语在原文的起止位置
import jieba
import jieba.analyse
result = jieba.tokenize(u'永和服装饰品有限公司')
for tk in result:
    print("word %s\t\t start: %d \t\t end:%d" % (tk[0], tk[1], tk[2]))
# 搜索模式
result = jieba.tokenize(u'永和服装饰品有限公司', mode = 'search')
for tk in result:
    print("word %s\t\t start: %d \t\t end:%d" % (tk[0], tk[1], tk[2]))


# 搜索引擎
from __future__ import unicode_literals
import sys, os
sys.path.append("../")
from whoosh.index import create_in, open_dir
from whoosh.fields import *
from whoosh.qparser import QueryParser

from jieba.analyse import ChineseAnalyzer

analyzer = ChineseAnalyzer()

schema = Schema(title=TEXT(stored=True), path=ID(stored=True), content=TEXT(stored=True, analyzer=analyzer))
if not os.path.exists("tmp"):
    os.mkdir("tmp")

ix = create_in("tmp", schema) # for create new index
# ix = open_dir("tmp) # for read only
writer = ix.writer()

writer.add_document(
    title='document1',
    path='/a',
    content="This is the first document we've added!"
    )

writer.add_document(
    title="document2",
    path='/b',
    content="The second one 你 中文测试中文 is even more interesting! 吃水果"
    )

writer.add_document(
    title="document3",
    path="/c",
    content="卖水果然后来世博园。"
    )

writer.add_document(
    title="document4",
    path="/c",
    content="工信处女干事每月经过下属科室都要亲口交代24口交换机等技术性器件的安装工作"
    )

writer.add_document(
    title="document4",
    path="/c",
    content="咱俩交换一下吧"
    )

writer.commit()
searcher = ix.searcher()
parser = QueryParser("content", schema=ix.schema)

for keyword in ("水果世博园", "你", "first", "中文", "交换机", "交换"):
    print("result of ", keyword)
    q = parser.parse(keyword)
    results = searcher.search(q)
    for hit in results:
        print(hit.highlights("content"))
    print("="*10)

for t in analyzer("我的好朋友是李明;我爱北京天安;IBM和Microsoft;I have a dream. this is interesting and interested me a lot"):
    print(t.text)