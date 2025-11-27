import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final DatabaseReference db = FirebaseDatabase.instance.ref("tasks");

  List<Task> tasks = [];

  // FETCH from Firebase
  Future<void> fetchTasks() async {
    final snapshot = await db.get();

    if (!snapshot.exists) {
      tasks = [];
      notifyListeners();
      return;
    }

    final data = snapshot.value as Map<dynamic, dynamic>;
    tasks = data.entries.map((e) {
      return Task.fromMap(
        e.key,
        Map<dynamic, dynamic>.from(e.value),
      );
    }).toList();

    notifyListeners();
  }

  // ADD to Firebase
  Future<void> addTask(String title) async {
    final newRef = db.push();

    // Save to DB
    await newRef.set({
      "title": title,
      "completed": false,
    });

    // Save locally too
    tasks.add(Task(id: newRef.key!, title: title, completed: false));
    notifyListeners();
  }

  // TOGGLE TASK
  Future<void> toggleTask(Task task) async {
    task.completed = !task.completed;

    await db.child(task.id).update({
      "completed": task.completed,
    });

    notifyListeners();
  }

  // DELETE TASK
  Future<void> deleteTask(String id) async {
    await db.child(id).remove();
    tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
