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