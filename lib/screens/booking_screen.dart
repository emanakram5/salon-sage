import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './booked_successfully_screen.dart';


enum BookingSection { services, gallery, reviews, about }

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  BookingSection _currentSection = BookingSection.services;

  final List<String> selectedServices = [];
  bool showConfirmAppointment = false;

  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  String? selectedSlot;

  /// TOGGLE SERVICES
  void toggleService(String service) {
    setState(() {
      selectedServices.contains(service)
          ? selectedServices.remove(service)
          : selectedServices.add(service);
    });
  }

  /// SAVE APPOINTMENT TO FIREBASE
  Future<void> saveAppointment() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please login first")),
    );
    return;
  }

  if (selectedSlot == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select a time slot")),
    );
    return;
  }

  if (selectedServices.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select at least one service")),
    );
    return;
  }

  try {
    await FirebaseFirestore.instance.collection('appointments').add({
      'userId': user.uid,
      'salonName': 'Enclave, Haven',
      'services': selectedServices,
      'date': Timestamp.fromDate(selectedDate),
      'slot': selectedSlot, // ✅ NO !
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BookedSuccessfullyScreen(
          salonName: 'Enclave, Haven',
          services: selectedServices,
          date: selectedDate,
          slot: selectedSlot!, // safe now because we validated above
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () {
      if (showConfirmAppointment) {
        // If on confirmation screen, go back to services selection
        setState(() => showConfirmAppointment = false);
      } else {
        // Otherwise, go back to the previous screen
        Navigator.of(context).maybePop();
      }
    },
  ),
  backgroundColor: Colors.white,
  elevation: 0,
),


      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/salonImage.jpg",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            /// TITLE
            const Text(
              "Enclave, Haven",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            /// SELECTED SERVICES
            if (selectedServices.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedServices.map((s) {
                  return Chip(
                    label: Text(s),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => toggleService(s),
                  );
                }).toList(),
              ),

            const SizedBox(height: 12),

            /// ADDRESS
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    "0539 NYC, Street #98, Maine#04, Inglewood",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Open",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),

            /// TABS
            if (!showConfirmAppointment) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _tabItem("Services", BookingSection.services),
                  _tabItem("Gallery", BookingSection.gallery),
                  _tabItem("Reviews", BookingSection.reviews),
                  _tabItem("About", BookingSection.about),
                ],
              ),
              const Divider(height: 30),
            ],

            /// CONTENT
            showConfirmAppointment
                ? _confirmAppointmentSection()
                : _buildSectionContent(),

            const SizedBox(height: 100),
          ],
        ),
      ),

      /// BOTTOM BUTTON
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5B2C6F),
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () {
            if (!showConfirmAppointment) {
              setState(() => showConfirmAppointment = true);
            } else {
              saveAppointment();
            }
          },
          child: Text(
            showConfirmAppointment
                ? "Confirm Appointment"
                : "Book Appointment",
          ),
        ),
      ),
    );
  }

  /// TAB ITEM
  Widget _tabItem(String title, BookingSection section) {
    final isActive = _currentSection == section;
    return GestureDetector(
      onTap: () => setState(() => _currentSection = section),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isActive ? const Color(0xFF5B2C6F) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (_currentSection) {
      case BookingSection.gallery:
        return _gallerySection();
      case BookingSection.reviews:
        return _reviewsSection();
      case BookingSection.about:
        return _aboutSection();
      case BookingSection.services:
      default:
        return _servicesSection();
    }
  }

  /// SERVICES
  Widget _servicesSection() {
    return Column(
      children: [
        ServiceDropdown(
          title: "Hair Services",
          services: const [
            "Hair Cut",
            "Hair Coloring",
            "Hair Highlights",
            "Keratin Treatment",
            "Hair Spa",
          ],
          selectedServices: selectedServices,
          onSelect: toggleService,
        ),
        ServiceDropdown(
          title: "Nail Services",
          services: const [
            "Gel Nails",
            "Acrylic Nails",
            "Nail Extensions",
            "Nail Art",
          ],
          selectedServices: selectedServices,
          onSelect: toggleService,
        ),
        ServiceDropdown( title: "Manicure Services", services: [ "Classic Manicure", "French Manicure", "Spa Manicure", "Paraffin Manicure", ], selectedServices: selectedServices, onSelect: toggleService, ), ServiceDropdown( title: "Hydra Facial", services: [ "Basic Hydra Facial", "Deep Cleansing Facial", "Anti-Aging Facial", "Skin Brightening Facial", ], selectedServices: selectedServices, onSelect: toggleService, ),
      ],
    );
  }

  /// CONFIRM APPOINTMENT
  Widget _confirmAppointmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Book Appointment",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text("Select Date"),
        const SizedBox(height: 8),
        _buildCustomCalendar(),
        const SizedBox(height: 20),
        const Text("Available Slots"),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _slot("10:00 AM"),
            _slot("11:30 AM"),
            _slot("02:00 PM"),
            _slot("05:30 PM"),
          ],
        ),
      ],
    );
  }

  /// SLOT
  Widget _slot(String time) {
    final isSelected = selectedSlot == time;
    return GestureDetector(
      onTap: () => setState(() => selectedSlot = time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B2C6F) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.purple),
        ),
        child: Text(
          time,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  /// CUSTOM CALENDAR
  Widget _buildCustomCalendar() {
    final daysInMonth =
        DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    final firstDay =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    currentMonth =
                        DateTime(currentMonth.year, currentMonth.month - 1);
                  });
                },
              ),
              Text(
                "${_monthName(currentMonth.month)} ${currentMonth.year}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    currentMonth =
                        DateTime(currentMonth.year, currentMonth.month + 1);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
            itemCount: daysInMonth + firstDay - 1,
            itemBuilder: (context, index) {
              if (index < firstDay - 1) return const SizedBox();
              final day = index - firstDay + 2;
              final date =
                  DateTime(currentMonth.year, currentMonth.month, day);

              final isSelected = date.day == selectedDate.day &&
                  date.month == selectedDate.month &&
                  date.year == selectedDate.year;

              final isPast =
                  date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

              return GestureDetector(
                onTap:
                    isPast ? null : () => setState(() => selectedDate = date),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF5B2C6F)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "$day",
                    style: TextStyle(
                      color: isPast
                          ? Colors.grey
                          : isSelected
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  /// GALLERY
  Widget _gallerySection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset("assets/images/salonImage.jpg", fit: BoxFit.cover),
        );
      },
    );
  }

  /// REVIEWS
  Widget _reviewsSection() {
    return Column(
      children: [
        _reviewCard("Jessica Wilson"),
        _reviewCard("Jane Austen"),
      ],
    );
  }

  Widget _reviewCard(String name) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          "Exceptional service with friendly staff.",
        ),
      ),
    );
  }

  /// ABOUT
  Widget _aboutSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("About Us", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text("We provide professional salon services."),
        SizedBox(height: 16),
        Text("Working Hours", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text("Mon–Fri: 9:00 AM – 8:00 PM"),
        Text("Sat–Sun: 10:00 AM – 6:00 PM"),
      ],
    );
  }
}

/// SERVICE DROPDOWN
class ServiceDropdown extends StatefulWidget {
  final String title;
  final List<String> services;
  final List<String> selectedServices;
  final Function(String) onSelect;

  const ServiceDropdown({
    super.key,
    required this.title,
    required this.services,
    required this.selectedServices,
    required this.onSelect,
  });

  @override
  State<ServiceDropdown> createState() => _ServiceDropdownState();
}

class _ServiceDropdownState extends State<ServiceDropdown> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
          child: Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                Icon(expanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        if (expanded)
          Column(
            children: widget.services.map((s) {
              final isSelected = widget.selectedServices.contains(s);
              return ListTile(
                onTap: () => widget.onSelect(s),
                leading: Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                title: Text(s),
              );
            }).toList(),
          ),
      ],
    );
  }
}
