import sys
import os
import time
import numpy as np
import onnx
import onnxruntime
from onnx import numpy_helper

model="./gemmreluadd.onnx"
path=sys.argv[1]

session = onnxruntime.InferenceSession(model, None)
input_name0 = session.get_inputs()[0].name
input_name1 = session.get_inputs()[1].name
input_name2 = session.get_inputs()[2].name
input_name3 = session.get_inputs()[3].name
output_name = session.get_outputs()[0].name
print(input_name0)
print(input_name1)
print(input_name2)
print(output_name)

x0 = np.array([[1 for i in range(32)] for j in range(16)]).astype('float32')
x1 = np.array([[1 for i in range(16)] for j in range(32)]).astype('float32')
x2 = np.array([[1 for i in range(16)] for j in range(16)]).astype('float32')
x3 = np.array([[1 for i in range(16)] for j in range(16)]).astype('float32')

result = session.run([output_name], {input_name0: x0, input_name1: x1, input_name2: x2, input_name3: x3})
print(result)
