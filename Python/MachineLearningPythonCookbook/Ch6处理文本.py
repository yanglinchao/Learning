# -*- coding: utf-8 -*-
"""
Created on Fri Feb 19 23:45:22 2021

@author: xinx_
"""

# 移除标点

# 加载库
import unicodedata
import sys

# 创建文本
text_data = ['Hi!!!! I. Love. This. Song....', '10000% Agree!!!! #LoveIT', 'Right?!?!']
# 创建一个标点字典
punctuation = dict.fromkeys(i for i in range(sys.maxunicode) if unicodedata.category(chr(i)).startswith('P'))
# 移除每个字符串中的标点
[string.translate(punctuation) for string in text_data]

# 分词
from nltk.tokenize import word_tokenize

# 创建文本
string = "the science of today is the technology of tomorrow"
# 分词
word_tokenize(string)

# 将文本且分为句子
from nltk.tokenize import sent_tokenize

# 创建文本
string = "The science of today is the technology of tomorrow. Tomorrow is today."
# 切分成句子
sent_tokenize(string)


# 停用词
from nltk.corpus import stopwords
# 如果是第一次使用停止词集，则需要先下载
# import nltk
# nltk.download('stopwords')

# 创建单词序列
tokenized_words = ['i', 'am', 'going', 'to', 'go', 'to', 'the', 'store', 'and', 'park']
# 加载停止词
stop_words = stopwords.words('english')
# 删除停止词
[word for word in tokenized_words if word not in stop_words]
# 查看停止词
stop_words[:10]


# 词性标注
from nltk import pos_tag
from nltk import word_tokenize
# 创建文本
text_data = 'Chirs loved outdoor running'
# 使用预训练的词性标注器
text_tagged = pos_tag(word_tokenize(text_data))
# 查看词性
text_tagged

text_data = 'Chirs loved outdoor running'
# 过滤单词
[word for word, tag in text_tagged if tag in ['NN', 'NNS', 'NNP', 'NNPS']]

import nltk
from sklearn.preprocessing import MultiLabelBinarizer
tweets = ['I am eating a burrito for breakfast', 'Political science is an amazing field', 'San Francisco is an awesome city']
# 创建列表
tagged_tweets = []
# 为每个句子中的每个单词加标签
for tweet in tweets:
    tweet_tag = nltk.pos_tag(word_tokenize(tweet))
    tagged_tweets.append([tag for word, tag in tweet_tag])
# 使用one-hot编码将标签转换成特征
one_hot_multi = MultiLabelBinarizer()
one_hot_multi.fit_transform(tagged_tweets)
# 查看特征名
one_hot_multi.classes_ # 查看特征名


from nltk.corpus import brown
from nltk.tag import UnigramTagger
from nltk.tag import BigramTagger
from nltk.tag import TrigramTagger

# 从布朗语料库中获取文本数据，切分为句子
sentences = brown.tagged_sents(categories='news')
# 将4000个句子用作训练，623个句子用作测试
train = sentences[:4000]
test = sentences[4000:]
# 创建回退标注器
unigram = UnigramTagger(train)
bigram = BigramTagger(train, backoff=unigram)
trigram = TrigramTagger(train, backoff=bigram)
# 查看准确率
trigram.evaluate(test)


# TF-IDF
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
# 创建文本
text_data = np.array(['I love Brazil. Brazil!', 'Sweden is best', 'Germany beats both'])
# 创建TF-IDF特征矩阵
tfidf = TfidfVectorizer()
feature_matrix = tfidf.fit_transform(text_data)
# 查看TF-IDF特征矩阵
feature_matrix
feature_matrix.toarray()
# 查看特征的名字
tfidf.vocabulary_
    
