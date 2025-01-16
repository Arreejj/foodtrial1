import 'package:areej/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:areej/view/login_signup/login_view.dart';
import 'package:areej/view/login_signup/sign_up_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App Logo and Top Shape
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                "assets/img/welcome_top_shape.png",
                width: media.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: media.height * 0.35,
                child: Image.asset(
                  "assets/img/app_logo.png",
                  width: media.width * 0.55,
                  height: media.height * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(height: media.height * 0.04),

          // Description Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: media.width * 0.1),
            child: Text(
              "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: media.height * 0.08),

          // Login Button
          SizedBox(
            width: media.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColor.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: media.height * 0.02),

          // Sign-Up Button
          SizedBox(
            width: media.width * 0.8,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SignUpView()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: TColor.primary,
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                "Create an Account",
                style: TextStyle(
                  color: TColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
