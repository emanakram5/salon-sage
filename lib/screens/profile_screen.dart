import 'package:flutter/material.dart';
import '../constants//app_colors.dart';
import 'profile_info_screen.dart';
import 'privacy_policy_screen.dart';
import 'help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // USER CARD
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.lightPurple,
                      child: Icon(Icons.person, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amna Wilson",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Islamabad",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _item(context, "Your profile", Icons.person, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileInfoScreen()));
              }),

              _item(context, "Privacy Policy", Icons.lock, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
              }),

              _item(context, "Help", Icons.help_outline, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HelpScreen()));
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

  Widget _item(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Are you sure you want to log out?",
                style: TextStyle(fontWeight: FontWeight.bold)),
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
                        backgroundColor: AppColors.primary),
                    onPressed: () {},
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
