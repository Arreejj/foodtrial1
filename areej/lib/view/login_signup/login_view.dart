import 'package:areej/view/home/home_view.dart';
import 'package:areej/view/login_signup/sign_up_view.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_button.dart';
import 'package:areej/common_widget/round_textfield.dart';
import 'package:areej/common_widget/round_icon_button.dart';
import 'package:areej/view/login_signup/reset_password_view.dart';
import 'package:areej/view/admin_dashboard/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:areej/providers/sign_in_provider.dart';
import 'package:areej/user_auth/firebase_auth_implementation/firebase_auth_service.dart';

import '../resturant_dashboard/ResturantDashboard.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);

    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPassword = TextEditingController();

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
                    fontWeight: FontWeight.w800),
              ),
              Text(
                "Add your details to login",
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
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
              signInState.isLoading
                  ? const CircularProgressIndicator()
                  : RoundButton(
                      title: "Login",
                      onPressed: () async {
                        if (txtEmail.text.isNotEmpty &&
                            txtPassword.text.isNotEmpty) {
                          String email = txtEmail.text;
                          String password = txtPassword.text;

                          // Check for owner credentials
                          if (email == 'owner@gmail.com' &&
                              password == 'owner@123') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResturantDashboard(),
                              ),
                            );
                          }
                          // Check for admin credentials
                          else if (email == 'admin@gmail.com' &&
                              password == 'admin@123') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminDashboard(),
                              ),
                            );
                          } else {
                            final signInProviderNotifier =
                                ref.read(signInProvider.notifier);

                            // Proceed with regular user login
                            bool success = await signInProviderNotifier
                                .signIn(email, password);

                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeView(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      signInState.errorMessage.isEmpty
                                          ? 'Email or password wrong. Please try again.'
                                          : signInState.errorMessage),
                                ),
                              );
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please fill in both email and password."),
                            ),
                          );
                        }
                      },
                    ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordView(),
                    ),
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
              const SizedBox(height: 25),
              Text(
                "or Login With",
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              RoundIconButton(
                icon: "assets/img/facebook_logo.png",
                title: "Login with Facebook",
                color: const Color(0xff367FC0),
                onPressed: () {},
              ),
              const SizedBox(height: 25),
              RoundIconButton(
                icon: "assets/img/google_logo.png",
                title: "Login with Google",
                color: const Color(0xffDD4B39),
                onPressed: () async {
                  try {
                    final user = await FirebaseAuthService().signInWithGoogle();
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Google sign-in failed. Please try again.")),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account? ",
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpView()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: TColor.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
