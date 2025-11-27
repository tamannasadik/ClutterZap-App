import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Progress")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Weekly Stats",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: Text("Bar Chart Placeholder")),
            ),

            const SizedBox(height: 20),

            Text("🔥 Streak: 3 Days",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            Text("⭐ Points Earned: 120",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
