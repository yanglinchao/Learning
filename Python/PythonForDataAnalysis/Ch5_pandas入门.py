# -*- coding: utf-8 -*-
"""
Created on Tue Jan  5 08:34:40 2021

@author: ylc
"""

import pandas as pd
import numpy as np

# pandas的数据结构

# Series
obj = pd.Series([4, 7, -5, 3])
obj
obj.values
obj.index
# 对各个数据点进行标记
obj2 = pd.Series([4, 7, -5, 3], index=['d', 'b', 'a', 'c'])
obj2
obj2.index
# 与普通NumPy数组相比，可以通过索引的方式选取Series中的单个或一组值
obj2['a']
obj2['d'] = 6
obj2[['c', 'a', 'd']]
# NumPy数组运算
obj2
obj2[obj2>0]
obj2*2
np.exp(obj2)

'b' in obj2
'e' in obj2

# 通过Python字典创建Series
sdata = {'Ohio':35000, 'Texas':71000, 'Oregon':16000, 'Utah':5000}
obj3 = pd.Series(sdata)
obj3
# 如果只传入一个字典，则结果Series中的索引就是原字典的键（有序排列）
sdata = {'Ohio':35000, 'Texas':71000, 'Oregon':16000, 'Utah':5000}
states = ['California', 'Ohio', 'Oregon', 'Texas']
obj4 = pd.Series(sdata, index=states)
obj4
# 检测缺失数据
pd.isnull(obj4)
pd.notnull(obj4)
obj4.isnull()

# Series可以在算术运算中自动对齐不同索引的数据
obj3
obj4
obj3+obj4

# Series的name属性
obj4.name = 'population'
obj4.index.name = 'state'
obj4
obj4.index = ['C', 'O', 'O', 'T']
obj4

# DataFrame

# 构建DataFrame
data = {'state':['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada'],
        'year':[2000, 2001, 2002, 2001, 2002],
        'pop':[1.5, 1.7, 3.6, 2.4, 2.9]}
frame = pd.DataFrame(data)
frame
# 按照指定顺序对列进行排序
pd.DataFrame(data, columns=['year', 'state', 'pop'])
# 如果传入的列在数据中找不到，就会产生NA
frame2 = pd.DataFrame(data,
                   columns=['year', 'state', 'pop', 'debt'],
                   index=['one', 'two', 'three', 'four', 'five'])
frame2
frame2.columns

# 提取Series
# 提取列
frame2['state']
frame2.year

# 通过字典标记的方式或属性的方式，将DataFrame的列获取为一个Series
frame2['state']
frame2.year
frame2.loc['three']

# 给列赋值
frame2['debt'] = 16.5
frame2
frame2['debt'] = np.arange(5.)
frame2

val = pd.Series([-1.2, -1.5, -1.7], index=['two', 'four', 'five'])
frame2['debt'] = val
frame2

frame2['eastern'] = frame2.state == 'Ohio'
frame2

# 删除列
del frame2['eastern']
frame2

# 嵌套字典
pop = {'Nevada':{2001:2.4, 2002:2.9},
       'Ohio':{2000:1.5, 2001:1.7, 2002:3.6}}
frame3 = pd.DataFrame(pop)
frame3
pd.DataFrame(pop, index=[2001, 2002, 2003])

# 属性
frame3.index.name = 'year'; frame3.columns.name = 'state'
frame3
frame3.values
frame2.values

# 索引
obj = pd.Series(range(3), index=['a', 'b', 'c'])
index = obj.index
index
index[1:]
frame3
'Ohio' in frame3.columns
2003 in frame3.index

# 重新索引
obj = pd.Series([4.5, 7.2, -5.3, 3.6], index=['d', 'b', 'a', 'c'])
obj2 = obj.reindex(['a', 'b', 'c', 'd', 'e'])
obj2
obj2.reindex(['a', 'b', 'c', 'd', 'e'], fill_value=0)
obj3 = pd.Series(['blue', 'purple', 'yellow'], index=[0, 2, 4])
obj3.reindex(range(6), method='ffill')

frame = pd.DataFrame(np.arange(9).reshape((3, 3)),
                     index=['a', 'c', 'd'],
                     columns=['Ohio', 'Texas', 'California'])
frame
frame2 = frame.reindex(['a', 'b', 'c', 'd'])
frame2
# 重新索引列
states = ['Texas', 'Utah', 'California']
frame.reindex(columns=states)
# 同时对行和列进行重新索引，插值只能按行应用（即轴0）
frame.reindex(index=['a', 'b', 'c', 'd'],
              columns=states)