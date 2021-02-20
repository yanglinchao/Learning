# -*- coding: utf-8 -*-
"""
Created on Sun Feb 14 15:18:37 2021

@author: xinx_
"""

# 向模型添加L2权重正则化
from keras import regularizers

model = models.Sequential()
model.add(layers.Dense(16, kernel_regularizer=regularizers.12(0.001),
                       activation='relu', input_shape=(10000, )))
model.add(layers.Dense(16, kernel_regularizer=regularizers.12(0.001),
                       activation='relu', input_shape=(10000, )))
model.add(layers.Dense(1, activation='sigmoid'))

# Keras中不同的权重正则化项
from keras import regularizers
regularizers.l1(0.001) # L1正则化
regularizer.l1_l2(l1=0.001, l2=0.001) # 同时做L1和L2正则化

# 向网络中添加dropout
model = model.Sequential()
model.add(layers.Dense(16, activation='relu', input_shape=(10000,)))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(16, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(1, activation='sigmoid'))