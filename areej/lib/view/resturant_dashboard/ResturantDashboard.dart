import 'package:flutter/material.dart';
import 'package:areej/common_widget/Resturantsidebar.dart';
class ResturantDashboard extends StatefulWidget {
  const ResturantDashboard({super.key});
  @override
  _ResturantDashboardState createState() => _ResturantDashboardState();
}
class _ResturantDashboardState extends State<ResturantDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final String userName = 'Reem Omar';  
  final String userEmail = 'reem@gmail.com'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        title: const Text('MealMonkey Resturant Panel'),
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
                    userName[0], 
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