import 'dart:io';

class UserModel {
  String name;
  String phone;
  String email;
  String gender;
  String city;
  File? image;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.city,
    this.image,
  });
}
