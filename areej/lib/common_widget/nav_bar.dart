// import 'package:flutter/material.dart';
// import 'package:areej/common/color_extension.dart';
// import 'package:areej/common_widget/tab_button.dart';
// import 'package:areej/view/menu/menu_view.dart';
// import 'package:areej/view/offer/offer_view.dart';
// import 'package:areej/view/profile/profile_view.dart';
// import 'package:areej/view/home/home_view.dart';
// import 'package:areej/view/more/more_view.dart';

// class NavBar extends StatefulWidget {
//   final int initialTab;
//   final List<Widget> pages;

//   const NavBar({
//     Key? key,
//     this.initialTab = 2,
//     required this.pages,
//   }) : super(key: key);

//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   late int selectedTab;
//   late Widget currentPage;

//   @override
//   void initState() {
//     super.initState();
//     selectedTab = widget.initialTab;
//     currentPage = widget.pages[selectedTab];
//   }

//   void onTabSelected(int tabIndex) {
//     if (tabIndex >= 0 && tabIndex < widget.pages.length) {
//       setState(() {
//         selectedTab = tabIndex;
//         currentPage = widget.pages[selectedTab];
//       });
//     } else {
//       print("Invalid tab index: $tabIndex");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentPage,
//       backgroundColor: const Color(0xfff5f5f5),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: SizedBox(
//         width: 60,
//         height: 60,
//         child: FloatingActionButton(
//           onPressed: () => onTabSelected(0), // Navigate to Home tab
//           shape: const CircleBorder(),
//           backgroundColor:
//               selectedTab == 0 ? TColor.primary : TColor.placeholder,
//           child: Image.asset(
//             "assets/img/tab_home.png", // Ensure this icon exists
//             width: 30,
//             height: 30,
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         surfaceTintColor: TColor.white,
//         shadowColor: Colors.black,
//         elevation: 1,
//         notchMargin: 12,
//         height: 64,
//         shape: const CircularNotchedRectangle(),
//         child: SafeArea(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TabButton(
//                 title: "Menu",
//                 icon: "assets/img/tab_menu.png",
//                  onTap: () {
//                   Navigator.push(
//                  context,
//          MaterialPageRoute(builder: (context) =>  MenuView()),
//            );
//                   onTabSelected(1); 
//                 },
//                 isSelected: selectedTab == 1,
//               ),
//               TabButton(
//                 title: "Offers",
//                 icon: "assets/img/tab_offer.png",
//                 onTap: () {
//                   Navigator.push(
//                  context,
//          MaterialPageRoute(builder: (context) => const OfferView()),
//            );
//                   onTabSelected(2); // Updates the page to Profile view
//                 },
//                 isSelected: selectedTab == 2,
//               ),
//               const SizedBox(width: 40), // Space for FAB
//               TabButton(
//                 title: "Profile",
//                 icon: "assets/img/tab_profile.png",
//                 onTap: () {
//                   Navigator.push(
//                  context,
//          MaterialPageRoute(builder: (context) => const ProfileView()),
//            );
//                   onTabSelected(3); // Updates the page to Profile view
//                 },
//                 isSelected: selectedTab == 3,
//               ),
//               TabButton(
//                 title: "More",
//                 icon: "assets/img/tab_more.png",
//                 onTap: () => onTabSelected(4),
//                 isSelected: selectedTab == 4,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
