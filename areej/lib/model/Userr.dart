// lib/models/user.dart
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String userType; // 'employee' or 'user'
  final int? ordersCount; // Nullable, only set for regular users
  final DateTime joinDate;

  // Constructor
  User({
    required this.name,
    required this.email,
    required this.userType,
    required this.joinDate,
    this.ordersCount,
  }) : id = const Uuid().v4(); // Generate a unique ID for each user

  // Method to create a user from a map (e.g., from a database)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      userType: map['userType'],
      joinDate: DateTime.parse(map['joinDate']),
      ordersCount: map['ordersCount'],
    );
  }

  // Method to convert a user to a map (e.g., to save in a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userType': userType,
      'joinDate': joinDate.toIso8601String(),
      'ordersCount': ordersCount,
    };
  }
}
