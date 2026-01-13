import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About Us",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Exceptional salon delivering premium beauty services with expert professionals.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const Divider(height: 30),

            const Text(
              "Working Hours",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            workingHour("Monday", "9:00am - 8:00pm"),
            workingHour("Tuesday", "9:00am - 8:00pm"),
            workingHour("Wednesday", "9:00am - 8:00pm"),
            workingHour("Thursday", "9:00am - 8:00pm"),
            workingHour("Friday", "9:00am - 8:00pm"),
          ],
        ),
      ),

      bottomNavigationBar: bookingButton(),
    );
  }

  Widget workingHour(String day, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day),
          Text(time, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget bookingButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B2C6F),
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {},
        child: const Text("Book Appointment"),
      ),
    );
  }
}
