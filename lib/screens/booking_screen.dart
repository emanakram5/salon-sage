


// import 'package:flutter/material.dart';

// /// SECTION ENUM
// enum BookingSection { services, gallery, reviews, about }

// class BookingScreen extends StatefulWidget {
//   const BookingScreen({super.key});

//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   BookingSection _currentSection = BookingSection.services;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// SALON IMAGE
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(
//                 "assets/images/salonImage.jpg",
//                 height: 180,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             const SizedBox(height: 16),

//             /// SALON INFO
//             const Text(
//               "Enclave, Haven",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               "Haircuts, Makeup, Manicure, Hydra facial",
//               style: TextStyle(color: Colors.grey),
//             ),

//             const SizedBox(height: 12),

//             /// ADDRESS + STATUS
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 16, color: Colors.red),
//                 const SizedBox(width: 4),
//                 const Expanded(
//                   child: Text(
//                     "0539 NYC, Street #98, Maine#04, Inglewood",
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Text(
//                     "Open",
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 )
//               ],
//             ),

//             const SizedBox(height: 16),

//             /// TABS
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _tabItem("Services", BookingSection.services),
//                 _tabItem("Gallery", BookingSection.gallery),
//                 _tabItem("Reviews", BookingSection.reviews),
//                 _tabItem("About us", BookingSection.about),
//               ],
//             ),

//             const Divider(height: 30),

//             /// CONTENT
//             _buildSectionContent(),

//             const SizedBox(height: 90),
//           ],
//         ),
//       ),

//       /// BOOK BUTTON
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF5B2C6F),
//             minimumSize: const Size(double.infinity, 50),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           ),
//           onPressed: () {},
//           child: const Text("Book Appointment"),
//         ),
//       ),
//     );
//   }

//   /// TAB ITEM
//   Widget _tabItem(String title, BookingSection section) {
//     final bool isActive = _currentSection == section;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _currentSection = section;
//         });
//       },
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: isActive ? const Color(0xFF5B2C6F) : Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 6),
//           if (isActive)
//             Container(
//               width: 30,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.teal,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   /// SWITCH CONTENT
//   Widget _buildSectionContent() {
//     switch (_currentSection) {
//       case BookingSection.gallery:
//         return _gallerySection();
//       case BookingSection.reviews:
//         return _reviewsSection();
//       case BookingSection.about:
//         return _aboutSection();
//       case BookingSection.services:
//       default:
//         return _servicesSection();
//     }
//   }

//   /// SERVICES SECTION (WORKING DROPDOWNS)
//   Widget _servicesSection() {
//     return const Column(
//       children: [
//         ServiceDropdown(
//           title: "Hair Services",
//           services: [
//             "Hair Cut",
//             "Hair Coloring",
//             "Hair Highlights",
//             "Keratin Treatment",
//             "Hair Spa",
//             "Hair Styling",
//           ],
//         ),
//         ServiceDropdown(
//           title: "Nail Services",
//           services: [
//             "Gel Nails",
//             "Acrylic Nails",
//             "Nail Extensions",
//             "Nail Art",
//             "Nail Repair",
//           ],
//         ),
//         ServiceDropdown(
//           title: "Manicure Services",
//           services: [
//             "Classic Manicure",
//             "French Manicure",
//             "Spa Manicure",
//             "Paraffin Manicure",
//           ],
//         ),
//         ServiceDropdown(
//           title: "Hydra Facial",
//           services: [
//             "Basic Hydra Facial",
//             "Deep Cleansing Facial",
//             "Anti-Aging Facial",
//             "Skin Brightening Facial",
//           ],
//         ),
//       ],
//     );
//   }

//   /// GALLERY
//   Widget _gallerySection() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//       ),
//       itemCount: 4,
//       itemBuilder: (context, index) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Image.asset(
//             "assets/images/salonImage.jpg",
//             fit: BoxFit.cover,
//           ),
//         );
//       },
//     );
//   }

//   /// REVIEWS
//   Widget _reviewsSection() {
//     return Column(
//       children: [
//         _reviewCard("Jessica Wilson"),
//         _reviewCard("Jane Austen"),
//       ],
//     );
//   }

//   Widget _reviewCard(String name) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(name,
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 6),
//             const Text(
//                 "Exceptional service with friendly staff and clean environment."),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ABOUT US
//   Widget _aboutSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text("About Us", style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         Text(
//             "We provide professional salon services with experienced stylists."),
//         SizedBox(height: 16),
//         Text("Working Hours",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         Text("Monday - Friday: 9:00 AM - 8:00 PM"),
//         Text("Saturday - Sunday: 10:00 AM - 6:00 PM"),
//       ],
//     );
//   }
// }

