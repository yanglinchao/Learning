# -*- coding: utf-8 -*-
"""
Created on Sun Jan 10 16:58:44 2021

@author: ylc
"""

import numpy as np
import pandas as pd
import sys

# 读入一个DataFrame
df = pd.read_csv('pydata-book/examples/ex1.csv')
df
pd.read_table('pydata-book/examples/ex1.csv', sep=',')

# 定义列名
pd.read_csv('pydata-book/examples/ex2.csv', header=None)
pd.read_csv('pydata-book/examples/ex2.csv',
            names=['a', 'b', 'c', 'd', 'message'])
# 索引
names = ['a', 'b', 'c', 'd', 'message']
pd.read_csv('pydata-book/examples/ex2.csv',
            names=names,
            index_col='message')
# 层次化索引
parsed = pd.read_csv('pydata-book/examples/csv_mindex.csv',
                     index_col=['key1', 'key2'])
parsed
# 非固定分隔符的情况
result = pd.read_table('pydata-book/examples/ex3.txt', sep='\s+')
result
# 用skiprows跳过文件的行
pd.read_csv('pydata-book/examples/ex4.csv',
            skiprows=[0, 2, 3])
# 表示缺失值的字符串
result = pd.read_csv('pydata-book/examples/ex5.csv',
                     na_values=['NULL'])
result

# 逐块读取文本文件
result = pd.read_csv('pydata-book/examples/ex6.csv')
result
pd.read_csv('pydata-book/examples/ex6.csv', nrows=5) #只读取前5行
chunker = pd.read_csv('pydata-book/examples/ex6.csv',
                      chunksize=1000)
chunker
tot = pd.Series([], dtype='float64')
for piece in chunker:
    tot = tot.add(piece['key'].value_counts(), fill_value=0)
tot = tot.sort_values(ascending=False)
tot[:10]


# 将数据写出到文本格式
data = pd.read_csv('pydata-book/examples/ex5.csv')
data.to_csv('out.csv')
data.to_csv(sys.stdout, sep='|')
data.to_csv(sys.stdout, na_rep='NULL')
data.to_csv(sys.stdout, index=False, header=False)
data.to_csv(sys.stdout, index=False,
            columns=['a', 'b', 'c'])

# 手工处理分隔符格式
import csv
f = open('pydata-book/examples/ex7.csv')
reader = csv.reader(f)
for line in reader:
    print(line)
lines = list(csv.reader(open('pydata-book/examples/ex7.csv')))
header, values = lines[0], lines[1:]
data_dict = {h: v for h, v in zip(header, zip(*values))}
data_dict
class my_dialect(csv.Dialect):
    lineterminator = '\n'
    delimiter = ';'
    quotechar = '"'
    quoting = 0
reader = csv.reader(f, dialect=my_dialect)
reader = csv.reader(f, delimiter='|')

# JSON数据
obj = {"name":"Wes",
       "places_lived":["United States", "Spain", "Germany"],
       "pet":np.nan,
       "siblings":[{"name":"Scott", "age":25, "pet":"Zuko"},
                   {"name":"Katie", "age":33, "pet":"Cisco"}]
       }
import json
asjson = json.dumps(obj)
result = json.loads(asjson)
result
# 将JSON传入DataFrame
siblings = pd.DataFrame(result['siblings'],
                        columns=['name', 'age'])
siblings

# XML和HTML
from lxml.html import parse
import urllib.request
parsed = parse(urllib.request.urlopen('http://finance.yahoo.com/q/op?s=APPL+Options'))
doc = parsed.getroot()
links = doc.findall('.//a')
links[15:20]
lnk = links[28]
lnk
lnk.get('href')
lnk.text_content()
urls = [lnk.get('href') for lnk in doc.findall('.//a')]
urls[-10:]
tables = doc.findall('.//table')
calls = tables[1]
puts = tables[1]
rows = calls.findall('.//tr')
def _unpack(row, kind='td'):
    elts = row.findall('.//%s' % kind)
    return [val.text_content() for val in elts]
_unpack(rows[0], kind='th')
_unpack(rows[1], kind='td')
from pandas.io.parsers import TextParser
def parse_options_data(table):
    rows = table.findall('.//tr')
    header = _unpack(rows[0], kind='th')
    data = [_unpack(r) for r in rows[1:]]
    return TextParser(data, names=header).get_chunk()
put_data = parse_options_data(puts)
put_data[:10]
# XML
from lxml import objectify
path = 'pydata-book/datasets/mta_perf/Performance_MNR.xml'
parsed = objectify.parse(open(path))
root = parsed.getroot()
data = []
skip_fields = ['PARENT_SEQ', 'INDICATOR_SEQ',
               'DESIRED_CHANGE', 'DECIMAL_PLACES']
for elt in root.INDICATOR:
    el_data = {}
    for child in elt.getchildren():
        if child.tag in skip_fields:
            continue
        el_data[child.tag] = child.pyval
    data.append(el_data)
perf = pd.DataFrame(data)
perf
from StringIO import StringIO
tag = '<a href="http://www.google.com">Google</a>'
root = objectify.parse(StringIO(tag)).getroot()
root

# 二进制数据格式
frame = pd.read_csv('pydata-book/examples/ex1.csv')
frame.to_pickle('frame_pickle') # 储存
pd.read_pickle('frame_pickle') # 读取

# HDF5格式
store = pd.HDFStore('mydata.h5')
store['obj1'] = frame
store['obj1_col'] = frame['a']
store

# Excel文件
import xlrd
import openpyxl
xls_file = pd.ExcelFile('mydata.xlsx')
table = xls_file.parse('Sheet1')
table

# 使用HTML和Web API
import requests
url = 'http://search.twitter.com/search.json?q=python%20pandas'
resp = requests.get(url)
resp
# 加载到Python对象中
import json
data = json.loads(resp.text)
data.keys()
# 用一个列表定义出感兴趣的tweet字段，然后将results列表传给DataFrame
tweet_fields = ['created_at', 'from_user', 'id', 'text']
tweets = pd.DataFrame(data['results'], columns=tweet_fields)
tweets