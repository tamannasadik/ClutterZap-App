// lib/screens/splash/splash_screen.dart
import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Onboarding after 2-3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'ClutterZap',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../../theme/app_text.dart';
// import '../../theme/app_colors.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pushReplacementNamed(context, "/onboarding");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.cleaning_services, size: 90, color: AppColors.primary),
//             const SizedBox(height: 20),
//             Text("ClutterZap", style: AppText.h1),
//             const SizedBox(height: 10),
//             Text("Clear Space. Clear Mind.", style: AppText.h3),
//           ],
//         ),
//       ),
//     );
//   }
// }
