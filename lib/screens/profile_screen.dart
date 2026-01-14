import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/app_colors.dart';
import './user_model.dart';
import 'profile_info_screen.dart';
import 'privacy_policy_screen.dart';
import 'help_screen.dart';
import 'home_screen.dart';
import 'booking_screen.dart';
import 'my_appointments_screen.dart';
import '../auth/signup_screen.dart'; // change if your screen name is different

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int _currentIndex = 3;

  /// USER DATA (DYNAMIC)
  UserModel user = UserModel(
    name: "Amna Wilson",
    phone: "+92 3000000000",
    email: "amna@email.com",
    gender: "Female",
    city: "Islamabad",
    image: null,
  );

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyAppointmentsScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BookingScreen()),
        );
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      /// 🔽 BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color(0xFF5B2C6F),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔹 USER CARD (DYNAMIC)
              GestureDetector(
                onTap: () async {
                  final updatedUser = await Navigator.push<UserModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileInfoScreen(user: user),
                    ),
                  );

                  if (updatedUser != null) {
                    setState(() => user = updatedUser);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.lightPurple,
                        backgroundImage:
                            user.image != null ? FileImage(user.image!) : null,
                        child: user.image == null
                            ? const Icon(Icons.person,
                                color: AppColors.primary)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.city,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 🔹 MENU ITEMS (UNCHANGED)
              _item(context, "Your profile", Icons.person, () async {
                final updatedUser = await Navigator.push<UserModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileInfoScreen(user: user),
                  ),
                );

                if (updatedUser != null) {
                  setState(() => user = updatedUser);
                }
              }),

              _item(context, "Privacy Policy", Icons.lock, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen(),
                  ),
                );
              }),

              _item(context, "Help", Icons.help_outline, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HelpScreen(),
                  ),
                );
              }),

              _item(context, "Log Out", Icons.logout, () {
                _showLogoutSheet(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  /// 🔥 FIREBASE LOGOUT
  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Are you sure you want to log out?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () async {
                      try {
                        /// close sheet
                        Navigator.pop(context);

                        /// firebase logout
                        await FirebaseAuth.instance.signOut();

                        /// go to signup/login & clear stack
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  SignupScreen(),
                          ),
                          (route) => false,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Logout failed: $e"),
                          ),
                        );
                      }
                    },
                    child: const Text("Logout"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
