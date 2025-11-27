import 'package:flutter/material.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF), // light lavender
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: const [
              OnboardingPage(
                image: "assets/onboarding1.png",
                title: "Declutter your life easily",
                subtitle: "Small changes can make a big impact.",
              ),
              OnboardingPage(
                image: "assets/onboarding2.png",
                title: "Track daily clean-up habits",
                subtitle: "Keep your home and mind organized.",
              ),
              OnboardingPage(
                image: "assets/onboarding3.png",
                title: "Stay motivated with progress",
                subtitle: "Build your streaks and stay consistent.",
              ),
            ],
          ),

          // PAGE INDICATOR
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentIndex == index ? 24 : 10,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? const Color(0xFF6C63FF)
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),

          // NEXT / GET STARTED BUTTON
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                if (_currentIndex == 2) {
                  Navigator.pushReplacementNamed(context, "/login");
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(
                _currentIndex == 2 ? "Get Started" : "Next",
                style: const TextStyle(fontFamily: "Poppins", fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
