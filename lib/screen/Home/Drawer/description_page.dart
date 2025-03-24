import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.black45,
          elevation: 10,
          title: Text("Description"),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Sound to Vision is an innovative app designed to assist deaf and hard-of-hearing users by converting real-world sounds into real-time visual alerts and vibrations. Using AI and machine learning (TensorFlow Lite), the app detects sounds like alarms, speech, music, and traffic, translating them into dynamic visual effects for easy recognition.",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
