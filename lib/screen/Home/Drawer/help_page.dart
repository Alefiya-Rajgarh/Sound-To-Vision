import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help & Support")),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FAQs", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text("How does the Sound-to-Vision app work?"),
              subtitle: Text("It detects sounds and converts them into visuals for the deaf."),
            ),
            ListTile(
              title: Text("Can I customize the sound alerts?"),
              subtitle: Text("Yes! You can enable/disable vibration and sound alerts."),
            ),
            SizedBox(height: 20),
            Text("Contact Us", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("support@soundtovision.com"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("+91 9039655152"),
            ),
          ],
        ),
      ),
    );
  }
}
