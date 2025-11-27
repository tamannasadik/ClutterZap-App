import 'package:flutter/material.dart';

class RoomDetailsScreen extends StatelessWidget {
  final String roomName;
  const RoomDetailsScreen({super.key, required this.roomName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(roomName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.bed, size: 90, color: Colors.deepPurple),
            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: 0.4,
              minHeight: 10,
              backgroundColor: Colors.deepPurple.shade100,
              valueColor:
                  AlwaysStoppedAnimation(Colors.deepPurpleAccent),
            ),

            const SizedBox(height: 20),
            _section("Quick Clean", ["Make Bed", "Wipe Table"]),
            _section("Deep Clean", ["Organize Closet", "Clean Floor"]),
            _section("Weekly Checklist", ["Wash Bedsheets"]),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<String> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...tasks.map((e) => CheckboxListTile(value: false, onChanged: (v) {}, title: Text(e))),
      ],
    );
  }
}
