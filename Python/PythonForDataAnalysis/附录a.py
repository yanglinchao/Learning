# -*- coding: utf-8 -*-
"""
Created on Sun Jan 31 22:35:11 2021

@author: xinx_
"""

import numpy as np
import pandas as pd

# 数值类型
ival = 17239871
ival ** 6

fval = 7.243
fval2 = 6.78e-5

3/2

# 字符串
a = 'one way of writing a string'
b = "another way"

c = """
This is a longer string that
spans multiple lines
"""

a = 'this is a string'
a[10] = 'f'

a = 5.6
s = str(a)
s

s = 'python'
list(s)
s[:3]

s = '12\\34'
print(s)

s = r'this\has\no\special\characters'
s

a = 'this is the first half'
b = 'and this is the second half'
a + b

template = '%.2f %s are worth $%d'
template
template % (4.5560, 'Argentine Pesos', 1)

# 布尔值
True and True
False or True

a = [1, 2, 3]
if a:
    print('I found something!')
b = []
if not b:
    print('Empty!')

bool([]), bool([1, 2, 3])
bool('Hello world!'), bool('')
bool(0), bool(1)

s = '3.14159'
fval = float(s)
type(fval)
int(fval)
bool(fval)
bool(0)

# None
a = None
a is None
b = 5
b is not None

def add_and_maybe_multiply(a, b, c=None):
    result = a + b
    if c is not None:
        result = result * c
    return result

# 日期和时间
from datetime import datetime, date, time
dt = datetime(2011, 10, 29, 20, 30, 21)
dt.day
dt.minute
dt.date()
dt.time()
dt.strftime('%m/%d/%Y %H:%M')
datetime.strptime('20091031', '%Y%m%d')
dt2 = datetime(2011, 11, 15, 22, 30)
delta = dt2 - dt
delta
type(delta)
dt
dt + delta

# 控制流
a = 5; b = 7
c = 8; d = 4
if a<b or c>d:
    print('Made it')

sequence = [1, 2, None, 4, None, 5]
total = 0
for value in sequence:
    if value is None:
        continue
    total += value

sequence = [1, 2, 0, 4, 6, 5, 2, 1]
total_until_5 = 0
for value in sequence:
    if value == 5:
        break
    total_until_5 += value
    
x = 256
total = 0
while x > 0:
    if total > 500:
        break
    total += x
    x = x//2

x = 0
if x < 0:
    print('negative!')
elif x == 0:
    pass
else:
    print('positive!')

def attempt_float(x):
    try:
        return float(x)
    except:
        return x
attempt_float('1.2345')
attempt_float('something')

float((1, 2))
def attempt_float(x):
    try:
        return float(x)
    except (TypeError, ValueError):
        return x

f = open(path, 'w')
try:
    write_to_file(f)
except:
    print('Failed')
else:
    print('Succeeded')
finally:
    f.close()
    
a = range(10)
np.array(a)
b = range(0, 20, 2)
np.array(b)

seq = [1, 2, 3, 4]
for i in range(len(seq)):
    val = seq[i]
val

x = 5
'Non-negative' if x >= 0 else 'Negative'

tup = 4, 5, 6
tup
nested_tup = (4, 5, 6), (7, 8)
nested_tup
tuple([4, 0, 2])
tup = tuple('string')
tup
tup[0]
tup = tuple(['foo', [1, 2], True])
tup[2] = False
tup[1].append(3)
tup
(4, None, 'foo') + (6, 0) + ('bar',)
('foo', 'bar')*4
(1, 2) * 4

tup = (4, 5, 6)
a, b, c = tup
b
tup = 4, 5, (6, 7)
a, b, (c, d) = tup
d
seq = [(1, 2, 3), (4, 5, 6), (7, 8, 9)]
for a, b, c in seq:
    pass
a = (1, 2, 2, 2, 3, 4, 2)
a.count(2)

a_list = [2, 3, 7, None]
tup = ('foo', 'bar', 'baz')
b_list = list(tup)
b_list
b_list[1] = 'peekaboo'
b_list

b_list.append('dwarf')
b_list

b_list.insert(1, 'red')
b_list

b_list.pop(2)
b_list

b_list.append('foo')
b_list.remove('foo')
b_list

'dwarf' in b_list
[4, None, 'foo'] + [7, 8, (2, 3)]

x = [4, None, 'foo']
x.extend([7, 8, (2, 3)])
x

# 排序
a = [7, 2, 5, 1, 3]
a.sort()
a
b = ['saw', 'small', 'He', 'foxes', 'six']
b.sort(key=len)
b

import bisect
c = [1, 2, 2, 3, 4, 7]
bisect.bisect(c, 2)
bisect.bisect(c, 5)
bisect.insort(c, 6)
c

# 切片
seq = [7, 2, 3, 7, 5, 6, 0, 1]
seq[1:5]
seq[3:4] = [6, 3]
seq
seq[:5]
seq[3:]
seq[-4:]
seq[-6:-2]
seq[::2]
seq[::-1]

# enumerate
some_list = ['foo', 'bar', 'baz']
mapping = dict((v, i) for i, v in enumerate(some_list))
mapping

