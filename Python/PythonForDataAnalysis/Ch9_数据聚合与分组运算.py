# -*- coding: utf-8 -*-
"""
Created on Sun Jan 24 10:10:30 2021

@author: xinx_
"""

import numpy as np
import pandas as pd

df = pd.DataFrame({'key1':['a', 'a', 'b', 'b', 'a'],
                   'key2':['one', 'two', 'one', 'two', 'one'],
                   'data1':np.random.randn(5),
                   'data2':np.random.randn(5)})
df

grouped = df['data1'].groupby(df['key1'])
grouped

grouped.mean()

means = df['data1'].groupby([df['key1'], df['key2']]).mean()
means
means.unstack()

states = np.array(['Ohio', 'California', 'California', 'Ohio', 'Ohio'])
years = np.array([2005, 2005, 2006, 2005, 2006])
df['data1'].groupby([states, years]).mean()

df.groupby('key1').mean()
df.groupby(['key1', 'key2']).mean()

df.groupby(['key1', 'key2']).size()

# 对分组进行迭代
df = pd.DataFrame({'key1':['a', 'a', 'b', 'b', 'a'],
                   'key2':['one', 'two', 'one', 'two', 'one'],
                   'data1':np.random.randn(5),
                   'data2':np.random.randn(5)})
for name, group in df.groupby('key1'):
    print(name)
    print(group)

for (k1, k2), group in df.groupby(['key1', 'key2']):
    print(k1, k2)
    print(group)

pieces = dict(list(df.groupby('key1')))
pieces['b']

df.dtypes
grouped = df.groupby(df.dtypes, axis=1)
dict(list(grouped))

# 选取一个或一组列
df = pd.DataFrame({'key1':['a', 'a', 'b', 'b', 'a'],
                   'key2':['one', 'two', 'one', 'two', 'one'],
                   'data1':np.random.randn(5),
                   'data2':np.random.randn(5)})
df.groupby(['key1', 'key2'])[['data2']].mean() # 返回DataFrame
df.groupby(['key1', 'key2'])['data2'].mean() # 返回Series


# 通过字典或Series进行分组
people = pd.DataFrame(np.random.randn(5, 5),
                      columns=['a', 'b', 'c', 'd', 'e'],
                      index=['Joe', 'Steve', 'Wes', 'Jim', 'Travis'])
people.loc[2:3, ['b', 'c']] = np.nan # 添加几个NA值
people
mapping = {'a':'red', 'b':'red', 'c':'blue',
           'd':'blue', 'e':'red', 'f':'orange'}
by_column = people.groupby(mapping, axis=1)
by_column.sum()

map_series = pd.Series(mapping)
map_series
people.groupby(map_series, axis=1).count()

# 通过函数进行分组
people = pd.DataFrame(np.random.randn(5, 5),
                      columns=['a', 'b', 'c', 'd', 'e'],
                      index=['Joe', 'Steve', 'Wes', 'Jim', 'Travis'])
people.groupby(len).sum() # 按照人名长度进行分组
key_list = ['one', 'one', 'one', 'two', 'two']
people.groupby([len, key_list]).min()

# 根据索引级别分组
columns = pd.MultiIndex.from_arrays([['US', 'US', 'US', 'JP', 'JP'],
                                     [1, 3, 5, 1, 3]], names=['cty', 'tenor'])
hier_df = pd.DataFrame(np.random.randn(4, 5), columns=columns)
hier_df
hier_df.groupby(level='cty', axis=1).count()

# 数据聚合
df = pd.DataFrame({'key1':['a', 'a', 'b', 'b', 'a'],
                   'key2':['one', 'two', 'one', 'two', 'one'],
                   'data1':np.random.randn(5),
                   'data2':np.random.randn(5)})
grouped = df.groupby('key1')
def peak_to_peak(arr):
    return arr.max()-arr.min()
grouped.agg(peak_to_peak)

# 面向列的多函数应用
tips = pd.read_csv('pydata-book/examples/tips.csv')
tips['tip_pct'] = tips['tip']/tips['total_bill'] # 添加“小费占总额百分比”的列
tips[:6]
grouped = tips.groupby(['time', 'smoker'])
grouped_pct = grouped['tip_pct']
grouped_pct.agg(['mean', 'std', peak_to_peak])
grouped_pct.agg([('foo', 'mean'), ('bar', np.std)])

