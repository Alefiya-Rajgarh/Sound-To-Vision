import os
import matplotlib.pyplot as plt

DATASET_PATH = "dataset"
categories = os.listdir(DATASET_PATH)
category_counts = {}

for category in categories:
    path = os.path.join(DATASET_PATH, category)
    if os.path.isdir(path):
        count = len(os.listdir(path))
        category_counts[category] = count

# Print counts
for category, count in category_counts.items():
    print(f"{category}: {count} samples")

# Plotting
plt.figure(figsize=(10, 6))
plt.bar(category_counts.keys(), category_counts.values(), color='skyblue')
plt.title("Dataset Class Distribution")
plt.xlabel("Category")
plt.ylabel("Number of Samples")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
