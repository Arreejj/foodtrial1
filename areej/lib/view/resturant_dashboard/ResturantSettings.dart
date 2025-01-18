import 'package:flutter/material.dart';

class Resturantsettings extends StatefulWidget {
  const Resturantsettings({super.key});

  @override
  _ResturantsettingsState createState() => _ResturantsettingsState();
}

class _ResturantsettingsState extends State<Resturantsettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFFFF6F00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Notifications'),
              trailing: const Icon(Icons.notifications),
              onTap: () {
                // Handle notifications settings
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Change Profile'),
              trailing: const Icon(Icons.account_circle),
              onTap: () {
                // Navigate to profile settings screen
              },
            ),
            ListTile(
              title: const Text('Language'),
              trailing: const Icon(Icons.language),
              onTap: () {
                // Navigate to language settings screen
              },
            ),
            const ListTile(
              title: Text('App Version'),
              trailing: Text('1.0.0'),
            ),
          ],
        ),
      ),
    );
  }
}
