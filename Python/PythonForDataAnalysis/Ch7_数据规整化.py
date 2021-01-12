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
