import subprocess

if __name__ == "__main__":
    print("1. Preprocessing Audio")
    subprocess.run(["python", "preprocess_audio.py"])

    print("2. Training Model")
    subprocess.run(["python", "train_model.py"])

    print("3. Predicting from Test Audio")
    subprocess.run(["python", "predict.py"])