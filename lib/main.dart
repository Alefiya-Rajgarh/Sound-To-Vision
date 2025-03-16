import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'activity/Home.dart';
import 'activity/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sound_to_vision_app/login/screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => AuthCheck(),
        "/home": (context) => Home(),
        "/login": (context) => LoginScreen(),
        "/splashsrn": (context) => splashscreen(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return splashscreen();
        }
      },
    );
  }
}
