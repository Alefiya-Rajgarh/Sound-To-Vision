import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sound_to_vision_app/screen/Home/Drawer/drawer.dart';
import 'screen/Home/Home.dart';
import 'screen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sound_to_vision_app/activity/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => splashscreen(),
        "/home": (context) => HomeScreen(),
        "/login": (context) => LoginScreen(),
        "/splashsrn": (context)=> splashscreen(),
        "/drawer": (context)=> drawer(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

