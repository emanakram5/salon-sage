import 'package:flutter/material.dart';

class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceIcon({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFF3E5F5),
          child: Icon(icon, color: const Color(0xFF5B2C6F)),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
