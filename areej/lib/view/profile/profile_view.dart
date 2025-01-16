import 'dart:io';

import 'package:flutter/material.dart';
import 'package:areej/common_widget/round_button.dart';
import 'package:image_picker/image_picker.dart';

import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_title_textfield.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  int initialTab = 3;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildProfileImage(media),
              _buildEditProfileButton(),
              _buildGreetingText(),
              _buildSignOutButton(),
              const SizedBox(height: 20),
              _buildTextField("Name", "Enter Name", txtName),
              _buildTextField("Email", "Enter Email", txtEmail, keyboardType: TextInputType.emailAddress),
              _buildTextField("Mobile No", "Enter Mobile No", txtMobile, keyboardType: TextInputType.phone),
              _buildTextField("Address", "Enter Address", txtAddress),
              _buildTextField("Password", "* * * * * *", txtPassword, obscureText: true),
              _buildTextField("Confirm Password", "* * * * * *", txtConfirmPassword, obscureText: true),
              const SizedBox(height: 20),
              _buildSaveButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Header with Profile and Cart
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Profile",
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigate to orders if needed
            },
            icon: Image.asset(
              "assets/img/shopping_cart.png",
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }

  // Profile Image Widget
  Widget _buildProfileImage(Size media) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: TColor.placeholder,
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(File(image!.path), width: 100, height: 100, fit: BoxFit.cover),
            )
          : Icon(
              Icons.person,
              size: 65,
              color: TColor.secondaryText,
            ),
    );
  }

  // Edit Profile Button
  Widget _buildEditProfileButton() {
    return TextButton.icon(
      onPressed: () async {
        image = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      icon: Icon(
        Icons.edit,
        color: TColor.primary,
        size: 12,
      ),
      label: Text(
        "Edit Profile",
        style: TextStyle(color: TColor.primary, fontSize: 12),
      ),
    );
  }

  // Greeting Text
  Widget _buildGreetingText() {
    return Text(
      "Hi there Areej!",
      style: TextStyle(
        color: TColor.primaryText,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // Sign Out Button
  Widget _buildSignOutButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Sign Out",
        style: TextStyle(
          color: TColor.secondaryText,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Generalized TextField widget
  Widget _buildTextField(String title, String hintText, TextEditingController controller,
      {TextInputType? keyboardType, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: RoundTitleTextfield(
        title: title,
        hintText: hintText,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }

  // Save Button
  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RoundButton(title: "Save", onPressed: () {}),
    );
  }
}
