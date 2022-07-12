# -*- coding: utf-8 -*-
"""
Created on Fri Jun 24 08:14:50 2022

@author: xinx_
"""

from PIL import Image
from torch.utils.tensorboard import SummaryWriter
from torchvision import transforms

# tensor数据类型
# 通过tansforms.ToTensor去看两个问题
# 1、transforms该如何使用（python）
# 2、为什么我们需要tensor数据类型

writer = SummaryWriter("logs")
img = Image.open("hymenoptera_data/train/ants/0013035.jpg")
print(img)

# ToTensor的使用
trans_totensor = transforms.ToTensor()
img_tensor = trans_totensor(img)
writer.add_image("ToTensor", img_tensor)

# Normalize
print(img_tensor[0][0][0])
trans_norm = transforms.Normalize([8, 5, 9], [9, 5, 1])
img_norm = trans_norm(img_tensor)
print(img_norm[0][0][0])
writer.add_image("Normalize", img_norm, 2)

# Resize
print(img.size)
trans_resize = transforms.Resize((512, 512))
# img PIL -> resize -> img_resize PIL
img_resize = trans_resize(img)
# img_resize PIL -> totensor -> img_resize tensor
img_resize = trans_totensor(img_resize)
writer.add_image("Resize", img_resize, 0)

# Compose - resize -2
trans_resize_2 = transforms.Resize(512)
# PIL -> PIL -> tensor
trans_compose = transforms.Compose([trans_resize_2, trans_totensor])
img_resize_2 = trans_compose(img)
writer.add_image("Resize", img_resize_2, 1)

# RandomCrop随机裁剪
trans_random = transforms.RandomCrop((250, 300))
trans_compose_2 = transforms.Compose([trans_random, trans_totensor])
for i in range(10):
    img_crop = trans_compose_2(img)
    writer.add_image("RandomCropHW", img_crop, i)


writer.close()