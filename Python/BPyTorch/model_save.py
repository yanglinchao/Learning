import torch
import torchvision

vgg16 = torchvision.models.vgg16(pretrained=False)

# 保存方式一
torch.save(vgg16, "vgg16_method1.pth") # 保存网络模型的结构和参数

# 保存方式二
torch.save(vgg16.state_dict(), "vgg16_method2.pth") # 保存网络模型的参数（官方推荐）