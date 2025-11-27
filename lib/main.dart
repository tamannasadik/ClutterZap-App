// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'viewmodels/task_viewmodel.dart';
import 'viewmodels/quick_clean_viewmodel.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

// NEW SCREENS
import 'screens/home/home_screen.dart';
import 'screens/daily_tasks/daily_task_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => QuickCleanViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ClutterZap',

        // 🔥 App Theme 
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),

        // 🔥 First Screen (Splash → Onboarding → Login)
        home: const SplashScreen(),

        // 🔥 Routes (ALL NEW STRUCTURE FIXED)
        routes: {
          "/onboarding": (_) => const OnboardingScreen(),
          "/login": (_) => const LoginScreen(),
          "/register": (_) => const RegisterScreen(),
          "/home": (_) => const HomeScreen(),

          // NEW: Daily Tasks Screen
          "/daily_tasks": (_) => const DailyTaskScreen(),
        },
      ),
    );
  }
}
