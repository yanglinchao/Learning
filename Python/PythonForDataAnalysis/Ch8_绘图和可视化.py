# -*- coding: utf-8 -*-
"""
Created on Sun Jan 17 10:58:58 2021

@author: ylc
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

fig = plt.figure()
ax1 = fig.add_subplot(2, 2, 1)
ax2 = fig.add_subplot(2, 2, 2)
ax3 = fig.add_subplot(2, 2, 3)

plt.plot(np.random.randn(50).cumsum(), 'k--')
_ = ax1.hist(np.random.randn(100), bins=20, color='k', alpha=0.3)
ax2.scatter(np.arange(30), np.arange(30)+3*np.random.randn(30))

fig, axes = plt.subplots(2, 3)
axes

# 调整subplot周围的间距
fig, axes = plt.subplots(2, 2, sharex=True, sharey=True)
for i in range(2):
    for j in range(2):
        axes[i, j].hist(np.random.randn(500), bins=50, color='k', alpha=0.5)
plt.subplots_adjust(wspace=0, hspace=0) # 间距调整为0

# 颜色、标记和线型
plt.plot(np.random.randn(30).cumsum(), 'ko--')
plt.plot(np.random.randn(30).cumsum(), color='k', linestyle='dashed', marker='o')

data = np.random.randn(30).cumsum()
plt.plot(data, 'k--', label='Default')
plt.plot(data, 'k--', drawstyle='steps-post', label='steps-post')
plt.legend(loc='best')