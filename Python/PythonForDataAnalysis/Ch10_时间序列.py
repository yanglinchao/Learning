# -*- coding: utf-8 -*-
"""
Created on Mon Jan 25 13:34:46 2021

@author: xinx_
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# 日期和时间数据类型及工具
from datetime import datetime

now = datetime.now()
now
now.year, now.month, now.day

delta = datetime(2011, 1, 7) - datetime(2008, 6, 24, 8, 15)
delta
delta.days
delta.seconds

from datetime import timedelta
start = datetime(2011, 1, 7)
start + timedelta(12)
start - 2*timedelta(12)

# 字符串和datetime的相互转换
stamp = datetime(2011, 1, 3)
str(stamp)
stamp.strftime('%Y-%m-%d')

value = '2011-01-03'
datetime.strptime(value, '%Y-%m-%d')

datestrs = ['7/6/2011', '9/6/2011']
[datetime.strptime(x, '%m/%d/%Y') for x in datestrs]

from dateutil.parser import parse
parse('2011-01-03')
parse('Jan 31, 1997, 10:45 PM')
parse('6/12/2011', dayfirst=True)

datestrs
pd.to_datetime(datestrs)

idx = pd.to_datetime(datestrs + [None])
idx
idx[2]
pd.isnull(idx)

# 时间序列基础
from datetime import datetime
dates = [datetime(2011, 1, 2), datetime(2011, 1, 5), datetime(2011, 1, 7),
         datetime(2011, 1, 8), datetime(2011, 1, 10), datetime(2011, 1, 12)]
ts = pd.Series(np.random.randn(6), index=dates)
ts
type(ts)
ts.index

ts + ts[::2]

ts.index.dtype
stamp = ts.index[0]
stamp

# 索引、选取、子集构造
stamp = ts.index[2]
ts[stamp]
ts['1/10/2011']
ts['20110110']

longer_ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000', periods=1000))
longer_ts
longer_ts['2001']
longer_ts['2001-05']

ts[datetime(2011, 1, 7):]
ts
ts['1/6/2011':'1/11/2011']
ts.truncate(after='1/9/2011')

dates = pd.date_range('1/1/2000', periods=100, freq='W-WED')
long_df = pd.DataFrame(np.random.randn(100, 4),
                       index=dates,
                       columns=['Colorado', 'Texas', 'New York', 'Ohio'])
long_df.loc['5-2001']

# 带有重复索引的时间序列
dates = pd.DatetimeIndex(['1/1/2000', '1/2/2000', '1/2/2000', '1/2/2000', '1/3/2000'])
dup_ts = pd.Series(np.arange(5), index=dates)
dup_ts
dup_ts.index.is_unique # 检查索引的is_unique属性，可以知道不是唯一的
dup_ts['1/3/2000'] # 不重复
dup_ts['1/2/2000'] # 重复

grouped = dup_ts.groupby(level=0)
grouped.mean()
grouped.count()

# 生成日期范围
index = pd.date_range('4/1/2012', '4/10/2012')
index
pd.date_range(start='4/1/2012', periods=20)
pd.date_range(end='6/1/2012', periods=20)

pd.date_range('1/1/2000', '12/1/2000', freq='BM')
pd.date_range('5/2/2012 12:56:31', periods=5)

pd.date_range('5/2/2012 12:56:31', periods=5, normalize=True)

# 频率和日期偏移量
from pandas.tseries.offsets import Hour, Minute
hour = Hour()
hour
four_hours = Hour(4)
four_hours
pd.date_range('1/1/2000', '1/2/2000 23:59', freq='4h')
Hour(2) + Minute(30)
pd.date_range('1/1/2000', periods=5, freq='1h30min')

# 移动（超前和滞后）数据
ts = pd.Series(np.random.randn(4), index=pd.date_range('1/1/2000', periods=4, freq='M'))
ts
ts.shift(2)
ts.shift(-2)
ts.shift(2, freq='M')
ts.shift(3, freq='D')
ts.shift(1, freq='3D')
ts.shift(1, freq='90T')

# 通过偏移量对日期进行位移
from pandas.tseries.offsets import Day, MonthEnd
now = datetime(2011, 11, 17)
now+3*Day()
now + MonthEnd()
now + MonthEnd(2)

offset = MonthEnd()
offset.rollforward(now)
offset.rollback(now)

ts = pd.Series(np.random.randn(20), index=pd.date_range('1/15/2000', periods=20, freq='4d'))
ts.groupby(offset.rollforward).mean()
ts.resample('M').mean()

# 时区信息
# 获取时区
import pytz
pytz.common_timezones[-5:] # 时区名
tz = pytz.timezone('US/Eastern')
tz
# 本地化和转换
rng = pd.date_range('3/9/2012 9:30', periods=6, freq='D')
ts = pd.Series(np.random.randn(len(rng)), index=rng)
print(ts.index.tz)

pd.date_range('3/9/2012 9:30', periods=5, freq='D', tz='UTC')

ts_utc = ts.tz_localize('UTC')
ts_utc
ts_utc.index

ts_utc.tz_convert('US/Eastern')
ts.index.tz_localize('Asia/Shanghai')

# 操作时区意识型Timestamp对象
stamp = pd.Timestamp('2011-03-12 04:00')
stamp_utc = stamp.tz_localize('utc')
stamp_utc.tz_convert('US/Eastern')

stamp_moscow = pd.Timestamp('2011-03-12 04:00', tz='Europe/Moscow')
stamp_moscow

stamp_utc.value
stamp_utc.tz_convert('US/Eastern').value

from pandas.tseries.offsets import Hour
# 夏令时转变前30分钟
stamp = pd.Timestamp('2012-03-12 01:30', tz='US/Eastern')
stamp
stamp + Hour()
# 夏令时转变前90分钟
stamp = pd.Timestamp('2012-11-04 00:30', tz='US/Eastern')
stamp
stamp + 2*Hour()

# 不同时区之间的运算
rng = pd.date_range('3/7/2012 9:30', periods=5, freq='B')
ts = pd.Series(np.random.randn(len(rng)), index=rng)
ts
ts1 = ts[:7].tz_localize('Europe/London')
ts2 = ts1[2:].tz_convert('Europe/Moscow')
result = ts1 + ts2
result.index

# 时间及其算术运算
p = pd.Period(2007, freq='A-DEC')
p
p + 5
p - 2
pd.Period('2014', freq='A-DEC')-p

rng = pd.period_range('1/1/2000', '6/30/2000', freq='M')
rng

pd.Series(np.random.randn(6), index=rng)
values=['2001Q3', '2002Q2', '2003Q1']
index = pd.PeriodIndex(values, freq='Q-DEC')
index

# 时期的频率转换
p = pd.Period('2007', freq='A-DEC')
p.asfreq('M', how='start')
p.asfreq('M', how='end')
p = pd.Period('2007', freq='A-JUN')
p.asfreq('M', 'start')
p.asfreq('M', 'end')
p = pd.Period('2007-08', 'M')
p.asfreq('A-JUN')

rng = pd.period_range('2006', '2009', freq='A-DEC')
ts = pd.Series(np.random.randn(len(rng)), index=rng)
ts
ts.asfreq('M', how='start')
ts.asfreq('B', how='end')

# 按季度计算的时期频率
p = pd.Period('2012Q4', freq='Q-JAN')
p
p.asfreq('D', 'start')
p.asfreq('D', 'end')

p4pm = (p.asfreq('B', 'e')-1).asfreq('T', 's') + 16*60
p4pm
p4pm.to_timestamp()

rng = pd.period_range('2011Q3', '2012Q4', freq='Q-JAN')
ts = pd.Series(np.arange(len(rng)), index=rng)
ts
new_rng = (rng.asfreq('B', 'e') - 1).asfreq('T', 's') + 16 * 60
ts.index = new_rng.to_timestamp()
ts

rng = pd.date_range('1/1/2000', periods=3, freq='M')
ts = pd.Series(np.random.randn(3), index=rng)
pts = ts.to_period()
ts
pts

rng = pd.date_range('1/29/2000', periods=6, freq='D')
ts2 = pd.Series(np.random.randn(6), index=rng)
ts2.to_period('M')

pts = ts.to_period()
pts.to_timestamp(how='end')

# 通过数组创建PeriodIndex
data = pd.read_csv('pydata-book/examples/macrodata.csv')
data.year
data.quarter
index = pd.PeriodIndex(year=data.year, quarter=data.quarter, freq='Q-DEC')
index
data.index = index
data.infl

# 重采样及频率转换
rng = pd.date_range('1/1/2000', periods=12, freq='T')
ts = pd.Series(np.arange(12), index=rng)
ts
ts.resample('5min').sum()
ts.resample('5min', closed='left').sum()
ts.resample('5min', closed='left', label='left').sum()
ts.resample('5min', loffset='-1s').sum()

# OHLC重采样
ts.resample('5min').ohlc()

# 通过groupby进行重采样
rng = pd.date_range('1/1/2000', periods=100, freq='D')
ts = pd.Series(np.arange(100), index=rng)
ts.groupby(lambda x: x.month).mean()
ts.groupby(lambda x: x.weekday).mean()

# 升采样和插值
frame = pd.DataFrame(np.random.randn(2, 4),
                     index=pd.date_range('1/1/2000', periods=2, freq='W-WED'),
                     columns=['Colorado', 'Texas', 'New York', 'Ohio'])
frame[:5]
df_daily = frame.resample('D').fillna(method='ffill')
frame.resample('D').fillna(method='ffill')
frame.resample('D').fillna(method='ffill', limit=2) # 填充指定期数
frame.resample('W-THU').fillna('ffill')

# 通过时期进行重采样
frame = pd.DataFrame(np.random.randn(24, 4),
                     index=pd.period_range('1-2000', '12-2001', freq='M'),
                     columns=['Colorado', 'Texas', 'New York', 'Ohio'])
frame[:5]
annual_frame = frame.resample('A-DEC').mean()
annual_frame

annual_frame.resample('Q-DEC').fillna('ffill')
annual_frame.resample('Q-DEC', convention='start').fillna('ffill')
annual_frame.resample('Q-MAR').fillna('ffill')

# 时间序列绘图
close_px_all = pd.read_csv('pydata-book/examples/stock_px.csv', parse_dates=True, index_col=0)
close_px = close_px_all[['AAPL', 'MSFT', 'XOM']]
close_px = close_px.resample('B').fillna('ffill')
close_px
close_px['AAPL'].plot()
close_px.loc['2009'].plot()

close_px['AAPL'].loc['01-2011':'03-2011'].plot()
appl_q = close_px['AAPL'].resample('Q-DEC').fillna('ffill')
appl_q.loc['2009':].plot()

# 移动窗口函数
close_px_all = pd.read_csv('pydata-book/examples/stock_px.csv', parse_dates=True, index_col=0)
close_px = close_px_all[['AAPL', 'MSFT', 'XOM']]
appl_mean250 = close_px[['AAPL']].rolling(250).mean()
plt.plot(close_px.AAPL); plt.plot(appl_mean250)

# 指数加权函数
fig, axes = plt.subplots(nrows=2, ncols=1, sharex=True, sharey=True, figsize=(12, 7))
aapl_px = close_px.AAPL['2005':'2009']
ma60 = aapl_px.rolling(60, min_periods=50)
ewma60 = aapl_px.ewm(span=60)

# 二元移动窗口函数
spx_px = close_px_all['SPX']
spx_rets = spx_px/spx_px.shift(1)-1
returns = close_px.pct_change()
corr = returns[['AAPL']].rolling(125, min_periods=100).corr(spx_rets)
plt.plot(corr)

corr = returns.rolling(125, min_periods=100).corr(spx_rets)
plt.plot(corr)

# 用户定义的移动窗口函数
from scipy.stats import percentileofscore
score_at_2percent = lambda x: percentileofscore(x, 0.02)
result = returns[['AAPL']].rolling(250).apply(score_at_2percent)
plt.plot(result)