// /// SERVICE DROPDOWN WIDGET
// class ServiceDropdown extends StatefulWidget {
//   final String title;
//   final List<String> services;

//   const ServiceDropdown({
//     super.key,
//     required this.title,
//     required this.services,
//   });

//   @override
//   State<ServiceDropdown> createState() => _ServiceDropdownState();
// }

// class _ServiceDropdownState extends State<ServiceDropdown> {
//   bool _expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               _expanded = !_expanded;
//             });
//           },
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.purple),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.title,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 Icon(
//                   _expanded
//                       ? Icons.keyboard_arrow_up
//                       : Icons.keyboard_arrow_down,
//                 ),
//               ],
//             ),
//           ),
//         ),

//         AnimatedCrossFade(
//           firstChild: const SizedBox.shrink(),
//           secondChild: _serviceList(),
//           crossFadeState: _expanded
//               ? CrossFadeState.showSecond
//               : CrossFadeState.showFirst,
//           duration: const Duration(milliseconds: 200),
//         ),
//       ],
//     );
//   }

//   Widget _serviceList() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.purple.shade100),
//       ),
//       child: Column(
//         children: widget.services
//             .map(
//               (service) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 6),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.check_circle,
//                         size: 18, color: Colors.green),
//                     const SizedBox(width: 8),
//                     Text(service),
//                   ],
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

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

  void toggleService(String service) {
    setState(() {
      selectedServices.contains(service)
          ? selectedServices.remove(service)
          : selectedServices.add(service);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (showConfirmAppointment) {
              setState(() => showConfirmAppointment = false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

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

            const SizedBox(height: 6),

            /// SELECTED SERVICES
            if (selectedServices.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedServices.map((service) {
                  return Chip(
                    label: Text(service),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => toggleService(service),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],

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

            /// TABS (HIDE WHEN CONFIRM)
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
              // CONFIRM ACTION HERE
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
            )
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
  /// SERVICES SECTION
  Widget _servicesSection() {
    return Column(
      children: [
        ServiceDropdown(
          title: "Hair Services",
          services: [
            "Hair Cut",
            "Hair Coloring",
            "Hair Highlights",
            "Keratin Treatment",
            "Hair Spa",
            "Hair Styling",
          ],
          selectedServices: selectedServices,
          onSelect: toggleService,
        ),
        ServiceDropdown(
          title: "Nail Services",
          services: [
            "Gel Nails",
            "Acrylic Nails",
            "Nail Extensions",
            "Nail Art",
            "Nail Repair",
          ],
          selectedServices: selectedServices,
          onSelect: toggleService,
        ),
        ServiceDropdown(
          title: "Manicure Services",
          services: [
            "Classic Manicure",
            "French Manicure",
            "Spa Manicure",
            "Paraffin Manicure",
          ],
          selectedServices: selectedServices,
          onSelect: toggleService,
        ),
        ServiceDropdown(
          title: "Hydra Facial",
          services: [
            "Basic Hydra Facial",
            "Deep Cleansing Facial",
            "Anti-Aging Facial",
            "Skin Brightening Facial",
          ],
          selectedServices: selectedServices,
          onSelect: toggleService,
        ),
      ],
    );
  }
  /// CONFIRM APPOINTMENT (CALENDAR + SLOTS PLACEHOLDER)
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
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Center(
            child: Text("Calendar Widget Here"),
          ),
        ),

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

  Widget _slot(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.purple),
      ),
      child: Text(time),
    );
  }
//gallery Section
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
          child: Image.asset(
            "assets/images/salonImage.jpg",
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }


  //Reviews Section

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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text(
                "Exceptional service with friendly staff and clean environment."),
          ],
        ),
      ),
    );
  }
  /// ABOUT US section
  /// ABOUT
  Widget _aboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("About Us", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(
            "We provide professional salon services with experienced stylists."),
        SizedBox(height: 16),
        Text("Working Hours",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text("Monday - Friday: 9:00 AM - 8:00 PM"),
        Text("Saturday - Sunday: 10:00 AM - 6:00 PM"),
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
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
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
                Icon(_expanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        if (_expanded)
          Column(
            children: widget.services.map((s) {
              final isSelected =
                  widget.selectedServices.contains(s);
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
          )
      ],
    );
  }
}
