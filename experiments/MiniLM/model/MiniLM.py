import torch
import torch_mlir

from transformers import AutoTokenizer, AutoModelForSequenceClassification


def prepare_sentence_tokens(hf_model: str, sentence: str):
    tokenizer = AutoTokenizer.from_pretrained(hf_model)
    print(tokenizer)
    return torch.tensor([tokenizer.encode(sentence)])


class OnlyLogitsHuggingFaceModel(torch.nn.Module):
    """Wrapper that returns only the logits from a HuggingFace model."""

    def __init__(self, model_name: str):
        super().__init__()
        self.model = AutoModelForSequenceClassification.from_pretrained(
            model_name,  # The pretrained model name.
            # The number of output labels--2 for binary classification.
            num_labels=2,
            # Whether the model returns attentions weights.
            output_attentions=False,
            # Whether the model returns all hidden-states.
            output_hidden_states=False,
            torchscript=True,
        )
        self.model.eval()

    def forward(self, input):
        # Return only the logits.
        return self.model(input)[0]


# Suppress warnings
import warnings
warnings.simplefilter("ignore")
import os
os.environ["TOKENIZERS_PARALLELISM"] = "true"
# The HuggingFace model name to use
model_name = "philschmid/MiniLM-L6-H384-uncased-sst2"

# The sentence to run the model on
sentence = "The quick brown fox jumps over the lazy dog."

print("Parsing sentence tokens.")
example_input = prepare_sentence_tokens(model_name, sentence)
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
print(result)
