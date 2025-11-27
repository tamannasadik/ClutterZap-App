import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SmartScanViewModel extends ChangeNotifier {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child("scans");

  Future<void> saveScannedData(String code) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      await _dbRef.push().set({
        "code": code,
        "timestamp": timestamp,
      });

      print("Scanned code saved: $code");
    } catch (e) {
      print("Error saving scanned data: $e");
    }
  }
}
