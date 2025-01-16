// import 'package:areej/view/login_signup/welcome_view.dart';
// import 'package:flutter/material.dart';

// class StartupView extends StatefulWidget {
//   const StartupView({super.key});

//   @override
//   State<StartupView> createState() => _StartupViewState();
// }

// class _StartupViewState extends State<StartupView> {
//   @override
//   void initState() {
//     super.initState();
//     gowelcomepage();
//   }

//   void gowelcomepage() async {
//     await Future.delayed(const Duration(seconds: 3));
//     welcomePage();
//   }

//   void welcomePage() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const WelcomeView()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Background image
//           Image.asset(
//             "assets/img/splash_bg.png",
//             width: media.width,
//             height: media.height,
//             fit: BoxFit.cover,
//           ),

//           Positioned(
//             top: media.height * 0.3,
//             child: Image.asset(
//               "assets/img/app_logo.png",
//               width: media.width * 0.5,
//               height: media.height * 0.25,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
