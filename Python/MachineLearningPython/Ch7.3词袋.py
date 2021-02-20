# -*- coding: utf-8 -*-
"""
Created on Thu Feb 18 13:44:54 2021

@author: xinx_
"""

import numpy as np

# 7.3.1 将词袋应用于玩具数据集

bards_words = ["The fool doth think he is wise,", "but the wise man knows himself to be a fool"]

# 导入CountVectorizer并将其实例化，然后对玩具数据进行拟合
from sklearn.feature_extraction.text import CountVectorizer
vect = CountVectorizer()
vect.fit(bards_words)

# 拟合CountVectorizer包括训练数据的分词与词表的构建，可以通过vocabulary_属性来访问词表
print("Vocabulary size: {}".format(len(vect.vocabulary_)))
print("Vocabulary content:\n {}".format(vect.vocabulary_))

# 可以调用transform方法来创建训练数据的词袋表示
bag_of_words = vect.transform(bards_words)
print("bag_of_words: {}".format(repr(bag_of_words)))

# 可以使用toarray方法将其转换为“密集的”Numpy数组
print("Dense representation of bag_of_words:\n{}".format(bag_of_words.toarray()))
# 使用get_feature_names方法能查看每个特征所对应的单词
vect.get_feature_names()


# 7.3.2 将词袋应用于电影评论

from sklearn.datasets import load_files

reviews_train = load_files("C:/Users/ylc/Downloads/aclImdb/train")
# load_files返回一个Bunch对象，其中包含训练文本和训练标签
text_train, y_train = reviews_train.data, reviews_train.target
print("type of text_train:{}".format(type(text_train)))
print("length of text_train:{}".format(len(text_train)))
print("text_train[1]:\n{}".format(text_train[1]))

text_train = [doc.replace(b"<br />", b" ") for doc in text_train]

# 用词袋处理
vect = CountVectorizer().fit(text_train)
X_train = vect.transform(text_train)
print("X_train:\n{}".format(repr(X_train)))

feature_names = vect.get_feature_names()
print("Number of features:{}".format(len(feature_names)))
print("First 20 features:\n{}".format(feature_names[:20]))
print("Features 20010 to 20030:\n{}".format(feature_names[20010:20030]))
print("Every 2000th feature:\n{}".format(feature_names[::20000]))

# 使用交叉验证对LogisticRegression进行评估
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LogisticRegression
scores = cross_val_score(LogisticRegression(), X_train, y_train, cv=5)
print("Mean cross-validation accuracy:{:.2f}".format(np.mean(scores)))

# 调节LogisticRegression的正则化参数C
from sklearn.model_selection import GridSearchCV
param_grid = {'C':[0.001, 0.01, 0.1, 1, 10]}
grid = GridSearchCV(LogisticRegression(), param_grid, cv=5)
grid.fit(X_train, y_train)
print("Best cross-validation score: {:.2f}".format(grid.best_score_))
print("Best parameters: ", grid.best_params_)

# 评估参数设置的泛化性能
reviews_test = load_files("C:/Users/ylc/Downloads/aclImdb/test")
text_test, y_test = reviews_test.data, reviews_test.target
text_test = [doc.replace(b"<br />", b" ") for doc in text_test]
X_test = vect.transform(text_test)
print("{:.2f}".format(grid.score(X_test, y_test)))


# 改进单词提取
vect = CountVectorizer(min_df=5).fit(text_train)
X_train = vect.transform(text_train)
print("X_train with min_df:{}".format(repr(X_train)))

feature_names = vect.get_feature_names()
print("First 50 features:\n{}".format(feature_names[:50]))
print("Features 20010 to 20030:\n{}".format(feature_names[20010:20030]))
print("Every 700th feature:\n{}".format(feature_names[::700]))

grid = GridSearchCV(LogisticRegression(), param_grid, cv=5)
grid.fit(X_train, y_train)
print("Best cross-validation score:{:.2f}".format(grid.best_score_))
