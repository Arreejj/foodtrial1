import 'package:flutter/material.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/tab_button.dart';
import 'package:areej/view/home/home_view.dart';
import 'package:areej/view/menu/menu_view.dart';
import 'package:areej/view/more/more_view.dart';
import 'package:areej/view/offer/offer_view.dart';
import 'package:areej/view/profile/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _selectedTab = 2;
  final PageController _pageController = PageController(initialPage: 2); // PageController to manage PageView
  
  final List<Widget> _pages = [
    const MenuView(),
    const OfferView(),
    const HomeView(),
    const ProfileView(),
    MoreView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();  // Manually open the drawer
          },
        ),
      ),
      drawer: Drawer(  // Add a Drawer here if needed
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text('Menu'),
              onTap: () {
                setState(() {
                  _selectedTab = 0;
                });
                Navigator.pop(context);
                _pageController.jumpToPage(0); // Jump to Menu tab
              },
            ),
            ListTile(
              title: Text('Offer'),
              onTap: () {
                setState(() {
                  _selectedTab = 1;
                });
                Navigator.pop(context);
                _pageController.jumpToPage(1); // Jump to Offer tab
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                setState(() {
                  _selectedTab = 3;
                });
                Navigator.pop(context);
                _pageController.jumpToPage(3); // Jump to Profile tab
              },
            ),
            ListTile(
              title: Text('More'),
              onTap: () {
                setState(() {
                  _selectedTab = 4;
                });
                Navigator.pop(context);
                _pageController.jumpToPage(4); // Jump to More tab
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,  // PageController to control PageView
        onPageChanged: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        children: _pages,  // PageView uses the pages list
      ),
      backgroundColor: const Color(0xfff5f5f5),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            if (_selectedTab != 2) {
              setState(() {
                _selectedTab = 2;
              });
              _pageController.jumpToPage(2); // Jump to the home tab
            }
          },
          shape: const CircleBorder(),
          backgroundColor: _selectedTab == 2 ? TColor.primary : TColor.placeholder,
          child: Image.asset(
            "assets/img/tab_home.png",
            width: 30,
            height: 30,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: TColor.white,
        shadowColor: Colors.black,
        elevation: 1,
        notchMargin: 12,
        height: 64,
        shape: const CircularNotchedRectangle(),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                  title: "Menu",
                  icon: "assets/img/tab_menu.png",
                  onTap: () {
                    _pageController.jumpToPage(0);  // Jump to the Menu tab
                  },
                  isSelected: _selectedTab == 0),
              TabButton(
                  title: "Offer",
                  icon: "assets/img/tab_offer.png",
                  onTap: () {
                    _pageController.jumpToPage(1);  // Jump to the Offer tab
                  },
                  isSelected: _selectedTab == 1),
              const SizedBox(width: 40, height: 40),
              TabButton(
                  title: "Profile",
                  icon: "assets/img/tab_profile.png",
                  onTap: () {
                    _pageController.jumpToPage(3);  // Jump to the Profile tab
                  },
                  isSelected: _selectedTab == 3),
              TabButton(
                  title: "More",
                  icon: "assets/img/tab_more.png",
                  onTap: () {
                    _pageController.jumpToPage(4);  // Jump to the More tab
                  },
                  isSelected: _selectedTab == 4),
            ],
          ),
        ),
      ),
    );
  }
}
