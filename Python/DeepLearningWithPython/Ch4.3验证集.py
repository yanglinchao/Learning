# -*- coding: utf-8 -*-
"""
Created on Sun Feb 14 11:54:16 2021

@author: xinx_
"""

import numpy as np

# 留出验证

num_validation_sample = 10000

np.random.shuffle(data) # 通常需要打乱数据

validation_data = data[:num_validation_samples] # 定义验证集
data = data[num_validation_samples:]

training_data = data[:] # 定义训练集

model = get_model() # 在训练数据上训练模型，并在验证数据上评估模型
model.train(training_data)
validation_score = model.evaluate(validation_data)

# 现在你可以调节模型、重新训练、评估，然后再次调节
# 一旦调节好超参数，通常就在所有非测试数据上从头开始训练最终模型
model = get_model()
model.train(np.concatenate([training_data, validation_data]))
test_score = model.evaluate(test_data)


# K折验证
k=4
num_validation_samples = len(data) // k

np.random.shuffle(data)

validation_scores = []
for fold in range(k):
    # 选择验证数据分区
    validation_data = data[num_validation_samples*fold:num_validation_sample*(fold+1)]
    # 使用剩余数据作为训练数据。注意，+运算符是列表合并，不是求和
    training_data = data[:num_validation_samples*fold] + data[num_validation_samples*(fold+1):]
    # 创建一个全新的模型实例（未训练）
    model = get_model()
    model.train(training_data)
    validation_score = model.evaluate(validation_data)
    validation_scores.append(validation_score)

validation_score = np.average(validation_scores) # 最终验证分数：K折验证分数的平均值

# 在所有非测试数据上训练最终模型
model = get_model()
model.train(data)
test_score = model.evaluate(test_data)