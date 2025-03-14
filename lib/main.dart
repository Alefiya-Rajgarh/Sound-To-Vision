import 'package:flutter/material.dart';
import 'activity/Home.dart';
import 'activity/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/" : (context) => splashscreen(),
      "/home" : (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
  ));
}