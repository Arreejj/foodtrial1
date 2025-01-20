import 'package:flutter/material.dart';
import 'package:areej/common_widget/Resturantsidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResturantDashboard extends StatefulWidget {
  const ResturantDashboard({super.key});

  @override
  _ResturantDashboardState createState() => _ResturantDashboardState();
}

class _ResturantDashboardState extends State<ResturantDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userName = "Loading..."; 
  String userEmail = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchRestaurantOwnerData();
  }

  Future<void> _fetchRestaurantOwnerData() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final userSnapshot =
            await _firestore.collection('users').doc(userId).get();
        if (userSnapshot.exists) {
          setState(() {
            userName = userSnapshot.data()?['name'] ?? 'Unknown User';
            userEmail = userSnapshot.data()?['email'] ?? 'No Email';
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        userName = "Error";
        userEmail = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('MealMonkey Restaurant Panel'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orange,
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : '',
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
                      userName, 
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userEmail, 
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            
          ],
        ),
      ),
    );
  }
}
