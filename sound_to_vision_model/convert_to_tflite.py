import tensorflow as tf

# Load the trained Keras model (since you're inside the same folder, just the file name is enough)
model = tf.keras.models.load_model('model.keras')

# Convert the model to TensorFlow Lite format
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the converted model
with open('model.tflite', 'wb') as f:
    f.write(tflite_model)

print("Model successfully converted to TFLite and saved as 'model.tflite'")
