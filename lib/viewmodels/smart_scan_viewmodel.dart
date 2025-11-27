// import 'package:flutter/foundation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SmartScanViewModel extends ChangeNotifier {
//   final tasks = FirebaseFirestore.instance.collection('tasks');

//   Future<void> addDummyTask() async {
//     try {
//       await tasks.add({
//         'title': 'Sample Task',
//         'created': DateTime.now(),
//       });
//       debugPrint("Dummy task added successfully!");
//     } catch (e) {
//       debugPrint("Error adding task: $e");
//     }
//   }
// }


import 'package:flutter/material.dart';
class SmartScanViewModel extends ChangeNotifier {
  String message = "Smart Scan Ready";

  void updateMessage(String newMessage) {
    message = newMessage;
    notifyListeners();
  }
}
