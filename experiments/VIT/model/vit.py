import torch
import torch_mlir
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from transformers import ViTFeatureExtractor, ViTForImageClassification
from PIL import Image
import requests
import torch.nn as nn
import torch
import torch_mlir
import os

class prepare(nn.Module):
	def __init__(self):
		super().__init__()
		self.model = ViTForImageClassification.from_pretrained('google/vit-base-patch16-224').vit.embeddings
	def forward(self,x):
		x = self.model(x)
		return x


class vit(nn.Module):
	def __init__(self):
		super().__init__()
		self.layer1 = ViTForImageClassification.from_pretrained('google/vit-base-patch16-224').vit.encoder
		self.layer2 = ViTForImageClassification.from_pretrained('google/vit-base-patch16-224').vit.layernorm
		self.layer3 = ViTForImageClassification.from_pretrained('google/vit-base-patch16-224').classifier
	def forward(self,x):
		x = x.reshape(1, 197, 768)
		x = self.layer1(x).last_hidden_state
		x = self.layer2(x)
		x = self.layer3(x)
		return x

url = 'http://images.cocodataset.org/val2017/000000039769.jpg'
image = Image.open(requests.get(url, stream=True).raw)
feature_extractor = ViTFeatureExtractor.from_pretrained('google/vit-base-patch16-224')
inputs = feature_extractor(images=image, return_tensors="pt").pixel_values
model = prepare().eval()
example_input = model(inputs)
print(example_input.shape)

# The original example_input shape is [1, 197, 768], now we reshape it into [1, 197*768]
example_input = example_input.reshape(1, 197*768)
print("example_input shape after reshaping: ", example_input.shape)


vit_model = vit().eval()
output = vit_model(example_input)
print(output.shape)

linalg_on_tensors_mlir = torch_mlir.compile(
    vit_model,
    example_input,
    output_type=torch_mlir.OutputType.LINALG_ON_TENSORS,
    use_tracing=True)
file_path = 'vit.txt'
new_path = '02-linalg.mlir'
with open(file_path, 'wt') as f:
    print(linalg_on_tensors_mlir.operation.get_asm(), file=f)
os.rename(file_path,new_path)


