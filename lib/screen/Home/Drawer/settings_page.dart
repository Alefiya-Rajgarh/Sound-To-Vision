import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Profile Settings"),
            leading: Icon(Icons.person),
            onTap: () {
              // Navigate to Profile Settings
            },
          ),
          ListTile(
            title: Text("App Theme"),
            leading: Icon(Icons.palette),
            onTap: () {
              // Open theme settings
            },
          ),
          ListTile(
            title: Text("Notifications"),
            leading: Icon(Icons.notifications),
            onTap: () {
              // Open notification settings
            },
          ),
          ListTile(
            title: Text("Language"),
            leading: Icon(Icons.language),
            onTap: () {
              // Open language settings
            },
          ),
        ],
      ),
    );
  }
}
