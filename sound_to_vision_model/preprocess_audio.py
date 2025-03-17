import os
import librosa
import json
import numpy as np
import random

DATASET_PATH = "dataset"
JSON_PATH = "data.json"
SAMPLES_PER_TRACK = 22050 * 5  # 5 seconds

def extract_features(file_path):
    signal, sr = librosa.load(file_path, sr=22050)
    if len(signal) >= SAMPLES_PER_TRACK:
        signal = signal[:SAMPLES_PER_TRACK]
    else:
        signal = np.pad(signal, (0, SAMPLES_PER_TRACK - len(signal)))

    mfcc = librosa.feature.mfcc(y=signal, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
    mfcc = (mfcc - np.mean(mfcc)) / np.std(mfcc)  # Normalize
    return mfcc.T.tolist()

def augment_signal(signal):
    noise_amp = 0.005 * np.random.uniform() * np.amax(signal)
    signal += noise_amp * np.random.normal(size=signal.shape[0])
    return signal

def save_data():
    data = {"mfcc": [], "labels": [], "mapping": []}
    for i, (dirpath, dirnames, filenames) in enumerate(os.walk(DATASET_PATH)):
        if dirpath == DATASET_PATH:
            continue
        label = dirpath.split(os.sep)[-1]
        data["mapping"].append(label)
        print(f"Processing: {label}")

        for f in filenames:
            file_path = os.path.join(dirpath, f)
            signal, sr = librosa.load(file_path, sr=22050)
            if len(signal) < SAMPLES_PER_TRACK:
                signal = np.pad(signal, (0, SAMPLES_PER_TRACK - len(signal)))
            else:
                signal = signal[:SAMPLES_PER_TRACK]

            mfcc = librosa.feature.mfcc(y=signal, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
            mfcc = (mfcc - np.mean(mfcc)) / np.std(mfcc)
            data["mfcc"].append(mfcc.T.tolist())
            data["labels"].append(i - 1)

            # Augmentation: Add noisy version
            signal_noisy = augment_signal(signal)
            mfcc_noisy = librosa.feature.mfcc(y = signal_noisy, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
            mfcc_noisy = (mfcc_noisy - np.mean(mfcc_noisy)) / np.std(mfcc_noisy)
            data["mfcc"].append(mfcc_noisy.T.tolist())
            data["labels"].append(i - 1)

    with open(JSON_PATH, "w") as fp:
        json.dump(data, fp, indent=4)
    print("Data saved to", JSON_PATH)

if __name__ == "__main__":
    save_data()
