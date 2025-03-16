import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../widget/button.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/imagebg.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "  Welcome! to ",
                    textStyle: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "fonts/Roboto-Italic.ttf.ttf",
                    ),
                    speed: Duration(milliseconds: 300),
                  ),
                ],
                totalRepeatCount: 3,
              ),

              SizedBox(height: 40),
              Text(
                "Sound To Vision",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "fonts/Roboto-BoldItalic.ttf",
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.blueAccent,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                "By CodeVisionaries",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: "fonts/Roboto-MediumItalic.ttf",
                ),
              ),
              SizedBox(height: 30),
              SpinKitWave(color: Colors.blueAccent, size: 50.0),
              SizedBox(height: 60),
              MyButton(
                onTab: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthCheck(),
                    ),
                  );
                },
                text: "Get Started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus();
    });
  }

  void _checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          String userName = userDoc["name"] ?? "User";
          String userEmail = userDoc["email"] ?? "Not Provided";

          // Navigate to HomeScreen with user data
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              '/home',
              arguments: {
                "name_value": userName,
                "em_value": userEmail,
              },
            );
          }
        } else {
          // If user data does not exist, navigate to LoginScreen
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        }
      } catch (e) {
        print("Error fetching user data: $e");
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    } else {
      // No user logged in → Navigate to LoginScreen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // Show loading until navigation happens
    );
  }
}
