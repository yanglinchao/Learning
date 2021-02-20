# -*- coding: utf-8 -*-
"""
Created on Mon Feb 15 12:38:28 2021

@author: xinx_
"""

# 单词级的one-hot编码（简单示例）
import numpy as np

# 初始数据：每个样本是列表的一个元素（本例中的样本是一个句子，但也可以是一整篇文档）
samples = ['The cat sat on the mat.', 'The dog ate my homework.']

token_index = {} # 构建数据中所有标记的索引
for sample in samples:
    # 利用split方法对样本进行分词。在实际应用中，还需要从样本中去掉标点和特殊字符
    for word in sample.split():
        if word not in token_index:
            #为每个唯一单词制定一个唯一索引。注意，没有为索引编号0指定单词
            token_index[word] = len(token_index) + 1

max_length = 10 # 对样本进行分词。只考虑每个样本前max_length个单词

results = np.zeros(shape=(len(samples), max_length, max(token_index.values())+1)) # 将结果保存在results中
for i, sample in enumerate(samples):
    for j, word in list(enumerate(sample.split()))[:max_length]:
        index = token_index.get(word)
        results[i, j, index] = 1.
        
# 字符级的one-hot编码（简单示例）
import string

samples = ['The cat sat on the mat.', 'The dog ate my homework.']
characters = string.printable # 所有可打印的ASCII字符
token_index = dict(zip(range(1, len(characters)+1), characters))

max_length = 50
results = np.zeros((len(samples), max_length, max(token_index.keys())+1))
for i, sample in enumerate(samples):
    for j, character in enumerate(sample):
        index = token_index.get(character)
        results[i, j, index] = 1.


# 用Keras实现单词级的ont-hot编码

from keras.preprocessing.text import Tokenizer

samples = ['The cat sat on the mat.', 'The dog ate my homework.']

tokenizer = Tokenizer(num_words=1000) # 创建一个分词器（tokenizer），设置为只考虑前1000个最常见的单词
tokenizer.fit_on_texts(samples) # 构架单词索引

sequences = tokenizer.texts_to_sequences(samples) # 将字符串转换为整数索引组成的列表

# 也可以直接得到one-hot二进制表示。这个分词器也支持除one-hot编码外的其他向量化模式
one_hot_results = tokenizer.texts_to_matrix(samples, mode='binary')

word_index = tokenizer.word_index # 找回单词索引
print('Found %s unique tokens.' % len(word_index))


# 使用散列技巧的单词级的one-hot编码（简单示例）

samples = ['The cat sat on the mat.', 'The dog ate my homework.']
# 将单词保存为长度为1000的向量
# 如果单词数量接近1000个（或更多），那么会遇到很多散列冲突，这会降低这种编码方法的准确性
dimensionality = 1000
max_length = 10

results = np.zeros((len(samples), max_length, dimensionality))
for i, sample in enumerate(samples):
    for j, word in list(enumerate(sample.split()))[:max_length]:
        index = abs(hash(word)) % dimensionality # 将单词散列为0~1000范围内的一个随机整数索引
        results[i, j, index] = 1.


# 将一个Embedding层实例化
from keras.layers import Embedding
embedding_layer = Embedding(1000, 64) # Embedding层至少需要两个参数：标记的个数和嵌入的维度





# 加载IMDB数据，准备用于Embedding层
from keras.datasets import imdb
from keras import preprocessing

max_features = 10000 # 作为特征词的个数
maxlen = 20 # 在这么多单词后截断文本（这些单词都属于前max_features个最常见的单词）

(x_train, y_train), (x_test, y_test) = imdb.load_data(num_words=max_features) # 将数据加载为整数列表

# 将整数列表转换成形状为(samples, maxlen)的二维整数张量
x_train = preprocessing.sequence.pad_sequences(x_train, maxlen=maxlen)
x_test = preprocessing.sequence.pad_sequences(x_test, maxlen=maxlen)


# 在IMDB数据上使用Embedding层和分类器

from keras.models import Sequential
from keras.layers import Flatten, Dense, Embedding

model = Sequential()
# 指定Embedding层的最大输入长度，以便后面将嵌入输入展平
# Embedding层激活的形状为(samples, maxlen, 8)
model.add(Embedding(10000, 8, input_length=maxlen))

model.add(Flatten()) # 将三维的嵌入张量展平成形状为(samples, maxlen*8)的二维张量

model.add(Dense(1, activation='sigmoid')) # 在上面添加分类器
model.compile(optimizer='rmsprop', loss='binary_crossentropy', metrics=['acc'])
model.summary()

history = model.fit(x_train, y_train, epochs=10, batch_size=32, validation_split=0.2)



# 6.1.3 整合在一起：从原始文本到词嵌入

# 处理IMDB原始数据的标签
import os

imdb_dir = 'C:/Users/ylc/Downloads/aclImdb'
train_dir = os.path.join(imdb_dir, 'train')

labels = []
texts = []

