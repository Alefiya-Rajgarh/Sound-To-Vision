import 'package:flutter/material.dart';
import 'package:sound_to_vision/activity/Home.dart';
import 'package:sound_to_vision/activity/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/" : (context)=>Splashscreen(),
      "/home" : (context)=>Home(),
    },
    debugShowCheckedModeBanner: false,
  ));
}