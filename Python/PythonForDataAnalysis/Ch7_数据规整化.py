# -*- coding: utf-8 -*-
"""
Created on Mon Jan 11 03:00:38 2021

@author: ylc
"""

import numpy as np
import pandas as pd

# 数据库风格的DataFrame

df1 = pd.DataFrame({'key':['b', 'b', 'a', 'c', 'a', 'a', 'b'],
                    'data1':range(7)})
df2 = pd.DataFrame({'key':['a', 'b', 'd'],
                    'data2':range(3)})
df1
df2
pd.merge(df1, df2)
pd.merge(df1, df2, on='key') # 显式指定键

# 分别指定列名
df3 = pd.DataFrame({'lkey':['b', 'b', 'a', 'c', 'a', 'a', 'b'],
                    'data1':range(7)})
df4 = pd.DataFrame({'rkey':['a', 'b', 'd'],
                    'data2':range(3)})
pd.merge(df3, df4, left_on='lkey', right_on='rkey')
pd.merge(df1, df2, how='outer')

df1 = pd.DataFrame({'key':['b', 'b', 'a', 'c', 'a', 'b'],
                    'data1':range(6)})
df2 = pd.DataFrame({'key':['a', 'b', 'a', 'b', 'd'],
                    'data2':range(5)})
df1
df2
pd.merge(df1, df2, on='key')
pd.merge(df1, df2, on='key', how='inner')
pd.merge(df1, df2, on='key', how='left')
pd.merge(df1, df2, on='key', how='right')
pd.merge(df1, df2, on='key', how='outer')

# 多个键进行合并
left = pd.DataFrame({'key1':['foo', 'foo', 'bar'],
                     'key2':['one', 'two', 'one'],
                     'lval':[1, 2, 3]})
right = pd.DataFrame({"key1":['foo', 'foo', 'bar', 'bar'],
                      "key2":['one', 'one', 'one', 'two'],
                      'rval':[4, 5, 6, 7]})
pd.merge(left, right, on=['key1', 'key2'], how='outer')
# 重复列名
pd.merge(left, right, on='key1')
pd.merge(left, right, on='key1', suffixes=('_left', '_right'))

# 索引上的合并
left1 = pd.DataFrame({'key':['a', 'b', 'a', 'a', 'b', 'c'],
                      'value':range(6)})
right1 = pd.DataFrame({'group_val':[3.5, 7]}, index=['a', 'b'])
left1
right1
pd.merge(left1, right1,
         left_on='key',
         right_index=True)
pd.merge(left1, right1,
         left_on='key',
         right_index=True,
         how='outer')

# 层次化索引的合并
lefth = pd.DataFrame({'key1':['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada'],
                      'key2':[2000, 2001, 2002, 2001, 2002],
                      'data':np.arange(5.)})
righth = pd.DataFrame(np.arange(12).reshape((6, 2)),
                      index=[['Nevada', 'Nevada', 'Ohio', 'Ohio', 'Ohio', 'Ohio'],
                             [2001, 2000, 2000, 2000, 2001, 2002]],
                      columns=['event1', 'event2'])
lefth
righth
pd.merge(lefth, righth, left_on=['key1', 'key2'], right_index=True)
pd.merge(lefth, righth, left_on=['key1', 'key2'], right_index=True, how='outer')

# 合并双方的索引
left2 = pd.DataFrame([[1., 2.], [3., 4.], [5., 6.]], index=['a', 'c', 'e'],
                     columns=['Ohio', 'Nevada'])
right2 = pd.DataFrame([[7., 8.], [9., 10.], [11., 12.], [13., 14.]],
                      index=['b', 'c', 'd', 'e'], columns=['Missouri', 'Alabama'])
left2
right2
pd.merge(left2, right2, how='outer', left_index=True, right_index=True)

# join方法
left2 = pd.DataFrame([[1., 2.], [3., 4.], [5., 6.]], index=['a', 'c', 'e'],
                     columns=['Ohio', 'Nevada'])
right2 = pd.DataFrame([[7., 8.], [9., 10.], [11., 12.], [13., 14.]],
                      index=['b', 'c', 'd', 'e'], columns=['Missouri', 'Alabama'])
left2.join(right2)
left2.join(right2, how='outer')

left1 = pd.DataFrame({'key':['a', 'b', 'a', 'a', 'b', 'c'], 'value':range(6)})
right1 = pd.DataFrame({'group_val':[3.5, 7]}, index=['a', 'b'])
left1.join(right1, on='key')

# 传入DataFrame
another = pd.DataFrame([[7., 8.], [9., 10.], [11., 12.], [16., 17.]],
                       index=['a', 'c', 'e', 'f'], columns=['New York', 'Oregon'])
left2.join([right2, another])
left2.join([right2, another], how='outer')

# 轴向连接
arr = np.arange(12).reshape((3, 4))
arr
np.concatenate([arr, arr], axis=1)

s1 = pd.Series([0, 1], index=['a', 'b'])
s2 = pd.Series([2, 3, 4], index=['c', 'd', 'e'])
s3 = pd.Series([5, 6], index=['f', 'g'])
pd.concat([s1, s2, s3])
pd.concat([s1, s2, s3], axis=1)

s1
s4 = pd.concat([s1*5, s3])
s4
pd.concat([s1, s4], axis=1)
pd.concat([s1, s4], axis=1, join='inner')

pd.concat([s1, s1, s3],
          keys=['one', 'two', 'three'])
pd.concat([s1, s1, s3], axis=1,
          keys=['one', 'two', 'three'])

