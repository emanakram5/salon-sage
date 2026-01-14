import 'package:flutter/material.dart';
import 'review_summary_screen.dart';
import 'home_screen.dart';

class BookedSuccessfullyScreen extends StatelessWidget {
  final String salonName;
  final List<String> services;
  final DateTime date;
  final String slot;

  const BookedSuccessfullyScreen({
    super.key,
    required this.salonName,
    required this.services,
    required this.date,
    required this.slot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Tick Icon
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5B2C6F),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 70,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Appointment Created\nSuccessfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                /// Review Summary Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B2C6F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReviewSummaryScreen(
                            salonName: salonName,
                            services: services,
                            date: date,
                            slot: slot,
                          ),
                        ),
                      );
                    },
                    child: const Text("Review Summary"),
                  ),
                ),

                const SizedBox(height: 16),

                /// Back to Home
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF5B2C6F)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Back to Home",
                      style: TextStyle(color: Color(0xFF5B2C6F)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
