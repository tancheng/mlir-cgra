import onnx
from onnx import helper
from onnx import AttributeProto, TensorProto, GraphProto

import numpy as np

# Create one input (ValueInfoProto)
X0 = helper.make_tensor_value_info('X0', TensorProto.FLOAT, [16, 32])
X1 = helper.make_tensor_value_info('X1', TensorProto.FLOAT, [32, 16])
X2 = helper.make_tensor_value_info('X2', TensorProto.FLOAT, [16, 16])
X3 = helper.make_tensor_value_info('X3', TensorProto.FLOAT, [16, 16])

# Create intermediate tensors (ValueInfoProto)
Y0 = helper.make_tensor_value_info('Y0', TensorProto.FLOAT, [16, 16])
Y1 = helper.make_tensor_value_info('Y1', TensorProto.FLOAT, [16, 16])

# Create one output (ValueInfoProto)
Z0 = helper.make_tensor_value_info('Z0', TensorProto.FLOAT, [16, 16])

# Create a node (NodeProto) - This is based on Pad-11
node_def0 = helper.make_node(
  'Gemm', # node name
  ['X0', 'X1', 'X2'], # inputs
  ['Y0'], # outputs
)

node_def1 = helper.make_node(
  'Relu', # node name
  ['Y0'], # inputs
  ['Y1'], # outputs
)

node_def2 = helper.make_node(
  'Add', # node name
  ['Y1', 'X3'], # inputs
  ['Z0'], # outputs
)

# Create the graph (GraphProto)
graph_def = helper.make_graph(
  [node_def0, node_def1, node_def2],
  'test-model',
  [X0, X1, X2, X3],
  [Z0],
)

# Create the model (ModelProto)
model_def = helper.make_model(graph_def, producer_name='onnx-example')

print('The model is:\n{}'.format(model_def))
onnx.checker.check_model(model_def)
onnx.save(model_def, "gemmreluadd.onnx")
print('The model is checked!')
