import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sound_to_vision_app/login/screen/sign_up.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    String name = args?['name_value'] ?? "Guest";
    String email = args?['em_value'] ?? "Not Provided";

    return Scaffold(
      appBar: AppBar(title: Text("Welcome, $name!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, $name!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Your email: $email",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}