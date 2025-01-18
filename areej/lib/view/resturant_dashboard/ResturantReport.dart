import 'package:flutter/material.dart';
import 'package:areej/common_widget/dashboardcard.dart'; 

class Resturantreport extends StatelessWidget {
  
  final List<Map<String, dynamic>> reportData = [
    {
      'title': 'Total Orders',
      'count': '200',
      'icon': Icons.restaurant_menu,
      'color': Colors.green,
    },
    {
      'title': 'Total Revenue',
      'count': '\$15,000',
      'icon': Icons.monetization_on,
      'color': Colors.blue,
    },
    {
      'title': 'Pending Deliveries',
      'count': '34',
      'icon': Icons.delivery_dining,
      'color': Colors.orange,
    },
    {
      'title': 'New Customers',
      'count': '123',
      'icon': Icons.person_add,
      'color': Colors.purple,
    },
  ];

Resturantreport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00), 
        title: const Text('Reports', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
