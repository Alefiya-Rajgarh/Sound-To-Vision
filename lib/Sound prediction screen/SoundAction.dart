// import 'package:flutter/material.dart';
// import 'package:vibration/vibration.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// void performAction(String predictedClass, BuildContext context) {
//   switch (predictedClass) {
//     case "animal_sound":
//       Vibration.vibrate(duration: 500);
//       showPopup(context, "🐾 Animal Detected", "assets/animal.png");
//       break;
//
//     case "doorbell":
//       Vibration.vibrate(duration: 500);
//       showPopup(context, "🔔 Doorbell Ringing", "assets/doorbell.png");
//       break;
//
//     case "nature":
//       showFullScreenAnimation(context, "🌿 Nature Sound", "assets/nature.gif");
//       break;
//
//     case "siren":
//       Vibration.vibrate(duration: 1000);
//       showPopup(context, "🚨 Emergency Siren", "assets/siren.png");
//       break;
//
//     case "speech":
//       Vibration.vibrate(duration: 500);
//       showPopup(context, "🗣 Speech Detected", "assets/speech.png");
//       break;
//
//     case "vehicle_horn":
//       Vibration.vibrate(duration: 500);
//       Fluttertoast.showToast(msg: "🚗 There is a vehicle honking nearby!");
//       break;
//
//     default:
//       print("No action assigned.");
//   }
// }
//
// // Popup Dikhane ka Function
// void showPopup(BuildContext context, String message, String imagePath) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text(message),
//       content: Image.asset(imagePath, height: 100),
//       actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
//     ),
//   );
// }
//
// // Full-Screen Animation ke liye Function
// void showFullScreenAnimation(BuildContext context, String message, String gifPath) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(gifPath, height: 300),
//             Text(message, style: TextStyle(color: Colors.white, fontSize: 24)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Close"),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }