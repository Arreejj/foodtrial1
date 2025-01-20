import 'package:flutter/material.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:areej/view/login_signup/welcome_view.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController txtEmail = TextEditingController();

  // Method to send reset password link to the email
  Future<void> sendResetLink() async {
    try {
      String email = txtEmail.text;

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid email")),
        );
        return;
      }

      // Sending password reset email using Firebase Auth
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reset link sent to $email")),
      );

      // Redirecting to the WelcomeView after the link is sent
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeView()),
        (route) => false, // Removes all previous routes
      );
    } catch (e) {
      print("Error sending reset link: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send reset link: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              Text(
                "Reset Password",
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 15),
              Text(
                "Please enter your email to receive a\n reset link to create a new password via email",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 60),
              RoundTextfield(
                hintText: "Your Email",
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: sendResetLink,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                ),
                child: const Text(
                  "Send Reset Link",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
