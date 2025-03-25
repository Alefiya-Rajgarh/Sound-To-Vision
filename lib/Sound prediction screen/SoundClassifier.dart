import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class SoundClassifier {
  late Interpreter _interpreter;
  List<String> labels = [
    "animal_sound",
    "doorbell",
    "nature",
    "siren",
    "speech",
    "vehicle_horn"
  ];

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model.tflite');
  }

  String classifySound(Uint8List input) {
    var output = List.filled(1 * labels.length, 0.0).reshape([1, labels.length]);
    _interpreter.run(input, output);

    int maxIndex = 0;
    double maxValue = output[0][0];

    for (int i = 1; i < labels.length; i++) {
      if (output[0][i] > maxValue) {
        maxIndex = i;
        maxValue = output[0][i];
      }
    }

    return labels[maxIndex];
  }
}