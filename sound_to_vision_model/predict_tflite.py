import numpy as np
import librosa
import tensorflow as tf

# Load labels
with open("labels.txt", "r") as f:
    labels = [line.strip() for line in f.readlines()]

# Load TFLite model and allocate tensors
interpreter = tf.lite.Interpreter(model_path="model.tflite")
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

def predict_tflite(file_path):
    signal, sr = librosa.load(file_path, sr=22050)
    if len(signal) < 22050 * 5:
        signal = np.pad(signal, (0, 22050 * 5 - len(signal)))
    else:
        signal = signal[:22050 * 5]

    mfcc = librosa.feature.mfcc(y=signal, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
    mfcc = (mfcc - np.mean(mfcc)) / np.std(mfcc)
    mfcc = mfcc.T[np.newaxis, ..., np.newaxis].astype(np.float32)

    interpreter.set_tensor(input_details[0]['index'], mfcc)
    interpreter.invoke()
    output_data = interpreter.get_tensor(output_details[0]['index'])

    predicted_index = np.argmax(output_data)
    predicted_label = labels[predicted_index]

    print(f'Predicted: {predicted_label}')
    print(f'"{predicted_label}" is detected.')

if __name__ == "__main__":
    predict_tflite("dataset/animal_sound/mixkit-dog-barking-twice-1.wav")
