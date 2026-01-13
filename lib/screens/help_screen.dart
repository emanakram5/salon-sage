import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.primary),
        title: const Text("Help", style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _faq("What is Style Saga about?"),
          _faq("How to cancel appointment?"),
          _faq("How to check transactions?"),
          const SizedBox(height: 20),
          _social("Facebook"),
          _social("Instagram"),
          _social("LinkedIn"),
          _social("Twitter"),
        ],
      ),
    );
  }

  Widget _faq(String title) {
    return ExpansionTile(
      title: Text(title),
      children: const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text("Answer goes here."),
        )
      ],
    );
  }

  Widget _social(String title) {
    return ListTile(
      leading: const Icon(Icons.link, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
