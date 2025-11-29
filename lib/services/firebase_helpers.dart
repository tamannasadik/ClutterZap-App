import 'package:firebase_database/firebase_database.dart';

class FirebaseHelpers {
  static Future<void> createDefaultUser() async {
    final db = FirebaseDatabase.instance.ref();
    final userRef = db.child('users/defaultUser');

    // Set default points and badges if they don't exist
    final snapshot = await userRef.get();
    if (!snapshot.exists) {
      await userRef.set({
        'points': 0,
        'badges': [],
      });
      print('Default user created!');
    } else {
      print('Default user already exists.');
    }
  }
}
