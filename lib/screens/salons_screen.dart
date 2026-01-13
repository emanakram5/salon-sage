import 'package:flutter/material.dart';
import '../widgets/salon_card.dart';

class SalonsScreen extends StatelessWidget {
  const SalonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: const Text("Salons",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF5B2C6F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, __) => const SalonCard(),
        ),
      ),
    );
  }
}
