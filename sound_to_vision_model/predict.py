import librosa
import numpy as np
import tensorflow as tf
import json

model = tf.keras.models.load_model("model.keras")

with open("labels.txt", "r") as f:
    labels = [line.strip() for line in f.readlines()]

def predict(file_path):
    signal, sr = librosa.load(file_path, sr=22050)
    if len(signal) < 22050*5:
        signal = np.pad(signal, (0, 22050*5 - len(signal)))
    else:
        signal = signal[:22050*5]

    mfcc = librosa.feature.mfcc(y=signal, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
    mfcc = (mfcc - np.mean(mfcc)) / np.std(mfcc)
    mfcc = mfcc.T[np.newaxis, ..., np.newaxis]

    prediction = model.predict(mfcc)
    predicted_index = np.argmax(prediction)
    predicted_label = labels[predicted_index]

    print(f"Predicted: {predicted_label}")
    print(f"Prediction vector: {prediction[0]}")
    print(f"Predicted index: {predicted_index}")
    print(f"Predicted label: {predicted_label}")

if __name__ == "__main__":
    predict("dataset/doorbell/mixkit-doorbell-double-quick-press-335.wav")  # Update with your file
