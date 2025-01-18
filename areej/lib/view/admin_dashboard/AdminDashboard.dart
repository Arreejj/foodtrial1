import 'package:flutter/material.dart';
import 'package:areej/common_widget/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/user.dart';
import 'UserDetails.dart';
import 'UsersList.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference usersCollection;
  List<DocumentSnapshot> _users = [];

  @override
  void initState() {
    super.initState();
    usersCollection = _firestore.collection('users');
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final querySnapshot = await usersCollection.get();
    setState(() {
      _users = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Admin Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // User profile section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orange,
                  child: Text(
                    'A', // Admin's initial
                    style: const TextStyle(
                      fontSize: 28, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Name', 
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'admin@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
