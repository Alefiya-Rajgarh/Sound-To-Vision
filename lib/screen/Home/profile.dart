import 'package:flutter/material.dart';
import 'package:sound_to_vision_app/Services/authentications.dart';
import'package:sound_to_vision_app/widget/button.dart';

import '../splashscreen.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
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

            Text("Your email: $email", style: TextStyle(fontSize: 18)),

            MyButton(

              onTab: () async {

                await AuthServices().signOut();

                Navigator.of(context).pushReplacement(

                  MaterialPageRoute(builder: (context) => splashscreen()),

                );

              },

              text: "Log Out",

            ),

          ],

        ),

      ),

    );

  }

}