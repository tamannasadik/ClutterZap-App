import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class QuickCleanScreen extends StatefulWidget {
  const QuickCleanScreen({super.key});

  @override
  State<QuickCleanScreen> createState() => _QuickCleanScreenState();
}

class _QuickCleanScreenState extends State<QuickCleanScreen> {
  final DatabaseReference _tasksRef =
      FirebaseDatabase.instance.ref().child("tasks");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quick Clean")),
      body: StreamBuilder(
        stream: _tasksRef.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("No tasks found"));
          }

          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final tasks = data.entries.toList();

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final taskId = tasks[index].key;
              final taskData = tasks[index].value;

              return ListTile(
                title: Text(taskData["title"]),
                trailing: Checkbox(
                  value: taskData["completed"],
                  onChanged: (value) {
                    _tasksRef.child(taskId).update({"completed": value});
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tasksRef.push().set({
            "title": "New Task",
            "completed": false,
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
