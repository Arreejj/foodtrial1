import 'package:areej/view/home/home_view.dart';
import 'package:areej/view/login_signup/welcome_view.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../view/admin_dashboard/ResturantsList.dart';
import '../view/admin_dashboard/UsersList.dart';
import '../view/admin_dashboard/report.dart';
import '../view/admin_dashboard/Orders.dart';
import '../view/admin_dashboard/Settings.dart';
import '../view/home/home_view.dart';


class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xffffc6011),
            ),
            child: Text(
              'Admin Panel',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF4A4B4D)),
            title: Text('Homepage', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF4A4B4D)),
            title: Text('Users', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersList()),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt, color: Color(0xFF4A4B4D)),
            title: Text('Orders', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Orders()),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant, color: Color(0xFF4A4B4D)),
            title: Text('Resturants',
                style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const RestaurantsList()),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart, color: Color(0xFF4A4B4D)),
            title:
                Text('Reports', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Report()),
              ); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF4A4B4D)),
            title:
                Text('Settings', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
                );
            },
          ),
          const SizedBox(height: 300),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFF4A4B4D)),
            title: Text('Logout', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () async {
               await FirebaseAuthService().logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeView()),
                );
            },
          ),
        ],
      ),
    );
  }
}
