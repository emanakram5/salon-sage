import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_colors.dart';
import './user_model.dart';

class ProfileInfoScreen extends StatefulWidget {
  final UserModel user;
  const ProfileInfoScreen({super.key, required this.user});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {

  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController cityCtrl;
  String gender = "Female";
  File? image;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.user.name);
    phoneCtrl = TextEditingController(text: widget.user.phone);
    emailCtrl = TextEditingController(text: widget.user.email);
    cityCtrl = TextEditingController(text: widget.user.city);
    gender = widget.user.gender;
    image = widget.user.image;
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.primary),
        title: const Text("Profile", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// IMAGE PICKER
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.lightPurple,
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image == null
                    ? const Icon(Icons.camera_alt,
                        size: 32, color: AppColors.primary)
                    : null,
              ),
            ),

            const SizedBox(height: 24),

            _field("Name", controller: nameCtrl),
            _field("Phone", controller: phoneCtrl, prefix: "+92 "),
            _field("City", controller: cityCtrl),
            _field("Email", controller: emailCtrl),

            DropdownButtonFormField(
              value: gender,
              items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
              ],
              onChanged: (v) => setState(() => gender = v!),
              decoration: InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),

            /// UPDATE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    UserModel(
                      name: nameCtrl.text,
                      phone: phoneCtrl.text,
                      email: emailCtrl.text,
                      city: cityCtrl.text,
                      gender: gender,
                      image: image,
                    ),
                  );
                },
                child: const Text("Update Profile"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(String label,
      {required TextEditingController controller, String? prefix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
