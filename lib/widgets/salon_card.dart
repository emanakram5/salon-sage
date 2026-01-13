import 'package:flutter/material.dart';
import '../screens/booking_screen.dart';

class SalonCard extends StatelessWidget {
  const SalonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/salonImage.jpg",
              height: 90,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Bell curls , Salon",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 4),
                Text("Hair cutting and stylist",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(height: 4),
                Text("MON - SAT | 9:00 AM - 3:30 PM",
                    style: TextStyle(fontSize: 11)),
                SizedBox(height: 6),
                Text("3,000 PKR",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),

          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("★ 4.5",
                    style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B2C6F),
                  minimumSize: const Size(70, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const BookingScreen()),
  );
},

                child: const Text("Book",
                    style: TextStyle(fontSize: 12)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
