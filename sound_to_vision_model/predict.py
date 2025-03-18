import numpy as np
import tensorflow as tf
import librosa
import os

# Load labels
with open("labels.txt", "r") as f:
    labels = [line.strip() for line in f.readlines()]

# Load TFLite model and allocate tensors
interpreter = tf.lite.Interpreter(model_path="model.tflite")
interpreter.allocate_tensors()

# Get input and output tensors info
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

expected_shape = input_details[0]['shape']  # e.g., [1, 216, 13, 1]
EXPECTED_FRAMES = expected_shape[1]  # 216
EXPECTED_MFCC = expected_shape[2]    # 13

def preprocess_audio(file_path):
    y, sr = librosa.load(file_path, sr=22050)
    mfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=EXPECTED_MFCC)
    mfcc = (mfcc - np.mean(mfcc)) / np.std(mfcc)

    # print("🔹 Raw MFCC shape:", mfcc.shape)

    # Pad or truncate to EXPECTED_FRAMES
    if mfcc.shape[1] < EXPECTED_FRAMES:
        pad_width = EXPECTED_FRAMES - mfcc.shape[1]
        mfcc = np.pad(mfcc, ((0, 0), (0, pad_width)), mode='constant')
    else:
        mfcc = mfcc[:, :EXPECTED_FRAMES]

    # print("🔹 MFCC after padding/truncating:", mfcc.shape)

    # Reshape to (1, frames, mfcc, 1)
    input_data = mfcc.T.reshape(1, EXPECTED_FRAMES, EXPECTED_MFCC, 1).astype(np.float32)

    # print("🔹 Reshaped input_data shape:", input_data.shape)
    # print("🔹 Expected input shape from TFLite:", expected_shape)
    return input_data

def predict(file_path):
    input_data = preprocess_audio(file_path)
    interpreter.set_tensor(input_details[0]['index'], input_data)
    interpreter.invoke()

    output_data = interpreter.get_tensor(output_details[0]['index'])  # Shape: (1, num_classes)
    predictions = output_data[0]  # Extract from batch dimension
    predicted_index = np.argmax(predictions)
    confidence = float(predictions[predicted_index])  # Safe scalar extraction
    label = labels[predicted_index]

    print(f"Predicted: {label}")
    print(f"\"{label}\" is detected with confidence: {confidence:.2f}")

# 🔸 Test prediction
predict("dataset/animal_sound/mixkit-angry-cartoon-kitty-meow-94.wav")
