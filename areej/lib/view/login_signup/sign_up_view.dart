import 'package:flutter/material.dart';
import 'package:areej/providers/sign_up_provider.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_button.dart';
import 'package:areej/common_widget/round_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:areej/view/on_boarding/on_boarding_view.dart';
import 'package:areej/view/login_signup/login_view.dart';

class SignUpView extends ConsumerWidget {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtMobile = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtAddress = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 64),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Add your details to sign up",
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 25),

                // Name field
                RoundTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  hintText: "Name",
                  controller: txtName,
                ),
                const SizedBox(height: 25),

                // Email field
                RoundTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    String emailPattern =
                        r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$';
                    RegExp regExp = RegExp(emailPattern);
                    if (!regExp.hasMatch(value)) {
                      return 'Please Enter a valid Email';
                    }
                    return null;
                  },
                  hintText: "Your Email",
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 25),

                // Mobile field
                RoundTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Mobile Number';
                    }
                    if (value.length < 10) {
                      return 'Please Enter a valid Mobile Number';
                    }
                    return null;
                  },
                  hintText: "Mobile No",
                  controller: txtMobile,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 25),

                // Address field
                RoundTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Address';
                    }
                    return null;
                  },
                  hintText: "Address",
                  controller: txtAddress,
                ),
                const SizedBox(height: 25),

                // Password field
                RoundTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  hintText: "Password",
                  controller: txtPassword,
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                // Confirm Password field
                RoundTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Confirm Password';
                    }
                    if (value != txtPassword.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  hintText: "Confirm Password",
                  controller: txtConfirmPassword,
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                signUpState.isLoading
                    ? const CircularProgressIndicator()
                    : RoundButton(
                        title: "Sign Up",
                        onPressed: () async {
                          if (_formkey.currentState?.validate() ?? false) {
                            final signUpProviderNotifier =
                                ref.read(signUpProvider.notifier);

                            String email = txtEmail.text.trim();
                            String password = txtPassword.text.trim();
                            String name = txtName.text.trim();
                            String mobile = txtMobile.text.trim();
                            String address = txtAddress.text.trim();

                            bool success = await signUpProviderNotifier.signUp(
                              email: email,
                              password: password,
                              name: name,
                              mobile: mobile,
                              address: address,
                            );

                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OnBoardingView(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Email is already taken. Please try again.",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                const SizedBox(height: 25),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account? ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: TColor.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
