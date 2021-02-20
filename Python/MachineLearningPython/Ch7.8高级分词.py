# -*- coding: utf-8 -*-
"""
Created on Fri Feb 19 18:16:12 2021

@author: xinx_
"""

import spacy
import nltk

# 加载spacy的英语模型
en_nlp = spacy.load('en_core_web_sm')
# 将nltk的Porter词干提取器实例化
stemmer = nltk.stem.PorterStemmer()

# 定义一个函数来对比spacy中的词形还原与nltk中的词干提取
def compare_normalization(doc):
    # 在spacy中对文档进行分词
    doc_spacy = en_nlp(doc)
    # 打印出spacy找到的词元
    print("Lemmatizaiton:")
    print([token.lemma_ for token in doc_spacy])
    # 打印出Porter词干提取器找到的词例
    print("Stemming:")
    print([stemmer.stem(token.norm_.lower()) for token in doc_spacy])

compare_normalization(u"Our meeting today was worse than yesterday, "
                      "I'm scared of meeting the clients tomorrow.")

# 准备数据
from sklearn.datasets import load_files
reviews_train = load_files("C:/Users/ylc/Downloads/aclImdb/train")
text_train, y_train = reviews_train.data, reviews_train.target
text_train = [doc.replace(b"<br />", b" ") for doc in text_train]

from sklearn.feature_extraction.text import CountVectorizer
# 技术细节：我们希望使用由CountVectorizer所使用的基于正则表达式的分词器，并仅使用spacy的词形还原
# 将en_nlp.tokenizer（spacy分词器）替换为基于正则表达式的分词
import re
# 在CountVectorizer中使用的正则表达式
regexp = re.compile('(?u)\\b\\w\\w+\\b')

# 加载spacy语言模型，并保存旧的分词器
en_nlp = spacy.load('en_core_web_sm')
old_tokenizer = en_nlp.tokenizer
# 将分词器替换为前面的正则表达式
en_nlp.tokenizer = lambda string: old_tokenizer.tokens_from_list(regexp.findall(string))

# 用spacy文档处理管道创建一个自定义分词器（现在使用我们自己的分词器）
def custom_tokenizer(document):
    doc_spacy = en_nlp(document, entity=False, parse=False)
    return [token.lemma_ for token in doc_spacy]

# 利用自定义分词器来定义一个计数向量器
lemma_vect = CountVectorizer(tokenizer=custom_tokenizer, min_df=5)

# 利用带词形还原的CountVectorizer对text_train进行变换
X_train_lemma = lemma_vect.fit_transform(text_train)
print("X_train_lemma.shape: {}".format(X_train_lemma.shape))

# 标准的CountVectorizer
vect = CountVectorizer(min_df=5).fit(text_train)
X_train = vect.transform(text_train)
print("X_train.shape: {}".format(X_train.shape))