functions = ["count", "mean", "max"]
result = grouped[['tip_pct', 'total_bill']].agg(functions)
result

ftuples = [('Durchschnitt', 'mean'), ('Abweichung', np.var)]
grouped[['tip_pct', 'total_bill']].agg(ftuples)

grouped.agg({'tip':np.max, 'size':'sum'})
grouped.agg({'tip_pct':['min', 'max', 'mean', 'std'], 'size':'sum'})

# 分组级运算和转换
people = pd.DataFrame(np.random.randn(5, 5),
                      columns=['a', 'b', 'c', 'd', 'e'],
                      index=['Joe', 'Steve', 'Wes', 'Jim', 'Travis'])
key = ['one', 'two', 'one', 'two', 'one']
people.groupby(key).mean()
people.groupby(key).transform(np.mean)

def demean(arr):
    return arr - arr.mean()
demeaned = people.groupby(key).transform(demean)
demeaned
demeaned.groupby(key).mean()

# apply:一般性的“拆分-应用-合并”
tips = pd.read_csv('pydata-book/examples/tips.csv')
tips['tip_pct'] = tips['tip']/tips['total_bill'] # 添加“小费占总额百分比”的列
def top(df, n=5, column='tip_pct'):
    return df.sort_values(by=column)[-n:] # 选出最高的n个column的值的行
top(tips, n=2)
tips.groupby('smoker').apply(top)
tips.groupby(['smoker', 'day']).apply(top, n=1, column='total_bill')

tips.groupby('smoker', group_keys=False).apply(top) # 禁止分组键

# 分位数和桶分析
frame = pd.DataFrame({'data1':np.random.randn(1000),
                      'data2':np.random.randn(1000)})
factor = pd.cut(frame.data1, 4)
factor[:3]
def get_stats(group):
    return {'min':group.min(), 'max':group.max(),
            'count':group.count(), 'mean':group.mean()}
grouped = frame.data2.groupby(factor)
grouped.apply(get_stats).unstack()

# 返回分位数编号
grouping = pd.qcut(frame.data1, 10, labels=False)
grouped = frame.data2.groupby(grouping)
grouped.apply(get_stats).unstack()

# 示例：用特定于分组的值填充缺失值
states = ['Ohio', 'New York', 'Vermont', 'Florida',
          'Oregon', 'Nevada', 'California', 'Idaho']
data = pd.Series(np.random.randn(8), index=states)
data[['Vermont', 'Nevada', 'Idaho']] = np.nan
data
group_key = ['East']*4 + ['West']*4
data.groupby(group_key).mean()

fill_mean = lambda g: g.fillna(g.mean())
data.groupby(group_key).apply(fill_mean)

fill_values = {'East':0.5, 'West':-1}
fill_func = lambda g: g.fillna(fill_values[g.name])
data.groupby(group_key).apply(fill_func)

# 分组加权平均数和相关系数
df = pd.DataFrame({'category':['a', 'a', 'a', 'a', 'b', 'b', 'b', 'b'],
                   'data':np.random.randn(8),
                   'weights':np.random.rand(8)})
df
grouped = df.groupby('category')
get_wavg = lambda g: np.average(g['data'], weights=g['weights'])
grouped.apply(get_wavg)

close_px = pd.read_csv('pydata-book/examples/stock_px.csv',
                       parse_dates=True,
                       index_col=0)
close_px[-4:]

rets = close_px.pct_change().dropna()
spx_corr = lambda x: x.corrwith(x['SPX'])
by_year = rets.groupby(lambda x: x.year)
by_year.apply(spx_corr)

by_year.apply(lambda g: g['AAPL'].corr(g['MSFT']))

# 面向分组的线性回归
import statsmodels.api as sm
def regress(data, yvar, xvars):
    Y = data[yvar]
    X = data[xvars]
    X['intercept'] = 1
    result = sm.OLS(Y, X).fit()
    return result.params

by_year.apply(regress, "AAPL", ['SPX'])
