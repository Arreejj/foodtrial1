import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:areej/common_widget/dashboardcard.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  int totalUsers = 0;
  int totalRestaurants = 0;

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  Future<void> _fetchReportData() async {
    try {
      // Fetch the number of users
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      final restaurantSnapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();

      setState(() {
        totalUsers = userSnapshot.docs.length;
        totalRestaurants = restaurantSnapshot.docs.length;
      });
    } catch (e) {
      print('Error fetching report data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reportData = [
      {
        'title': 'Total Users',
        'count': '$totalUsers',
        'icon': Icons.people,
        'color': Colors.green,
      },
      {
        'title': 'Total Restaurants',
        'count': '$totalRestaurants',
        'icon': Icons.restaurant,
        'color': Colors.blue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        title: const Text('Reports',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: reportData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final report = reportData[index];
            return dashboardcard(
              title: report['title'],
              count: report['count'],
              icon: report['icon'],
              color: report['color'],
            );
          },
        ),
      ),
    );
  }
}
