import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.primary),
        title: const Text("Privacy Policy",
            style: TextStyle(color: Colors.black)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            "Information we collect...\n\n"
            "Usage information...\n\n"
            "Cookies and similar technologies...\n\n"
            "We respect your privacy...",
            style: TextStyle(height: 1.6),
          ),
        ),
      ),
    );
  }
}
