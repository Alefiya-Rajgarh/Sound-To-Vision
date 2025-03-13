import 'package:flutter/material.dart';
import 'activity/Home.dart';
import 'activity/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/" : (context) => splashscreen(),
      "/home" : (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
  ));
}