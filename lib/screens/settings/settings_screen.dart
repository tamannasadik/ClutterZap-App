import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Theme"),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("App Info"),
          ),
        ],
      ),
    );
  }
}
