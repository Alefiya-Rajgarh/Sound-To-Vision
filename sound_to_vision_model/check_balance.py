import os

DATASET_PATH = "dataset"
labels_count = {}

for folder in os.listdir(DATASET_PATH):
    folder_path = os.path.join(DATASET_PATH, folder)
    if os.path.isdir(folder_path):
        count = len([f for f in os.listdir(folder_path) if f.endswith('.wav')])
        labels_count[folder] = count

print("Class Distribution:")
for label, count in labels_count.items():
    print(f"{label}: {count} audio files")