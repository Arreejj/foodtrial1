// user.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String password; // Consider hashing this
  final String role; // "admin", "owner", or "user"
  final String? restaurantId; // Nullable for non-owners
  final DateTime joinDate;
  final int ordersCount;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.password,
    this.role = 'user',
    this.restaurantId,
    required this.joinDate,
    this.ordersCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'address': address,
      'password': password, // Consider storing hashed password
      'role': role,
      'restaurantId': restaurantId,
      'joinDate': joinDate,
      'ordersCount': ordersCount, // Store ordersCount as an integer
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      mobile: data['mobile'] ?? '',
      address: data['address'] ?? '',
      password: data['password'] ?? '',
      role: data['role'] ?? 'user',
      restaurantId: data['restaurantId'],
      joinDate: data['joinDate'] != null
          ? (data['joinDate'] as Timestamp).toDate()
          : DateTime.now(),
      ordersCount: data['ordersCount'] != null
          ? data['ordersCount'] as int // Directly treat ordersCount as int
          : 0, // Default to 0 if ordersCount is null
    );
  }

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
