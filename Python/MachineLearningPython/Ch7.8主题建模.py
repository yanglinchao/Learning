# -*- coding: utf-8 -*-
"""
Created on Fri Feb 19 21:09:59 2021

@author: xinx_
"""

# 准备数据
from sklearn.datasets import load_files
reviews_train = load_files("C:/Users/ylc/Downloads/aclImdb/train")
text_train, y_train = reviews_train.data, reviews_train.target
text_train = [doc.replace(b"<br />", b" ") for doc in text_train]

from sklearn.feature_extraction.text import CountVectorizer
vect = CountVectorizer(max_features=10000, max_df=.15)
X = vect.fit_transform(text_train)

from sklearn.decomposition import LatentDirichletAllocation
lda = LatentDirichletAllocation(n_components=10, learning_method="batch", max_iter=25, random_state=0)
# 构建模型并变换数据
document_topics = lda.fit_transform(X)

lda.components_.shape

import numpy as np
import mglearn
# 对于每个主题(components_的一行),将特征排序(升序),用[:, ::-1]将行反转，使排序变为降序
sorting = np.argsort(lda.components_, axis=1)[:, ::-1]
# 从向量器中获取特征名称
feature_names = np.array(vect.get_feature_names())
# 打印出前10个主题
mglearn.tools.print_topics(topics=range(10), feature_names=feature_names,
                           sorting=sorting, topics_per_chunk=5, n_words=10)

# 按主题6"police"进行排序
police = np.argsort(document_topics[:, 6])[::-1]
# 打印出这个主题最重要的前5个文档
for i in police[:5]:
    # 显示前两个句子
    print(b".".join(text_train[i].split(b".")[:2])+b".\n")
    
import matplotlib.pyplot as plt
fig, ax = plt.subplots(1, 2, figsize=(10, 5))
topic_names = ["{:>2} ".format(i) + " ".join(words) for i, words in enumerate(feature_names[sorting[:, :2]])]
# 两列的条形图
for col in [0, 1]:
    start = col*5
    end = (col+1)*5
    ax[col].barh(np.arange(5), np.sum(document_topics, axis=0)[start:end])
    ax[col].set_yticks(np.arange(5))
    ax[col].set_yticklabels(topic_names[start:end], ha="left", va='top')
    ax[col].invert_yaxis()
    ax[col].set_xlim(0, 20000)
    yax = ax[col].get_yaxis()
    yax.set_tick_params(pad=100)
plt.tight_layout()