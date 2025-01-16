import 'package:areej/view/login_signup/new_password_view.dart';
import 'package:flutter/material.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_button.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController txtOTP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              
              Text(
                "We have sent OTP to your Email",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
             
              Text(
                "Please check your email areej********miuegypt.edu.eg \ncontinue to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
             
              TextField(
                controller: txtOTP,
                maxLength: 4, 
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8.0,
                  color: TColor.primaryText,
                ),
                decoration: InputDecoration(
                  counterText: "", // Removes the counter below TextField
                  hintText: "Enter OTP",
                  hintStyle: TextStyle(color: TColor.secondaryText),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: TColor.secondaryText.withOpacity(0.5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: TColor.secondaryText.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: TColor.primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            
              RoundButton(
                title: "Next",
                onPressed: () {
                  if (txtOTP.text.length == 4) {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewPasswordView(
                          nObj: {},
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter a valid 4-digit OTP"),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't Receive? ",
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPasswordView(
                            nObj: {},
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Click here",
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
    );
  }
}
