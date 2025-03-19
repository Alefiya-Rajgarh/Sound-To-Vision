# import tensorflow as tf
# print(tf.__version__)

# import tensorflow as tf
# model = tf.keras.models.load_model("model.keras")
# model.summary()

from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import librosa

app = Flask(__name__)

#load AI model
model = tf.keras.models.load_model("model.keras")

alert_labels = ["animal_sound", "doorbell","nature", "siren", "speech", "vehicle_horn"]  

def extract_features(file_path):
    audio, sr = librosa.load(file_path, sr=22050)
    mfcc = librosa.feature.mfcc(y=audio, sr=sr, n_mfcc=13)

    #ensuring a fixed shape of (216, 13)
    if mfcc.shape[1] < 216:
        pad_width = 216 - mfcc.shape[1]
        mfcc = np.pad(mfcc, ((0, 0), (0, pad_width)), mode='constant')
    else:
        mfcc = mfcc[:, :216]

    features = mfcc.T

    #print extracted features
    print("Extracted Features Shape:", features.shape)
    print("Extracted Features:", features)

    return features

@app.route("/predict", methods=["POST"])

def predict():
    file = request.files["file"]  #get input file
    file_path = "temp.wav"  
    file.save(file_path)  

    #convert sound to numerical format
    input_data = extract_features(file_path)
    input_data = np.expand_dims(input_data, axis=-1)
    input_data = np.resize(input_data, (1, 216, 13, 1))

    #predict using ai model
    prediction = model.predict(input_data)
    predicted_class_index = np.argmax(prediction)
    confidence = float(np.max(prediction))

    #checking probability of each class
    print("\n🔍 **Prediction Probabilities:**")
    for i, label in enumerate(alert_labels):
        print(f"{label}: {prediction[0][i]*100:.2f}%")

    alert_name = alert_labels[predicted_class_index]

    return jsonify({
        "alert_name": alert_name,
        "accuracy": round(confidence * 100, 2)
    })


if __name__ == "__main__":

    app.run(debug=True)


