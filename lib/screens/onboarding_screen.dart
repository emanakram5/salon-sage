import 'package:flutter/material.dart';
import '../widgets/onboarding_page.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 3) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        children: const [
          OnboardingPage(
            image: 'assets/images/Butterfly.png',
            title: '',
            description: '',
            isFirst: true,
          ),
          OnboardingPage(
            image: 'assets/images/appointment.png',
            title: 'Effortless Appointments\nat Your Fingertips',
            description:
                'Pick your dream salon, choose your preferred date\nand secure your spot in few taps.',
          ),
          OnboardingPage(
            image: 'assets/images/connect.png',
            title: 'Connect and Converse\nwith Salon',
            description: 'Live beauty consultations for seamless advice.',
          ),
          OnboardingPage(
            image: 'assets/images/welcome.png',
            title: 'Welcome to\nStyle Sage',
            description:
                'Unlock the new beauty secrets hidden\nin your neighborhood.',
            isLast: true,
          ),
        ],
      ),

      bottomNavigationBar: currentIndex == 3
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentIndex == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? const Color(0xFF6A1B9A)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF6A1B9A),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward,
                          color: Colors.white),
                      onPressed: nextPage,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
