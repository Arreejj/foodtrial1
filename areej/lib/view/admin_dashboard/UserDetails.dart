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
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
            Text('ID: ${user.id ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            Text('User Role: ${user.role}', style: const TextStyle(fontSize: 18)),
            if (user.role == 'user')
              Text('Orders Count: ${user.ordersCount}', style: const TextStyle(fontSize: 18)),
            Text('Join Date: ${user.joinDate.toLocal()}'.split(' ')[0], style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
