import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  String _currentStatus = "Open"; 

  void _updateStatus(String newStatus) {
    setState(() {
      _currentStatus = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Restaurant status updated to $newStatus")),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "open":
        return Colors.green;
      case "busy":
        return Colors.orange;
      case "closed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Status:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _currentStatus,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(_currentStatus),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Change Status:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _updateStatus("Open"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Open"),
                ),
                ElevatedButton(
                  onPressed: () => _updateStatus("Busy"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Busy"),
                ),
                ElevatedButton(
                  onPressed: () => _updateStatus("Closed"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Closed"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
