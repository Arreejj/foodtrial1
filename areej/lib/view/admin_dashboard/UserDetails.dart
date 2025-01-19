import 'package:flutter/material.dart';
import '/model/user.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Mobile: ${user.mobile}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Address: ${user.address}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Role: ${user.role}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Orders Count: ${user.ordersCount}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Join Date: ${user.joinDate}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
