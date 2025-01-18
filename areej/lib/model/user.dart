import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String password;
  final String userType;
  final DateTime joinDate;
  final int? ordersCount;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.password,
    this.userType = 'user', // Default userType is 'user'
    required this.joinDate,
    this.ordersCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'address': address,
      'password': password,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
       id: doc.id, 
      name: data['name'] ?? '', // Default to empty string if missing
      email: data['email'] ?? '', // Default to empty string if missing
      mobile: data['mobile'] ?? '', // Default to empty string if missing
      address: data['address'] ?? '', // Default to empty string if missing
      password: data['password'] ?? '', // Default to empty string if missing
      userType: data['userType'] ?? 'user', // Default to 'user' if missing
      joinDate: (data['joinDate'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
      ordersCount: data['ordersCount'] != null
          ? data['ordersCount'] as int
          : 0, // Default to 0 if null
    );
  }

  // Validation for fields
  String? validateName() {
    if (name.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  String? validateEmail() {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (email.isEmpty) {
      return "Please enter your email";
    }
    if (!regExp.hasMatch(email)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validateMobile() {
    if (mobile.isEmpty) {
      return "Please enter your mobile number";
    }
    if (mobile.length < 10) {
      return "Please enter a valid mobile number";
    }
    return null;
  }

  String? validateAddress() {
    if (address.isEmpty) {
      return "Please enter your address";
    }
    return null;
  }

  String? validatePassword() {
    if (password.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }

  // Method to check if passwords match
  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Please confirm your password";
    }
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}
