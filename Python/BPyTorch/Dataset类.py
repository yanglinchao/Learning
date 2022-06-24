# -*- coding: utf-8 -*-
"""
Created on Thu Jun 23 09:36:22 2022

@author: xinx_
"""
from torch.utils.data import Dataset
from PIL import Image
import os

class MyData(Dataset): # 写一个MyData类，继承Dataset

    def __init__(self, root_dir, label_dir): # 初始化类，根据这一个类创建一个特例实例的时候需要运行的函数
        # 一个方法中的变量不能给另一个方法使用，self相当于指定了一个类当中的全局变量
        self.root_dir = root_dir
        self.label_dir = label_dir
        self.path = os.path.join(self.root_dir, self.label_dir)
        self.img_path = os.listdir(self.path)
    
    
    def __getitem__(self, idx):
        img_name = self.img_path[idx]
        img_item_path = os.path.join(self.root_dir, self.label_dir, img_name)
        img = Image.open(img_item_path)
        label = self.label_dir
        return img, label
    
    def __len__(self):
        return len(self.img_path)



root_dir = "hymenoptera_data/train"
ants_label_dir = "ants"
bees_label_dir = "bees"
ants_dataset = MyData(root_dir, ants_label_dir)
bees_dataset = MyData(root_dir, bees_label_dir)

train_dataset = ants_dataset + bees_dataset