# sorted
sorted([7, 1, 2, 6, 0, 3, 2])
sorted('horse race')
sorted(set('this is just some string'))

# zip
seq1 = ['foo', 'bar', 'baz']
seq2 = ['one', 'two', 'three']
print(list(zip(seq1, seq2)))
seq3 = [False, True]
print(list(zip(seq1, seq2, seq3)))
for i, (a, b) in enumerate(zip(seq1, seq2)):
    print('%d: %s, %s' % (i, a, b))
pitchers = [('Nolan', 'Ryan'), ('Roger', 'Clemens'), ('Schilling', 'Curt')]
first_names, last_names = zip(*pitchers)
first_names
last_names
list(reversed(range(10)))


# 字典
empty_dict = {}
d1 = {'a':'some value', 'b':[1, 2, 3, 4]}
d1
d1[7] = 'an integer'
d1
d1['b']
'b' in d1

d1[5] = 'some value'
d1['dummy'] = 'another value'
del d1[5]
d1
ret = d1.pop('dummy')
ret
d1

d1.keys()
d1.values()
d1.update({'b':'foo', 'c':12})
d1
mapping = dict(zip(range(5), reversed(range(5))))
mapping

words = ['apple', 'bat', 'bar', 'atom', 'book']
by_letter = {}
for word in words:
    letter = word[0]
    if letter not in by_letter:
        by_letter[letter] = [word]
    else:
        by_letter[letter].append(word)
by_letter

by_letter.setdefault(letter, []).append(word)

hash('string')
hash((1, 2, (2, 3)))
hash((1, 2, [2, 3])) # 这里会失败，因为列表是可变的

d = {}
d[tuple([1, 2, 3])] = 5
d

# 集合
set([2, 2, 2, 1, 3, 3])
{2, 2, 2, 1, 3, 3}

a = {1, 2, 3, 4, 5}
b = {3, 4, 5, 6, 7, 8}
a|b # 并（或）
a&b # 交（与）
a-b # 差
a^b # 对称差（异或）
a_set = {1, 2, 3, 4, 5}
{1, 2, 3}.issubset(a_set)
a_set.issuperset({1, 2, 3})
{1, 2, 3} == {1, 2, 3} # 如果两个集合的内容相等，则它们就是相等的

strings = ['a', 'as', 'bat', 'car', 'dove', 'python']
[x.upper() for x in strings if len(x)>2]

unique_lengths = {len(x) for x in strings}
unique_lengths

loc_mapping = {val:index for index, val in enumerate(strings)}
loc_mapping
loc_mapping = dict((val, idx) for idx, val in enumerate(strings))

# 嵌套列表推导式
all_data = [['Tom', 'Billy', 'Jefferson', 'Andrew', 'Wesley', 'Steven', 'Joe'],
            ['Susie', 'Casey', 'Jill', 'Ana', 'Eva', 'Jennifer', 'Stephanie']]
names_of_interest = []
for names in all_data:
    enough_es = [name for name in names if name.count('e') > 2]
    names_of_interest.extend(enough_es)
result = [name for names in all_data for name in names if name.count('e') >= 2]
result
some_tuples = [(1, 2, 3), (4, 5, 6), (7, 8, 9)]
flattened = [x for tup in some_tuples for x in tup]
flattened

flattened = []
for tup in some_tuples:
    for x in tup:
        flattened.append(x)
        
# 函数
a = None
def bind_a_variable():
    global a
    a = []
bind_a_variable()
print(a)

def outer_function(x, y, z):
    def inner_function(a, b, c):
        pass
    pass

def f():
    a = 5
    b = 6
    c = 7
    return {'a':a, 'b':b, 'c':c}
ints = [4, 0, 1, 5, 6]

strings = ['foo', 'card', 'bar', 'aaaa', 'abab']
strings.sort(key=lambda x: len(set(list(x))))
strings
len(set(list(strings)))

def make_watcher():
    have_seen = {}
    def has_been_seen(x):
        if x in have_seen:
            return True
        else:
            have_seen[x] = True
            return False
    return has_been_seen
watcher = make_watcher()
vals = [5, 6, 1, 5, 1, 6, 3, 5]
[watcher(x) for x in vals]

def say_hello_then_call_f(f, *args, **kwargs):
    print('args is', args)
    print('kwargs is', kwargs)
    print("Hello! Now I'm going to call %s" %f)
    return f(*args, **kwargs)
def g(x, y, z=1):
    return (x+y)/z
say_hello_then_call_f(g, 1, 2, z=5.)


# 生成器
some_dict = {'a':1, 'b':2, 'c':3}
for key in some_dict:
    print(key)

some_dict = {'a':1, 'b':2, 'c':3}
dict_iterator = iter(some_dict)
dict_iterator
list(dict_iterator)

def squares(n=10):
    print('Generating squares from 1 to %d' % (n ** 2))
    for i in range(1, n+1):
        yield i**2
gen = squares()
gen
for x in gen:
    print(x)

# 生成器表达式
gen = (x**2 for x in range(100))
gen
def _make_gen():
    for x in range(100):
        yield x**2
gen = _make_gen()
sum(x ** 2 for x in range(100))
dict((i, i**2) for i in range(5))
