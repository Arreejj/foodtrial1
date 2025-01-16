import 'package:flutter/material.dart';

class RoundTitleTextfield extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const RoundTitleTextfield({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 20),
          child: Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
            ),
          ),
        ),
      ],
    );
  }
}
