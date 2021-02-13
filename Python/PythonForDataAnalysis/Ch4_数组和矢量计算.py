# -*- coding: utf-8 -*-
"""
Created on Sat Jan  2 13:57:49 2021

@author: ylc
"""

import numpy as np

# 使用np.array()创建数组
data1 = [1, 2, 3, 4]
arr1 = np.array(data1)
arr1

data2 = [[1, 2, 3, 4], [5, 6, 7, 8]]
arr2 = np.array(data2)
arr2

# 使用zeros()和ones()创建指定长度或形状的全0或全1数组
# 使用empty()创建一个没有任何具体值的数组
np.zeros(10)
np.ones((3, 6))
np.empty((2, 3, 4))

# 通过ndarray的astype方法显式地转换其dtype
arr = np.array([1, 2, 3, 4, 5])
arr.dtype
float_arr = arr.astype(np.float64)
float_arr
# 浮点数转换成整数，小数部分将会被截断
arr = np.array([3.7, -1.2, -2.6, 0.5, 12.9, 10.1])
arr
arr.astype(np.int32)
# 某字符串表示的全是数字，也可以用astype将其转换为数值形式
numeric_strings = np.array(['1.25', '-9.6', '42'], dtype = np.string_)
numeric_strings.astype(float)

int_array = np.arange(10)
calibers = np.array([.22, .270, .357, .380, .44, .50], dtype=np.float64)
int_array.astype(calibers.dtype)

empty_uint32 = np.empty(8, dtype='u4')
empty_uint32

# 数组和标量之间的运算
arr = np.array([[1., 2., 3.], [4., 5., 6.]])
arr * arr
arr - arr
1 / arr
arr ** 0.5

# 数据索引和切片，将一个标量赋值给一个切片时，该值会自动传播到整个选区
arr = np.arange(10)
arr
arr[5]
arr[5:8]
arr[5:8] = 12
arr
arr_slice = arr[5:8]
arr_slice[1] = 12345
arr
arr_slice[:] = 64
arr
# 高维数组
arr2d = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
arr2d[2]
arr2d[0][2]
arr2d[0, 2]
arr3d = np.array([[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]])
arr3d
arr3d[0]
old_values = arr3d[0].copy()
arr3d[0] = 42
arr3d
arr3d[0] = old_values
arr3d
arr3d[1, 0]
# 切片
arr2d
arr2d[:2]
arr2d[:2, 1:]
arr2d[1, :2]
arr2d[2, :1]
arr2d[:, :1]
arr2d[:2, 1:] = 0
arr2d

# 布尔型索引
names = np.array(['Bob', 'Joe', 'Will', 'Bob', 'Will', 'Joe', 'Joe'])
data = np.random.randn(7, 4)
names
data
names == 'Bob'
data[names == 'Bob']
data[names == 'Bob', 2:]
data[names == 'Bob', 3]
names != 'Bob'
mask = (names == 'Bob')|(names == 'Will')
mask
data[mask]
data[data<0]=0
data
data[names != 'Joe'] = 7
data

# 花式索引
arr = np.empty((8, 4))
for i in range(8):
    arr[i]=i
arr
# 为了以特定顺序选取行子级，只需传入一个用于指定顺序的整数列表或ndarray
arr[[4, 3, 0, 6]]
# 使用负数索引将会从末尾开始选取行
arr[[-3, -5, -7]]
# 一次传入多个索引数组返回的是一个一维数组，其中的元素对应各个索引元组
arr = np.arange(32).reshape((8, 4))
arr[[1, 5, 7, 2], [0, 3, 1, 2]]
# 如果想按顺序提取矩形区域，应该按照下述方式
arr[[1, 5, 7, 2]][:, [0, 3, 1, 2]]
# 或者使用np.ix_函数，它可以将两个一维整数数组转换为一个用于选取方形区域的索引器
arr[np.ix_([1, 5, 7, 2], [0, 3, 1, 2])]

# 数组转置和轴对换
arr = np.arange(15).reshape((3, 5))
arr
arr.T
# 利用np.dot计算矩阵内积
arr = np.random.randn(6, 3)
np.dot(arr.T, arr)
# 高维数组
arr = np.arange(16).reshape(2, 2, 4)
arr
arr.transpose((1, 0, 2))
# 简单的转置可以使用.T，其实就是进行轴对换，或者使用swapaxes()
arr
arr.swapaxes(1, 2)

