import 'package:flutter/material.dart';
import '../../Services/authentications.dart';
import '../services/auth_services.dart';
import '../widgets/custom_button.dart';
import 'description_page.dart';
import 'customize_alerts_page.dart';
import 'settings_page.dart';
import 'history_page.dart';
import 'help_page.dart';

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

    String name = args?['name_value'] ?? "Guest";
    String email = args?['em_value'] ?? "Not Provided";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.music_note, color: Colors.pinkAccent),
            SizedBox(width: 8),
            Text("Hi $name", style: TextStyle(fontSize: 22, color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: _showMenu,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(text: "Description", onTap: () => _navigateTo(DescriptionPage())),
            CustomButton(text: "Customize Alerts", onTap: () => _navigateTo(CustomizeAlertsPage())),
            CustomButton(text: "Settings", onTap: () => _navigateTo(SettingsPage())),
            CustomButton(text: "History", onTap: () => _navigateTo(HistoryPage())),
            CustomButton(text: "Help?", onTap: () => _navigateTo(HelpPage())),
            SizedBox(height: 30),
            CustomButton(
              text: "Log Out",
              color: Colors.redAccent,
              onTap: _logout,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: Colors.white, size: 30),
                SizedBox(width: 10),
                Text("Powered by any text", style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.black87,
        height: 200,
        child: Column(
          children: [
            ListTile(
              title: Text("Profile", style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.person, color: Colors.white),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout", style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.logout, color: Colors.white),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await AuthServices().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }
}
