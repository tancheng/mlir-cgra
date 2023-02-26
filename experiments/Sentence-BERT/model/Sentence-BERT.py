import torch
import torch_mlir

from transformers import AutoTokenizer, AutoModel


def prepare_sentence_tokens(hf_model: str, sentence: str):
    tokenizer = AutoTokenizer.from_pretrained(hf_model)
    print(tokenizer)
    return torch.tensor([tokenizer.encode(sentence)])


class OnlyLogitsHuggingFaceModel(torch.nn.Module):
    def __init__(self, model_name: str):
        super().__init__()
        self.model = AutoModel.from_pretrained(model_name)
        self.model.eval()

    def forward(self, input):
        # Return only the logits.
        return self.model(input)[0]


import warnings
warnings.simplefilter("ignore")
import os
os.environ["TOKENIZERS_PARALLELISM"] = "true"
# The HuggingFace model name to use
model_name = 'KBLab/sentence-bert-swedish-cased'

# The sentence to run the model on
sentence = ['Det här är en exempelmening', 'Varje exempel blir konverterad']

print("Parsing sentence tokens.")
example_input = prepare_sentence_tokens(model_name, sentence)
print(example_input.shape)
print("Instantiating model.")
model = OnlyLogitsHuggingFaceModel(model_name)
print(model)
linalg_on_tensors_mlir = torch_mlir.compile(
    model,
    example_input,
    output_type=torch_mlir.OutputType.LINALG_ON_TENSORS,
    use_tracing=True)
file_path = 'bert.txt'
new_path = '02-linalg.mlir'
with open(file_path, 'wt') as f:
    print(linalg_on_tensors_mlir.operation.get_asm(), file=f)
os.rename(file_path,new_path)

result = model.forward(example_input)
print(result.shape)
