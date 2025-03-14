import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.centre ,
            children: [
              SizedBox(
                width:double.infinity,
                height: height / 2.7,
                child: Image.asset("images/login.jpg"),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