for label_type in ['neg', 'pos']:
    dir_name = os.path.join(train_dir, label_type)
    for fname in os.listdir(dir_name):
        if fname[-4: ] == '.txt':
            f = open(os.path.join(dir_name, fname), encoding='gb18030', errors='ignore')
            texts.append(f.read())
            f.close()
            if label_type == 'neg':
                labels.append(0)
            else:
                labels.append(1)


# 对IMDB原始数据的文本进行分词

from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
import numpy as np

maxlen = 100 # 在100个单词后截断评论
training_samples = 200 # 在200个样本上训练
validation_samples = 10000 # 在10000个样本上验证
max_words = 10000 # 只考虑数据集中签10000个最常见的单词

tokenizer = Tokenizer(num_words=max_words)
tokenizer.fit_on_texts(texts)
sequences = tokenizer.texts_to_sequences(texts)

word_index = tokenizer.word_index
print('Found %s unique tokens.' % len(word_index))

data = pad_sequences(sequences, maxlen=maxlen)

labels = np.asarray(labels)
print('Shape of data tensor:', data.shape)
print('Shape of label tensor:', labels.shape)

# 将数据划分为训练集和验证集，但首先要打乱数据，因为一开始数据中的样本是排好序的（所有负面评论都在前面，然后是所有正面评论）
indices = np.arange(data.shape[0]) 
np.random.shuffle(indices)
data = data[indices]
labels = labels[indices]

x_train = data[:training_samples]
y_train = labels[:training_samples]
x_val = data[training_samples:training_samples+validation_samples]
y_val = labels[training_samples:training_samples+validation_samples]


# 解析GloVe词嵌入文件

glove_dir = 'C:/Users/ylc/Downloads/glove.6B'

embeddings_index = {}
f = open(os.path.join(glove_dir, 'glove.6B.100d.txt'), encoding='gb18030', errors='ignore')
for line in f:
    values = line.split()
    word = values[0]
    coefs = np.asarray(values[1:], dtype='float32')
    embeddings_index[word] = coefs
f.close()
print('Found %s word vectors.' % len(embeddings_index))


# 准备GloVe词嵌入矩阵

embedding_dim = 100

embedding_matrix = np.zeros((max_words, embedding_dim))
for word, i in word_index.items():
    if i < max_words:
        embedding_vector = embeddings_index.get(word)
        if embedding_vector is not None:
            embedding_matrix[i] = embedding_vector # 嵌入索引(embeddings_index)中找不到的词，其嵌入向量全为0



# 模型定义

from keras.models import Sequential
from keras.layers import Embedding, Flatten, Dense

model = Sequential()
model.add(Embedding(max_words, embedding_dim, input_length=maxlen))
model.add(Flatten())
model.add(Dense(32, activation='relu'))
model.add(Dense(1, activation='sigmoid'))
model.summary()


# 将预训练的词嵌入加载到Embedding层中
model.layers[0].set_weights([embedding_matrix])
model.layers[0].trainable = False # 冻结Embedding层


# 训练与评估
model.compile(optimizer='rmsprop', loss = 'binary_crossentropy', metrics=['acc'])
history = model.fit(x_train, y_train, epochs=10, batch_size=32, validation_data=(x_val, y_val))
model.save_weights('pre_trained_glove_model.h5')

# 绘制结果
import matplotlib.pyplot as plt

acc = history.history['acc']
val_acc = history.history['val_acc']
loss = history.history['loss']
val_loss = history.history['val_loss']

epochs = range(1, len(acc)+1)

plt.plot(epochs, acc, 'bo', label='Training acc')
plt.plot(epochs, val_acc, 'b', label='Validation acc')
plt.title('Training and validation accuracy')
plt.legend()

plt.figure()

plt.plot(epochs, loss, 'bo', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='Validation loss')
plt.title('Training and validation loss')
plt.legend()

plt.show()


# 在不使用预训练词嵌入的情况下，训练相同的模型
from keras.models import Sequential
from keras.layers import Embedding, Flatten, Dense

model = Sequential()
model.add(Embedding(max_words, embedding_dim, input_length=maxlen))
model.add(Flatten())
model.add(Dense(32, activation='relu'))
model.add(Dense(1, activation='sigmoid'))
model.summary()

model.compile(optimizer='rmsprop', loss='binary_crossentropy', metrics=['acc'])
history = model.fit(x_train, y_train, epochs=10, batch_size=32, validation_data=(x_val, y_val))


# 在测试集上评估模型

# 对测试集数据进行分词
test_dir = os.path.join(imdb_dir, 'test')

labels = []
texts = []

for label_type in ['neg', 'pos']:
    dir_name = os.path.join(test_dir, label_type)
    for fname in sorted(os.listdir(dir_name)):
        if fname[-4:] == '.txt':
            f = open(os.path.join(dir_name, fname), encoding='gb18030', errors='ignore')
            texts.append(f.read())
            f.close()
            if label_type == 'neg':
                labels.append(0)
            else:
                labels.append(1)
sequences = tokenizer.texts_to_sequences(texts)
x_test = pad_sequences(sequences, maxlen=maxlen)
y_test = np.asarray(labels)

# 在测试集上评估模型
model.load_weights('pre_trained_glove_model.h5')
model.evaluate(x_test, y_test)