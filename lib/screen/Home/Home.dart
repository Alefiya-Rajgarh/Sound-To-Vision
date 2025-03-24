import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_to_vision_app/screen/Home/Drawer/drawer.dart';
import 'package:sound_to_vision_app/screen/Home/profile.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:file_picker/file_picker.dart';
import 'package:sound_to_vision_app/widget/snack_bar.dart';

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

    bool Alerts = true;

    //speech to text
    late stt.SpeechToText _speech = stt.SpeechToText();
    String _recognizedText = "";
    bool _isListening = false;
    String text = "Tap the mic to start recording...";

    void _initSpeechState() async {
      bool available = await _speech.initialize();
      if (!mounted) return;
      setState(() {
        _isListening = available;
      });
    }

    @override
    void initState() {
      super.initState();
      _initSpeechState;
    }

    void _startListening() {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        },
      );
      setState(() {
        _isListening = true;
      });
    }

    void _copyText() {
      Clipboard.setData(ClipboardData(text: _recognizedText));
      showSnackBar(context, "Text copied");
    }

    void _clearText() {
      setState(() {
        _recognizedText = "";
      });
    }

    // void startListening() async {
    //   bool available = await _speech.initialize(
    //     onStatus: (status) => print("Speech Status: $status"),
    //     onError: (error) => print("Speech Error: $error"),
    //   );

    //   if (available) {
    //     setState(() => isListening = true);
    //     _speech.listen(
    //       onResult: (result) {
    //         setState(() {
    //           text = result.recognizedWords;
    //         });
    //       },
    //     );
    //   }
    // }
    //
    // void stopListening() {
    //   setState(() => isListening = false);
    //   _speech.stop();
    // }

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
          backgroundColor: Color(0xFF1A1A2E),
          elevation: 10,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 40),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => drawer(name: fullName,email: email, initial: initial,)),
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
                      colors: [Color(0xFFF48FB1) ,Colors.purple, Colors.blue],
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
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 60),

            Text(
              "SOUND TO TEXT",
              style: TextStyle(
                color: Color(0xFFF06292),
                fontSize: 40,
                fontWeight: FontWeight.w500,
                //  fontFamily: Roboto-Italic.ttf
              ),
            ),
            SizedBox(height: 20),

            // Microphone UI
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF62B5F6),
                    Color(0xFFCE93D8),
                    Color(0xFFEF9A9A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _recognizedText.isNotEmpty
                    ? _recognizedText
                    : "Tap the mic to start recording !",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF1A1A2E), fontSize: 18),
              ),
            ),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.copy , color: Color(0xFFF8BBD0), size: 45),
                  onPressed: _recognizedText.isNotEmpty ? _copyText : null,

                ),
            SizedBox(width: 30,),

            // Play Button
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF06292),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _startListening,
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  size: 80,
                  color: _isListening ? Color(0xFFEF5350) : Colors.white,
                ),
                color: Color(0xFFF06292),
              ),
            ),
                SizedBox(width: 30),
                IconButton(
                  icon: Icon(Icons.refresh , color: Color(0xFFF8BBD0), size: 56),
                  onPressed: _recognizedText.isNotEmpty ? _copyText : null,

                ),
              ],
            ),

            SizedBox(height: 30),

            // File Picker Button
            ElevatedButton.icon(
              onPressed: pickAudioFile,
              icon: Icon(Icons.attach_file),
              label: Text("Select Audio File", style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              ),
            ),

            SizedBox(height: 30),

            // Alerts Button
            GestureDetector(
              onTap: () {}, // Navigate to Alerts page
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF48FB1),
                      Color(0xFFCE93D8),
                      Color(0xFF62B5F6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: ShaderMask(
                    shaderCallback:
                        (bounds) => LinearGradient(
                      colors: [Colors.purple, Colors.indigo],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),

                    child: SwitchListTile(
                      title: Text(
                      "Alerts!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),),
                        value: Alerts,
                        onChanged: (bool value) {
                          setState(() {
                            Alerts = value;
                          });
                        },
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
