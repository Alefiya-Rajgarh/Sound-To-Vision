
import 'package:flutter/material.dart';

import '../../../Services/authentications.dart';
import '../../splashscreen.dart';

class drawer extends StatelessWidget {
  final String name;
  final String email;
  final String initial;
  drawer ({required this.name, required this.email, required this.initial});
  @override
  Widget build(BuildContext context) {
    //final Map<String, dynamic>? args =
   // ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?

    // String fullName = args?['name_value'] ?? "Guest";
    // String email = args?['em_value'] ?? "Not Provided";
    // String initial = name.isNotEmpty ? name[0].toUpperCase() : "U";

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(),
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.only(bottom: 10),
              accountName: Text(name, style: TextStyle(fontSize: 20),),
              accountEmail: Text(email, style: TextStyle(fontSize: 20),),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    "A", // User's initial
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Description Page
            ListTile(
              leading: Icon(Icons.info, color: Colors.purple),
              title: Text("Description", style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.pushNamed(context, '/description');
              },
            ),

            // Customize Alerts
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.purple),
              title: Text("Customize Alerts", style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.pushNamed(context, '/customize_alerts');
              },
            ),

            // Settings
            ListTile(
              leading: Icon(Icons.settings, color: Colors.purple),
              title: Text("Settings", style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),

            // History
            ListTile(
              leading: Icon(Icons.history, color: Colors.purple),
              title: Text("History", style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),

            // Help Page
            ListTile(
              leading: Icon(Icons.help, color: Colors.purple),
              title: Text("Help", style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.pushNamed(context, '/help');
              },
            ),

            Divider(),

            // Logout Option
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(fontSize: 20),),
              onTap: () async {

                await AuthServices().signOut();

                Navigator.of(context).pushReplacement(

                  MaterialPageRoute(builder: (context) => splashscreen()),

                );
                },
            ),
          ],
        ),
      ),
    );
  }
}
