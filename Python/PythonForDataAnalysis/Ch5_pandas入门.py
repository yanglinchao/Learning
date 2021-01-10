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

# 丢弃指定轴上的项
obj = pd.Series(np.arange(5.), index=['a', 'b', 'c', 'd', 'e'])
new_obj = obj.drop('c')
new_obj
obj.drop(['d', 'c'])
# 对于DataFrame，可以删除任意轴上的索引值
data = pd.DataFrame(np.arange(16).reshape((4, 4)),
                    index=['Ohio', 'Colorado', 'Utah', 'New York'],
                    columns=['one', 'two', 'three', 'four'])
data.drop(['Colorado', 'Ohio'])
data.drop('two', axis=1)
data.drop(['two', 'four'], axis=1)

# 索引、选取和过滤
obj = pd.Series(np.arange(4.), index=['a', 'b', 'c', 'd'])
obj['b']
obj[1]
obj[[1, 3]]
obj[obj < 2]
# 利用标签进行切片
obj['b':'c']
obj['b':'c'] = 5
obj
# 对DataFrame进行索引
data = pd.DataFrame(np.arange(16).reshape((4, 4)),
                    index=['Ohio', 'Colorado', 'Utah', 'New York'],
                    columns=['one', 'two', 'three', 'four'])
data['two']
data[['three', 'one']]
data[:2]
data[data['three']>5]
data < 5
data[data<5]
data[data<5] = 0
data

data.loc['Colorado', ['two', 'three']]
data.iloc[2]
data.loc[:'Utah', 'two']

# 算术运算和数据对齐
s1 = pd.Series([7.3, -2.5, 3.4, 1.5], index=['a', 'c', 'd', 'e'])
s2 = pd.Series([-2.1, 3.6, -1.5, 4, 3.1], index=['a', 'c', 'e', 'f', 'g'])
s1+s2
df1 = pd.DataFrame(np.arange(9.).reshape((3, 3)), columns=list('bcd'),
                   index=['Ohio', 'Texas', 'Colorado'])
df2 = pd.DataFrame(np.arange(12.).reshape((4, 3)), columns=list('bde'),
                   index=['Utah', 'Ohio', 'Texas', 'Oregon'])
df1+df2
# 在算术方法中填充值
df1 = pd.DataFrame(np.arange(12.).reshape((3, 4)), columns=list('abcd'))
df2 = pd.DataFrame(np.arange(20.).reshape((4, 5)), columns=list('abcde'))
df1+df2
df1.add(df2, fill_value=0)

# DataFrame和Series之间的运算
frame = pd.DataFrame(np.arange(12.).reshape((4, 3)), columns=list('bde'),
                     index=['Utah', 'Ohio', 'Texas', 'Oregon'])
series = frame.iloc[0]
frame
series
frame-series
series2 = pd.Series(range(3), index=['b', 'e', 'f'])
frame+series2
series3=frame['d']
frame.sub(series3, axis=0)

# 函数应用和映射
frame = pd.DataFrame(np.random.randn(4, 3), columns=list('bde'),
                     index=['Utah', 'Ohio', 'Texas', 'Oregon'])
np.abs(frame)

f = lambda x: x.max() - x.min()
frame.apply(f, axis=0)
frame.apply(f, axis=1)

def f(x):
    return pd.Series([x.min(), x.max()], index=['min', 'max'])
frame.apply(f)

format = lambda x: '%.2f' % x
frame.applymap(format)
frame['e'].map(format)

# 排序和排名
obj = pd.Series(range(4), index=['d', 'a', 'b', 'c'])
obj
obj.sort_index()

frame = pd.DataFrame(np.arange(8).reshape((2, 4)), index=['three', 'one'],
                     columns=['d', 'a', 'b', 'c'])
frame.sort_index(axis=0)
frame.sort_index(axis=1)
frame.sort_index(axis=1, ascending=False) #按降序排列

frame = pd.DataFrame({'b':[4, 7, -3, 2], 
                      'a':[0, 1, 0, 1]})
frame
frame.sort_values(by='b')
frame.sort_values(by=['a', 'b'])

# 对Series进行排序
obj = pd.Series([4, np.nan, 7, np.nan, -3, 2])
obj.sort_values()

# 排名
obj = pd.Series([7, -5, 7, 4, 2, 0, 4])
obj.rank()
obj.rank(method='first')
obj.rank(ascending=False, method='max')

frame = pd.DataFrame({'b':[4.3, 7, -3, 2],
                      'a':[0, 1, 0, 1],
                      'c':[-2, 5, 8, -2.5]})
frame
frame.rank(axis=1)

# 带有重复值的轴索引
obj = pd.Series(range(5), index=['a', 'a', 'b', 'b', 'c'])
obj.index.is_unique
obj['a']
obj['c']

df = pd.DataFrame(np.random.randn(4, 3),
                  index=['a', 'a', 'b', 'b'])
df.loc['b']

# 汇总
df = pd.DataFrame([[1.4, np.nan], [7.1, -4.5],
                   [np.nan, np.nan], [0.75, -1.3]],
                  index=['a', 'b', 'c', 'd'],
                  columns=['one', 'two'])
