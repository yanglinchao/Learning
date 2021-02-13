# -*- coding: utf-8 -*-
"""
Created on Thu Jan 28 14:52:19 2021

@author: xinx_
"""

import numpy as np
import pandas as pd

# NumPy数据类型体系

ints = np.ones(10, dtype=np.uint16)
np.issubdtype(ints.dtype, np.integer)
floats = np.ones(10, dtype=np.float32)
np.issubdtype(floats.dtype, np.floating)

np.float64.mro()

# 数据重塑
arr = np.arange(8)
arr
arr.reshape((4, 2))
arr.reshape((4, 2)).reshape((2, 4))

arr = np.arange(15)
arr.reshape((5, -1))

other_arr = np.ones((3, 5))
other_arr.shape
arr.reshape(other_arr.shape)

arr = np.arange(15).reshape((5, 3))
arr
arr.ravel()
arr.flatten()

# C和Fortran顺序
arr = np.arange(12).reshape((3, 4))
arr
arr.ravel()
arr.ravel('F')

# 数组的合并和拆分
arr1 = np.array([[1, 2, 3], [4, 5, 6]])
arr2 = np.array([[7, 8, 9], [10, 11, 12]])
np.concatenate([arr1, arr2], axis=0)
np.concatenate([arr1, arr2], axis=1)

np.vstack((arr1, arr2))
np.hstack((arr1, arr2))

arr = np.random.randn(5, 2)
arr
first, second, third = np.split(arr, [1, 3])
first
second
third

# 堆叠
arr = np.arange(6)
arr1 = arr.reshape((3, 2))
arr2 = np.random.randn(3, 2)
np.r_[arr1, arr2]
np.c_[np.r_[arr1, arr2], arr]
np.c_[1:6, -10:-5]

# 元素的重复操作
arr = np.arange(3)
arr.repeat(3)
arr.repeat([2, 3, 4])

arr = np.random.randn(2, 2)
arr
arr.repeat(2, axis=0)
arr.repeat([2, 3], axis=0)
arr.repeat([2, 3], axis=1)

arr
np.tile(arr, 2)
np.tile(arr, (2, 1))
np.tile(arr, (3, 2))

# 花式索引的替代函数
arr = np.arange(10)*100
inds = [7, 1, 2, 6]
arr[inds]

inds = [1, 0, 1, 1]
arr = np.random.randn(2, 4)
arr
arr.take(inds, axis=1)
arr.take(inds, axis=0)

arr = np.arange(10)
inds = [3, 5, 7]
arr.put(inds, 42)
arr
arr.put(inds, [35, 67, 90, 85])
arr
arr.put(inds, [20, 87])
arr

# 广播
arr = np.random.randn(4, 3)
arr
arr.mean(axis=0)
demeaned = arr-arr.mean(axis=0)
demeaned
demeaned.mean(axis=0)

arr
rows_means = arr.mean(axis=1)
rows_means.reshape((4, 1))
demeaned = arr-rows_means.reshape((4, 1))
demeaned.mean(1)

arr = np.zeros((4, 4))
arr_3d = arr[:, np.newaxis, :]
arr_3d.shape
arr_1d = np.random.normal(size=3)
arr_1d[:, np.newaxis]
arr_1d[np.newaxis, :]

arr = np.random.randn(3, 4, 5)
depth_means = arr.mean(2)
depth_means
demeaned = arr-depth_means[:, :, np.newaxis]
demeaned.mean(2)

arr = np.zeros((4, 3))
arr[:] = 5
arr

col = np.array([1.28, -0.42, 0.44, 1.6])
arr[:] = col[:, np.newaxis]
arr
arr[:2] = [[-1.37], [0.509]]
arr

# ufunc实例方法
arr = np.arange(10)
np.add.reduce(arr)
arr.sum()

arr = np.random.randn(5, 5)
arr[::2].sort(1) # 对部分行进行排序
arr[:, :-1] < arr[:, 1:]
np.logical_and.reduce(arr[:, :-1] < arr[:, 1:], axis=1)

