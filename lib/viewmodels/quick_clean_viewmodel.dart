// lib/viewmodels/quick_clean_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/task.dart';

class QuickCleanViewModel extends ChangeNotifier {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('quick_clean_tasks');
  List<Task> taskList = [];

  QuickCleanViewModel() {
    _attachListener();
  }

  void _attachListener() {
    _ref.onValue.listen((event) {
      final raw = event.snapshot.value;
      if (raw == null) {
        taskList = [];
        notifyListeners();
        return;
      }
      if (raw is Map) {
        try {
          taskList = raw.entries.map((e) {
            final map = Map<String, dynamic>.from(e.value as Map);
            return Task.fromMap(e.key.toString(), map);
          }).toList();
        } catch (e) {
          debugPrint('QuickCleanViewModel parse error: $e');
          taskList = [];
        }
      } else {
        taskList = [];
      }
      notifyListeners();
    }, onError: (err) {
      debugPrint('QuickCleanViewModel listener error: $err');
    });
  }

  Future<void> addTask(String title) async {
    await _ref.push().set({'title': title, 'completed': false});
  }

  Future<void> toggleTask(Task task) async {
    await _ref.child(task.id).update({'completed': !task.completed});
  }

  Future<void> deleteTask(String id) async {
    await _ref.child(id).remove();
  }
}
