# -*- coding: utf-8 -*-
"""
Created on Thu Jun 23 10:58:38 2022

@author: xinx_
"""

from torch.utils.tensorboard import SummaryWriter

writer = SummaryWriter("logs")

# writer.add_image()

# y = x
for i in range(100):
    writer.add_scalar("y = 2x", 2*i, i)

writer.close()
