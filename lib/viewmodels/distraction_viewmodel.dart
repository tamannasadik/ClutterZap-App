import 'dart:async';
import 'package:flutter/material.dart';

class DistractionViewModel extends ChangeNotifier {
  Timer? _idleTimer;
  final Duration idleDuration = const Duration(minutes: 2); // 2 min idle

  // Start timer
  void startIdleTimer(VoidCallback onTimeout) {
    cancelTimer(); // avoid duplicate timers

    _idleTimer = Timer(idleDuration, () {
      onTimeout();   // Alert show callback
    });
  }

  // Reset timer on user activity
  void resetIdleTimer(VoidCallback onTimeout) {
    startIdleTimer(onTimeout);
  }

  // Cancel timer
  void cancelTimer() {
    _idleTimer?.cancel();
  }
}
