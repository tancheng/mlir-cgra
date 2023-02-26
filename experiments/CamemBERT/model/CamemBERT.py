import torch
import torch_mlir

from transformers import AutoTokenizer, AutoModelForTokenClassification
from transformers import CamembertTokenizer, CamembertForTokenClassification, TokenClassificationPipeline
from transformers import CamembertModel, CamembertTokenizer


def prepare_sentence_tokens(hf_model: str, sentence: str):
    tokenizer = AutoTokenizer.from_pretrained(hf_model)
    tokenizer = torch.tensor([tokenizer.encode(sentence)])
    model = AutoModelForTokenClassification.from_pretrained(hf_model).roberta.embeddings.eval()
    output = model(tokenizer)
    return output


class OnlyLogitsHuggingFaceModel(torch.nn.Module):
    """Wrapper that returns only the logits from a HuggingFace model."""

    def __init__(self, model_name: str):
        super().__init__()
        self.layer1 = AutoModelForTokenClassification.from_pretrained(model_name).roberta.encoder
        self.layer2 = AutoModelForTokenClassification.from_pretrained(model_name).dropout
        self.layer3 = AutoModelForTokenClassification.from_pretrained(model_name).classifier

    def forward(self, input):
        # Return only the logits.
        x = self.layer1(input).last_hidden_state
        x = self.layer2(x)
        x = self.layer3(x)
        return x


# Suppress warnings
import warnings
warnings.simplefilter("ignore")
import os
os.environ["TOKENIZERS_PARALLELISM"] = "true"
# The HuggingFace model name to use
model_name = "Jean-Baptiste/camembert-ner"

# The sentence to run the model on
sentence = "Face à un choc inédit"

print("Parsing sentence tokens.")
example_input = prepare_sentence_tokens(model_name, sentence)
print(example_input.shape)

print("Instantiating model.")
model = OnlyLogitsHuggingFaceModel(model_name)
print(model(example_input).shape)

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
print(result)
