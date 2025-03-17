import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sound_to_vision_app/screen/Home/Drawer/drawer.dart';
import 'package:sound_to_vision_app/screen/Home/profile.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    String name = (args?['name_value'] as String?)?.split("")[0] ?? "Guest";
    String email = args?['em_value'] ?? "Not Provided";

    //speech to text
    late stt.SpeechToText _speech;
    bool isListening = false;
    String text = "Tap the mic to start recording...";

    @override
    void initState() {
      super.initState();
      _speech = stt.SpeechToText();
    }

    void startListening() async {
      bool available = await _speech.initialize(
        onStatus: (status) => print("Speech Status: $status"),
        onError: (error) => print("Speech Error: $error"),
      );

      if (available) {
        setState(() => isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              text = result.recognizedWords;
            });
          },
        );
      }
    }

    void stopListening() {
      setState(() => isListening = false);
      _speech.stop();
    }

    Future<void> pickAudioFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (result != null) {
        print("Selected file: ${result.files.single.path}");
      }
    }

    String initial = name.isNotEmpty ? name[0].toUpperCase() : "U";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home bgimg.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        // Background color to match UI
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => drawer()),
                          );
                        },
                        icon: Icon(Icons.menu, color: Colors.white, size: 30),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "  Hi! $name ",
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
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => profile()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.purple,
                          child: Text(
                            initial,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Microphone UI
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.mic, size: 80, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Play Button
                IconButton(
                  icon: Icon(
                    Icons.play_circle_fill,
                    size: 50,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {}, // Add functionality here
                ),

                SizedBox(height: 10),

                // File Picker Button
                ElevatedButton.icon(
                  onPressed: pickAudioFile,
                  icon: Icon(Icons.attach_file),
                  label: Text("Select Audio File"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),

                SizedBox(height: 20),

                // Alerts Button
                GestureDetector(
                  onTap: () {}, // Navigate to Alerts page
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink, Colors.purple, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Alerts!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
