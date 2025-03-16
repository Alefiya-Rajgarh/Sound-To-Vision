import tensorflow as tf
import json
import numpy as np

MODEL_PATH = "model.keras"
DATA_PATH = "data.json"

# Load test data
def load_data(data_path):
    with open(data_path, "r") as fp:
        data = json.load(fp)

    X = np.array(data["mfcc"])
    y = np.array(data["labels"])
    return X, y

X, y = load_data(DATA_PATH)
X = X[..., np.newaxis]

# Load model
model = tf.keras.models.load_model(MODEL_PATH)

# Evaluate
loss, acc = model.evaluate(X, y)
print(f"Test Accuracy on all data: {acc:.4f}")