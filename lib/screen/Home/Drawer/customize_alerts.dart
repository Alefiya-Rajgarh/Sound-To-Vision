import 'package:flutter/material.dart';

class CustomizeAlertsPage extends StatefulWidget {
  @override
  _CustomizeAlertsPageState createState() => _CustomizeAlertsPageState();
}

class _CustomizeAlertsPageState extends State<CustomizeAlertsPage> {
  bool vibrationEnabled = true;
  bool soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customize Alerts")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Enable Vibration"),
              value: vibrationEnabled,
              onChanged: (bool value) {
                setState(() {
                  vibrationEnabled = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("Enable Sound Alerts"),
              value: soundEnabled,
              onChanged: (bool value) {
                setState(() {
                  soundEnabled = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save preferences (if needed)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Preferences Saved")),
                );
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
