import 'package:areej/view/home/home_view.dart';
import 'package:areej/view/login_signup/welcome_view.dart';
import 'package:areej/view/resturant_dashboard/status.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../view/admin_dashboard/Orders.dart';
import '../view/resturant_dashboard/Category.dart';
import '../view/resturant_dashboard/Offers.dart';
import '../view/resturant_dashboard/Products.dart';
import '../view/resturant_dashboard/ResturantReport.dart';
import '../view/resturant_dashboard/ResturantSettings.dart';


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
              'Resturant Panel',
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
            leading: const Icon(Icons.hourglass_empty, color: Color(0xFF4A4B4D)),
            title: Text('Status', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Status()),
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
            leading: const Icon(Icons.category, color: Color(0xFF4A4B4D)),
            title: Text('Categories',
                style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Category()),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory, color: Color(0xFF4A4B4D)),
            title:
                Text('Products', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Products(categories: [],)),
                );
            },
          ),
           ListTile(
            leading: const Icon(Icons.local_offer, color: Color(0xFF4A4B4D)),
            title:
                Text('Offers', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Offers()),
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
                MaterialPageRoute(builder: (context) => Resturantreport()),
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
                MaterialPageRoute(builder: (context) => const Resturantsettings()),
                );
            },
          ),
          const SizedBox(height: 150),
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