arr = np.arange(15).reshape((3, 5))
arr
np.add.accumulate(arr, axis=1)

arr = np.arange(3).repeat([1, 2, 2])
arr
np.multiply.outer(arr, np.arange(5))
result = np.subtract.outer(np.random.randn(3, 4), np.random.randn(5))
result.shape

arr = np.arange(10)
np.add.reduceat(arr, [0, 5, 8])

arr = np.multiply.outer(np.arange(4), np.arange(5))
arr
np.add.reduceat(arr, [0, 2, 4], axis=1)

# 自定义ufunc
def add_elements(x, y):
    return x+y
add_them = np.frompyfunc(add_elements, 2, 1)
add_them(np.arange(8), np.arange(8))

add_them = np.vectorize(add_elements, otypes=[np.float64])
add_them(np.arange(8), np.arange(8))

arr = np.random.randn(10000)
%timeit add_them(arr, arr)
%timeit np.add(arr, arr)

# 结构化和记录式数组
dtype = [('x', np.float64), ('y', np.int32)]
sarr = np.array([(1.5, 6), (np.pi, -2)], dtype=dtype)
sarr
sarr[0]
sarr[0]['y']
sarr['x']

# 嵌套dtype和多维字段
dtype = [('x', np.int64, 3), ('y', np.int32)]
arr = np.zeros(4, dtype=dtype)
arr
arr[0]['x']
arr['x']
dtype = [('x', [('a', 'f8'), ('b', 'f4')]), ('y', np.int32)]
data = np.array([((1, 2), 5), ((3, 4), 6)], dtype=dtype)
data['x']
data['y']
data['x']['a']

# 排序
arr = np.random.randn(6)
arr
arr.sort()
arr

arr = np.random.randn(3, 5)
arr
arr[:, 0].sort() # sort first column values in-place
arr

arr = np.random.randn(5)
arr
arr1 = np.sort(arr)
arr
arr1

arr = np.random.randn(3, 5)
arr
arr.sort(axis=1)
arr

arr[:, ::-1]
arr[::-1, :]

# 间接排序
values = np.array([5, 0, 1, 3, 2])
indexer = values.argsort()
indexer
values[indexer]

arr = np.random.randn(3, 5)
arr[0] = values
arr
arr[:, arr[0].argsort()]

first_name = np.array(['Bob', 'Jane', 'Steve', 'Bill', 'Barbara'])
last_name = np.array(['Jones', 'Arnold', 'Arnold', 'Jones', 'Walters'])
sorter = np.lexsort((first_name, last_name))
print(last_name[sorter], first_name[sorter])

# 其他排序算法
values = np.array(['2:first', '2:second', '1:first', '1:second', '1:third'])
key = np.array([2, 2, 1, 1, 1])
indexer = key.argsort(kind='mergesort')
indexer
values.take(indexer)

# numpy.searchsorted:在有序数组中查找元素
arr = np.array([0, 1, 7, 12, 15])
arr.searchsorted(9)
arr.searchsorted([0, 8, 11, 16])

data = np.floor(np.random.uniform(0, 1000, size=50))
bins = np.array([0, 10, 100, 500, 1000])
data
labels = bins.searchsorted(data)
labels
pd.Series(data).groupby(labels).mean()
np.digitize(data, bins)

# NumPy的matrix类
X = np.array(np.random.randn(4, 4))
X[:, 0] # 一维的
y = X[:, :1] # 切片操作可产生二维结果
y
np.dot(y.T, np.dot(X, y))

Xm = np.matrix(X)
Xm
ym = Xm[:, 0]
ym
ym.T * Xm * ym
Xm.I * X

# 内存映像文件
mmap = np.memmap('mymmap', dtype='float64', mode='w+', shape=(10000, 10000))
mmap
section = mmap[:5]
section[:] = np.random.randn(5, 10000)
mmap.flush()
mmap
del mmap
mmap = np.memmap('mymmap', dtype='float64', shape=(10000, 10000))
mmap
