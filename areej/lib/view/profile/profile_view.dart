import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_button.dart';
import 'package:areej/common_widget/round_title_textfield.dart';

class ProfileView extends StatefulWidget {
  final String userId; // Pass user ID to fetch data
  const ProfileView({super.key, required this.userId});

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

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Fetch user data from Firestore
  }

  Future<void> _loadUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          txtName.text = data['name'] ?? '';
          txtEmail.text = data['email'] ?? '';
          txtMobile.text = data['mobile'] ?? '';
          txtAddress.text = data['address'] ?? '';
          txtPassword.text = data['password'] ?? ''; // For demo purposes
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading data: $e")),
      );
    }
  }

  Future<void> _saveProfile() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'name': txtName.text,
        'email': txtEmail.text,
        'mobile': txtMobile.text,
        'address': txtAddress.text,
        'password': txtPassword.text, // Save password only if needed
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      // Delete the user data from Firestore
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).delete();
      
      // Delete the user's Firebase Authentication account
      User? user = FirebaseAuth.instance.currentUser;
      await user?.delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deleted successfully!')),
      );

      // After deletion, navigate to the login or welcome screen
      Navigator.pushReplacementNamed(context, '/login'); // Adjust route as needed
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting account: $e")),
      );
    }
  }

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
              _buildProfileImage(media),
              _buildEditProfileButton(),
              const SizedBox(height: 20),
              _buildTextField("Name", "Enter Name", txtName),
              _buildTextField("Email", "Enter Email", txtEmail, keyboardType: TextInputType.emailAddress),
              _buildTextField("Mobile No", "Enter Mobile No", txtMobile, keyboardType: TextInputType.phone),
              _buildTextField("Address", "Enter Address", txtAddress),
              const SizedBox(height: 20),
              _buildSaveButton(),
              const SizedBox(height: 20),
              _buildDeleteAccountButton(),  // Added Delete Account Button
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RoundButton(
        title: "Save",
        onPressed: _saveProfile,
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RoundButton(
        title: "Delete Account",
        onPressed: _deleteAccount,
       
      ),
    );
  }
}
