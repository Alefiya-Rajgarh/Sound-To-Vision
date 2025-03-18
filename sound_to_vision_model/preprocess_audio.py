import os
import librosa
import json
import numpy as np
import random
from collections import defaultdict

DATASET_PATH = "dataset"
JSON_PATH = "data.json"
SAMPLES_PER_TRACK = 22050 * 5  # 5 seconds
MAX_MFCC_LENGTH = 216  # Ensure fixed MFCC length for all samples

def extract_features(signal, sr):
    mfcc = librosa.feature.mfcc(y=signal, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
    mfcc = (mfcc - np.mean(mfcc)) / np.std(mfcc)

    # Pad or trim MFCC to fixed length
    if mfcc.shape[1] < MAX_MFCC_LENGTH:
        pad_width = MAX_MFCC_LENGTH - mfcc.shape[1]
        mfcc = np.pad(mfcc, ((0, 0), (0, pad_width)), mode='constant')
    elif mfcc.shape[1] > MAX_MFCC_LENGTH:
        mfcc = mfcc[:, :MAX_MFCC_LENGTH]

    return mfcc.T.tolist()

def augment_signal(signal):
    noise_amp = 0.005 * np.random.uniform() * np.amax(signal)
    signal += noise_amp * np.random.normal(size=signal.shape[0])
    return signal

def save_data():
    data = {"mfcc": [], "labels": [], "mapping": []}
    class_aug_map = {"speech": 2, "animal_sound": 1, "siren": 1}  # extra augment count

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

            # Add noisy version (1 always)
            signal_noisy = augment_signal(signal)
            mfcc_noisy = librosa.feature.mfcc(y=signal_noisy, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
            mfcc_noisy = (mfcc_noisy - np.mean(mfcc_noisy)) / np.std(mfcc_noisy)
            data["mfcc"].append(mfcc_noisy.T.tolist())
            data["labels"].append(i - 1)

            # Extra augment only for minority classes
            extra_aug = class_aug_map.get(label, 0)
            for _ in range(extra_aug):
                signal_extra = augment_signal(signal)
                mfcc_extra = librosa.feature.mfcc(y=signal_extra, sr=sr, n_mfcc=13, n_fft=2048, hop_length=512)
                mfcc_extra = (mfcc_extra - np.mean(mfcc_extra)) / np.std(mfcc_extra)
                data["mfcc"].append(mfcc_extra.T.tolist())
                data["labels"].append(i - 1)

    with open(JSON_PATH, "w") as fp:
        json.dump(data, fp, indent=4)
    print("Data saved to", JSON_PATH)


if __name__ == "__main__":
    save_data()
