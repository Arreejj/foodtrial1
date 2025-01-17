import 'package:flutter/material.dart';


class dashboardcard extends StatelessWidget {
  final String title;  
  final String count;  
  final IconData icon; 
  final Color color;   

  const dashboardcard({super.key, 
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), 
      elevation: 6, 
      color: const Color(0xFFF5F5F5), 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withOpacity(0.2), 
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              count, 
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6F00),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title, 
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