df
df.sum(axis=0)
df.sum(axis=1)
df.mean(axis=1, skipna=False)
df.idxmax() #间接统计型方法
df.cumsum() #累计型方法

# 导入股票价格和成交量数据
import pandas_datareader.data as web
all_data = {}
for ticker in ['AAPL', 'IBM', 'MSFT', 'GOOG']:
    all_data[ticker] = web.get_data_yahoo(ticker, '1/1/2000', '1/1/2010')
price = pd.DataFrame({tic:data['Adj Close']
                      for tic, data in all_data.items()})
volume = pd.DataFrame({tic:data['Volume']
                       for tic, data in all_data.items()})
# 计算价格的百分数变化
returns = price.pct_change()
returns.tail()
# 计算相关系数和协方差
returns.MSFT.corr(returns.IBM) #计算相关系数
returns.MSFT.cov(returns.IBM) #计算协方差
returns.corr() #DataFrame的corr
returns.cov() #DataFrame的cov
returns.corrwith(returns.IBM)
returns.corrwith(volume)

# 唯一值
obj = pd.Series(['c', 'a', 'd', 'a', 'a', 'b', 'b', 'c', 'c'])
uniques = obj.unique()
uniques
# 计算频率
obj.value_counts() #计算一个Series中各值出现的频率
pd.value_counts(obj.values) #返回出现的频率
# 成员资格
mask = obj.isin(['b', 'c'])
mask
obj[mask]

data = pd.DataFrame({'Qu1':[1, 3, 4, 3, 4],
                     'Qu2':[2, 3, 1, 2, 3],
                     'Qu3':[1, 5, 2, 4, 4]})
data
data.apply(pd.value_counts).fillna(0)

# 滤除缺失数据
from numpy import nan as NA
data = pd.Series([1, NA, 3.5, NA, 7])
data.dropna()
data[data.notnull()]

data = pd.DataFrame([[1., 6.5, 3.], [1., NA, NA],
                     [NA, NA, NA], [NA, 6.5, 3.]])
cleaned = data.dropna()
data
cleaned
#只丢弃全为NA的行
data.dropna(how='all')
#只丢弃全为NA的列
data.dropna(how='all', axis=1)

df = pd.DataFrame(np.random.randn(7, 3))
df.iloc[:4, 1] = NA; df.iloc[:2, 2] = NA
df
df.dropna(thresh=3)

# 填充缺失值
df = pd.DataFrame(np.random.randn(7, 3))
df.iloc[:4, 1] = NA; df.iloc[:2, 2] = NA
df.fillna(0)
df.fillna({1:0.5, 3:-1})
df.fillna(0, inplace=True)

df = pd.DataFrame(np.random.randn(6, 3))
df.iloc[2:, 1] = NA; df.iloc[4:, 2] = NA
df
df.fillna(method='ffill')
df.fillna(method='ffill', limit=2)

data = pd.Series([1., NA, 3.5, NA, 7])
data.fillna(data.mean()) #使用平均值填充

# 层次化索引
data = pd.Series(np.random.randn(10),
                 index=[['a', 'a', 'a', 'b', 'b', 'b', 'c', 'c', 'd', 'd'],
                        [1, 2, 3, 1, 2, 3, 1, 2, 2, 3]])
data
data.index
data['b']
data['b':'c']
data.loc[['b', 'd']]
data[:, 2] #在内层进行索引

data.unstack()
data.unstack().stack() #unstack的逆运算是stack

frame = pd.DataFrame(np.arange(12).reshape((4, 3)),
                     index=[['a', 'a', 'b', 'b'], [1, 2, 1, 2]],
                     columns=[['Ohio', 'Ohio', 'Colorado'],
                              ['Green', 'Red', 'Green']])
frame
frame.index.names = ['key1', 'key2']
frame.columns.names = ['state', 'color']
frame
frame['Ohio']

# 重排分级顺序
frame.swaplevel('key1', 'key2')
frame.sort_index(level=1)
frame.swaplevel(0, 1).sort_index(0)
# 根据级别汇总统计
frame = pd.DataFrame(np.arange(12).reshape((4, 3)),
                     index=[['a', 'a', 'b', 'b'], [1, 2, 1, 2]],
                     columns=[['Ohio', 'Ohio', 'Colorado'],
                              ['Green', 'Red', 'Green']])
frame.index.names = ['key1', 'key2']
frame.columns.names = ['state', 'color']
frame
frame.sum(level='key2')
frame.sum(level='color', axis=1)

# 使用DataFrame的列
frame = pd.DataFrame({'a':range(7),
                      'b':range(7, 0, -1),
                      'c':['one', 'one', 'one', 'two', 'two', 'two', 'two'],
                      'd':[0, 1, 2, 0, 1, 2, 3]})
frame
frame2 = frame.set_index(['c', 'd'])
frame2
frame.set_index(['c', 'd'], drop=False)
frame2.reset_index()

# 整数索引
ser3 = pd.Series(range(3), index=[-5, 1, 3])
ser3
ser3.iat[2]
frame = pd.DataFrame(np.arange(6).reshape(3, 2),
                     index=[2, 0, 1])
frame.iloc[0, 1]
