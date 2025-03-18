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

    String fullName = args?['name_value'] ?? "Guest";
    String name = fullName.split(" ").first; // Extract first word before space
    String email = args?['em_value'] ?? "Not Provided";
    String initial = name.isNotEmpty ? name[0].toUpperCase() : "U";

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color(0xFFF8C8DC),
          elevation: 10,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 40),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => drawer()),
                  );
                },
              ),
              Icon(
                Icons.music_note,
                color: Color(0xFF7E6BC9),
                size: 30,
              ), // Music Icon
              SizedBox(width: 5),
              ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                child: Text(
                  "Hi! $name",
                  style: TextStyle(
                    fontSize: 30, // Slightly bigger name
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFF9C27B0),
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
        child: Column(
          children: [
            SizedBox(height: 60),

            // Microphone UI
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(100),
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
                  Icon(Icons.mic, size: 90, color: Colors.white),
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
                size: 80,
                color: Color(0xFFF06292),
              ),
              onPressed: () {}, // Add functionality here
            ),

            SizedBox(height: 10),

            // File Picker Button
            ElevatedButton.icon(
              onPressed: pickAudioFile,
              icon: Icon(Icons.attach_file),
              label: Text("Select Audio File" , style: TextStyle(fontSize: 18),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
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
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
