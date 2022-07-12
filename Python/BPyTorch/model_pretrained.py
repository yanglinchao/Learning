import torchvision.datasets
from torch import nn

vgg16_true = torchvision.models.vgg16(pretrained=True)



train_data = torchvision.datasets.CIFAR10("D:/Data/CIFAR10", train=True, download=True, transform=torchvision.transforms.ToTensor())
vgg16_true.classifier.add_module('add_linear', nn.Linear(1000, 10))
print(vgg16_true)