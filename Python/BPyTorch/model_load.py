import torch
import torchvision

# 加载方式一 -> 保存方式一
# model = torch.load("vgg16_method1.pth")
# print(model)

# 加载方式二 -> 保存方式二
# model = torch.load("vgg16_method2.pth")
# print(model)
# 加载参数到模型
vgg16 = torchvision.models.vgg16(pretrained=False)
vgg16.load_state_dict(torch.load("vgg16_method2.pth"))