import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/weatherbg.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/weather_logo.png',
                  height: 240,
                  width: 240,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sound To Vision",
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "fonts/Roboto-BoldItalic.ttf"),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "By Alefiya",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "fonts/Roboto-MediumItalic.ttf"),
                ),
                SizedBox(
                  height: 30,
                ),
                SpinKitWave(
                  color: Colors.blueAccent,
                  size: 50.0,
                )
              ],
            ),
          ),
        )
    );
  }
}