# 通用函数
# 一元通用函数
arr = np.arange(10)
arr
np.sqrt(arr)
np.exp(arr)
# 二元通用函数
x = np.random.randn(8)
y = np.random.randn(8)
x
y
np.maximum(x, y) # 元素级最大值
arr = np.random.randn(7)*5
arr
np.modf(arr)

# 矢量化数组运算
points = np.arange(-5, 5, 1)
points
xs, ys = np.meshgrid(points, points)
xs
ys
import matplotlib.pyplot as plt
z = np.sqrt(xs**2 + ys**2)
z
plt.imshow(z, cmap=plt.cm.gray); plt.colorbar()
plt.title("Image plot of $\sqrt{x^2+y^2}$ for a grid of values")

# 将条件逻辑表述为数组运算
xarr = np.array([1.1, 1.2, 1.3, 1.4, 1.5])
yarr = np.array([2.1, 2.2, 2.3, 2.4, 2.5])
cond = np.array([True, False, True, True, False])
result = [(x if c else y)
          for x, y, c in zip(xarr, yarr, cond)]
result
result = np.where(cond, xarr, yarr)
result
# 假设有一个随机数据组成的矩阵，希望将所有正值替换为2，将所有负值替换为-2
arr = np.random.randn(4, 4)
arr
np.where(arr>0, 2, -2)
np.where(arr>0, 2, arr) # 只将正值设置为2

arr = np.random.randn(5, 4) # 正态分布的数据
arr.mean()
np.mean(arr)
arr.sum()
np.sum(arr)
arr
arr.mean(axis=0)
arr.mean(axis=1)
arr = np.array([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
arr
arr.cumsum(0)
arr.cumsum(1)
arr.cumprod(1)

# 用于布尔型数组的方法
arr = np.random.randn(100)
(arr>0).sum()
bools = np.array([False, False, True, False])
bools.any()
bools.all()

# 唯一化及其他集合的逻辑
names = np.array(['Bob', 'Joe', 'Will', 'Bob', 'Will', 'Joe', 'Joe'])
np.unique(names)
ints = np.array([3, 3, 3, 2, 2, 2, 1, 1, 4, 4])
np.unique(ints)
# 测试一个数组中的值在另一个数组中的成员资格
values = np.array([6, 0, 0, 3, 2, 5, 6])
np.in1d(values, [2, 3, 6])

# 排序
arr = np.random.rand(8)
arr
arr.sort()
arr
# 多维数组可以在任何一个轴向进行排序
arr = np.random.randn(3, 3)
arr
arr.sort(axis=0)
arr

# 将数组以二进制格式保存到磁盘
arr = np.arange(10)
np.save('some_array', arr)
np.load('some_array.npy')
np.savez('array_archive.npz', a=arr, b=arr)
arch = np.load('array_archive.npz')
arch['b']

# 存取文本文件
arr = np.loadtxt('array_ex.txt', delimiter=',')
np.savetxt('array_ex.txt', arr, delimiter=',')


# 线性代数
x = np.array([[1, 2, 3], [4, 5, 6]])
y = np.array([[6, 23], [-1, 7], [8, 9]])
x
y
x.dot(y) # 相当于np.dot(x, y)
np.dot(x, np.ones(3))

from numpy.linalg import inv, qr
X = np.random.randn(5, 5)
mat = X.T.dot(X)
inv(mat)
mat.dot(inv(mat))
q, r = qr(mat)
r

# 随机数产生
from random import normalvariate
N = 1000000
%timeit samples = [normalvariate(0, 1) for _ in xrange(N)]
%timeit np.random.normal(size=N)

# 随机漫步
nsteps = 1000
draws = np.random.randint(0, 2, size=nsteps)
steps = np.where(draws>0, 1, -1)
walk = steps.cumsum()
walk.min()
walk.max()
# 第一次到达10的步数
(np.abs(walk)>=10).argmax()

# 一次模拟多个随机漫步
nwalks = 5000
nsteps = 1000
draws = np.random.randint(0, 2, size=(nwalks, nsteps)) # 0或1
steps = np.where(draws>0, -1, 1)
walks = steps.cumsum(1)
walks
# 所有随机漫步过程的最大值和最小值
walks.max()
walks.min()
# 计算30或-30的最小穿越时间
hits30 = (np.abs(walks)>=30).any(1)
hits30
hits30.sum() # 到达30或-30的数量
# 利用布尔型数组选出穿越了30的随机漫步，并调用argmax在轴1上获取穿越时间
crossing_times = (np.abs(walks[hits30]) >=30).argmax(1)
crossing_times.mean()
