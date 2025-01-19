// lib/screens/user_details_page.dart
import 'package:flutter/material.dart';
import '/model/user.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}'),
            Text('id: ${user.id}'),
            Text('Email: ${user.email}'),
            Text('User Type: ${user.role}'),
            if (user.role == 'user') Text('Orders Count: ${user.ordersCount}'),
            Text('Join Date: ${user.joinDate.toLocal()}'),
          ],
        ),
      ),
    );
  }
}