df1 = pd.DataFrame(np.arange(6).reshape(3, 2), index=['a', 'b', 'c'], columns=['one', 'two'])
df2 = pd.DataFrame(5+np.arange(4).reshape(2, 2), index=['a', 'c'], columns=['three', 'four'])
pd.concat([df1, df2])
pd.concat([df1, df2], axis=1)
pd.concat([df1, df2], axis=1, keys=['level1', 'level2'])
pd.concat({'level1':df1, 'level2':df2}, axis=1)
pd.concat([df1, df2], axis=1, keys=['level1', 'level2'], names=['upper', 'lower'])

df1 = pd.DataFrame(np.random.randn(3, 4), columns=['a', 'b', 'c', 'd'])
df2 = pd.DataFrame(np.random.randn(2, 3), columns=['b', 'd', 'a'])
pd.concat([df1, df2], ignore_index=True)

# 合并重叠数据
a = pd.Series([np.nan, 2.5, np.nan, 3.5, 4.5, np.nan], index=['f', 'e', 'd', 'c', 'b', 'a'])
b = pd.Series(np.arange(len(a), dtype=np.float64), index=['f', 'e', 'd', 'c', 'b', 'a'])
b[-1] = np.nan
np.where(pd.isnull(a), b, a)
b[:-2].combine_first(a[2:])

df1 = pd.DataFrame({'a':[1., np.nan, 5., np.nan],
                    'b':[np.nan, 2., np.nan, 6.],
                    'c':range(2, 18, 4)})
df2 = pd.DataFrame({'a':[5., 4., np.nan, 3., 7.],
                    'b':[np.nan, 3., 4., 6., 8.]})
df1
df2
df1.combine_first(df2)

# 重塑层次化索引
data = pd.DataFrame(np.arange(6).reshape((2, 3)),
                    index=pd.Index(['Ohio', 'Colorado'], name='state'),
                    columns=pd.Index(['one', 'two', 'three'], name='number'))
data
result = data.stack()
result
result.unstack()
result.unstack(0)
result.unstack('state')

s1 = pd.Series([0, 1, 2, 3], index=['a', 'b', 'c', 'd'])
s2 = pd.Series([4, 5, 6], index=['c', 'd', 'e'])
data2 = pd.concat([s1, s2], keys=['one', 'two'])
data2.unstack()
data2.unstack().stack()
data2.unstack().stack(dropna=False)
df = pd.DataFrame({'left':result, 'right':result+5},
                  columns=pd.Index(['left', 'right'], name='side'))
df
df.unstack('state')
df.unstack('state').stack('side')

# 将“长格式”旋转为“宽格式”
ldata = pd.read_csv('macrodata.csv')
ldata[:10]
pivoted = pd.pivot_table(ldata,
                         values='value',
                         index='date',
                         columns='item')
pivoted.head()

ldata['value2'] = np.random.randn(len(ldata))
ldata[:10]
pivoted = pd.pivot_table(ldata,
                         index='date',
                         columns='item')
pivoted.head()

# 数据转换

# 移除重复数据
data = pd.DataFrame({'k1':['one']*3 + ['two']*4,
                     'k2':[1, 1, 2, 3, 3, 4, 4]})
data.duplicated()
data.drop_duplicates()
data['v1'] = range(7)
data.drop_duplicates(['k1'])
data.drop_duplicates(['k1', 'k2'], keep='last')

# 利用函数或映射进行数据转换
data = pd.DataFrame({'food':['bacon', 'pulled pork', 'bacon', 'Pastrami',
                             'corned beef', 'Bacon', 'pastrami', 'honey ham',
                             'nava lox'],
                     'ounces':[4, 3, 12, 6, 7.5, 8, 3, 5, 6]})
data
meat_to_animal = {'bacon':'pig', 'pulled pork':'pig', 'pastrami':'cow',
                  'corned beef':'cow', 'honey ham':'pig', 'nova lox':'salmon'}
data['animal'] = data['food'].map(str.lower).map(meat_to_animal)
data

# 替换值
data = pd.Series([1., -999., 2., -999., -1000., 3.])
data
data.replace(-999, np.nan)
data.replace([-999, -1000], np.nan)
data.replace({-999:np.nan, -1000:0})

# 重命名轴索引
data = pd.DataFrame(np.arange(12).reshape((3, 4)),
                    index=['Ohio', 'Colorado', 'New York'],
                    columns=['one', 'two', 'three', 'four'])
data.index = data.index.map(str.upper)
data
data.rename(index=str.title, columns=str.upper)
data.rename(index={'OHIO':'INDIANA'}, columns={'three':'peekaboo'})
_ = data.rename(index={'OHIO':'INDIANA'}, inplace=True)
data

# 离散化和面元划分
ages = [20, 22, 25, 27, 21, 23, 37, 31, 61, 45, 41, 32]
bins = [18, 25, 35, 60, 100]
cats = pd.cut(ages, bins)
cats
cats.codes
cats.categories
pd.value_counts(cats)
pd.cut(ages, [18, 26, 36, 61, 100], right=False)

group_names = ['Youth', 'YoungAdult', 'MiddleAged', 'Senior']
pd.cut(ages, bins, labels=group_names)

data = np.random.rand(20)
data
pd.cut(data, 4, precision=2)

data = np.random.randn(1000) # 正态分布
cats = pd.qcut(data, 4) # 按四分位数进行切割
cats
pd.value_counts(cats)
pd.qcut(data, [0, 0.1, 0.5, 0.9, 1.])

# 检测和过滤异常值
np.random.seed(12345)
data = pd.DataFrame(np.random.randn(1000, 4))
data.describe()
col = data[3]
col[np.abs(col)>3]
data[(np.abs(data)>3).any(1)]
data[np.abs(data)>3] = np.sign(data)*3
data.describe()
