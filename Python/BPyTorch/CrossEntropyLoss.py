import torch
from torch import nn

x = torch.tensor([0.1, 0.2, 0.3])
y = torch.tensor([1])

x = torch.reshape(x, (1, 3)) # 1个对象，有3类
loss_corss = nn.CrossEntropyLoss()
result_cross = loss_corss(x, y)
print(result_cross)