import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
                  animatedTexts:[
                    TypewriterAnimatedText(
                      "Welcome! to ",
                      textStyle: TextStyle(
                          fontSize:45,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: "fonts/Roboto-Italic.ttf.ttf"),
                      speed: Duration(milliseconds: 300),
                    ),
                  ],
                  totalRepeatCount: 3,
                ),

                SizedBox(
                  height: 30,
                ),
                Text(
                    "Sound To Vision",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "fonts/Roboto-BoldItalic.ttf",
                        shadows:[
                          Shadow(
                            blurRadius: 20.0,
                            color:Colors.blueAccent,
                            offset: Offset(0,0),
                          )
                        ]
                    )
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "By CodeVisionaries",
                  style: TextStyle(
                      fontSize: 20,
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
