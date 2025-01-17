import 'package:flutter/material.dart';
import 'package:areej/common_widget/sidebar.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dummy user data
  final String userName = 'Reem Omar';  // Replace with dynamic data if needed
  final String userEmail = 'reem@gmail.com'; // Replace with dynamic data if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        title: const Text('MealMonkey Admin Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
      ),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User profile section
            Row(
              children: [
                // CircleAvatar for user initials
                CircleAvatar(
                  radius: 40, // Avatar size
                  backgroundColor: Colors.orange, // Background color for the avatar
                  child: Text(
                    userName[0], // Display first letter of the user's name
                    style: const TextStyle(
                      fontSize: 28, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Space between avatar and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName, // User's full name
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userEmail, // User's email
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32), // Space between profile and other content
            // Add more widgets/content for the body below
            // For example, the rest of your dashboard or main content
          ],
        ),
      ),
    );
  }
}
