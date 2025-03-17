import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<String> soundHistory = [
    "Car Horn - 2 min ago",
    "Doorbell - 5 min ago",
    "Loud Music - 10 min ago",
    "Siren - 20 min ago"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: ListView.builder(
        itemCount: soundHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.history),
            title: Text(soundHistory[index]),
          );
        },
      ),
    );
  }
}
