import 'package:flutter/material.dart';
import '../daily_tasks/daily_task_screen.dart';
import '../smart_scan/smart_scan_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                "Hello Tamanna!",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // Progress Circle
              Center(
                child: SizedBox(
                  height: 130,
                  width: 130,
                  child: CircularProgressIndicator(
                    value: 0.6,
                    strokeWidth: 10,
                    backgroundColor: Colors.deepPurple.shade100,
                    valueColor:
                        const AlwaysStoppedAnimation(Colors.deepPurpleAccent),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Quick Actions
              const Text(
                "Quick Actions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Smart Scan Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SmartScanView(),
                        ),
                      );
                    },
                    child: _quickButton("Smart Scan", Icons.qr_code_scanner),
                  ),

                  // Daily Tasks Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DailyTaskScreen(),
                        ),
                      );
                    },
                    child:
                        _quickButton("Daily Tasks", Icons.check_circle_outline),
                  ),

                  // Motivation Button
                  _quickButton("Motivation", Icons.favorite),
                ],
              ),

              const SizedBox(height: 25),

              // Your Rooms Section
              const Text(
                "Your Rooms",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: const [
                    _RoomCard(title: "Bedroom", icon: Icons.bed),
                    _RoomCard(title: "Kitchen", icon: Icons.kitchen),
                    _RoomCard(title: "Study", icon: Icons.menu_book),
                    _RoomCard(title: "Closet", icon: Icons.storefront),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Go to Daily Tasks Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DailyTaskScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Go to Daily Tasks",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // Quick Action Button Widget
  Widget _quickButton(String text, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.deepPurple.shade100,
          child: Icon(icon, size: 28, color: Colors.deepPurple),
        ),
        const SizedBox(height: 6),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Room Card as StatelessWidget for cleaner code
class _RoomCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _RoomCard({required this.title, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
