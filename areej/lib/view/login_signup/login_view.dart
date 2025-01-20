import 'package:areej/view/home/home_view.dart';
import 'package:areej/view/login_signup/reset_password_view.dart';
import 'package:areej/view/admin_dashboard/AdminDashboard.dart';
import 'package:areej/view/resturant_dashboard/ResturantDashboard.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_button.dart';
import 'package:areej/common_widget/round_textfield.dart';
import 'package:flutter/material.dart';
import 'package:areej/services/firebase_auth_implementation/firebase_auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final FirebaseAuthService authService = FirebaseAuthService();

  bool isLoading = false;

  void _handleLogin() async {
    String email = txtEmail.text.trim();
    String password = txtPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both email and password.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Sign in the user and fetch their data
      final userData = await authService.signInWithEmailAndPassword(email, password);

      if (userData != null) {
        String role = userData['role'] ?? 'user';

        // Redirect based on the user's role
        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
          );
        } else if (role == 'owner') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResturantDashboard()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
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
                "Login",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "Add your details to login",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),
              RoundTextfield(
                hintText: "Your Email",
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 25),
              RoundTextfield(
                hintText: "Password",
                controller: txtPassword,
                obscureText: true,
              ),
              const SizedBox(height: 25),
              isLoading
                  ? const CircularProgressIndicator()
                  : RoundButton(
                      title: "Login",
                      onPressed: _handleLogin,
                    ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordView()),
                  );
                },
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
