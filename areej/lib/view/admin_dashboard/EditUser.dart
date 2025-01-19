import 'package:flutter/material.dart';
import '/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUser extends StatefulWidget {
  final User user;
  final Function(User) onUserUpdated;

  const EditUser({super.key, required this.user, required this.onUserUpdated});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController addressController;
  late TextEditingController passwordController;
  late String role;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    mobileController = TextEditingController(text: user.mobile);
    addressController = TextEditingController(text: user.address);
    passwordController = TextEditingController(text: user.password);
    role = user.role;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedUser = User(
        id: widget.user.id,
        name: nameController.text,
        email: emailController.text,
        mobile: mobileController.text,
        address: addressController.text,
        password: passwordController.text,
        role: role,
        joinDate: widget.user.joinDate,
        ordersCount: widget.user.ordersCount,
      );

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.id)
            .update(updatedUser.toMap());

        widget.onUserUpdated(updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating user: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        title: const Text('Edit User',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter an email' : null,
              ),
              TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: 'Mobile'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a mobile' : null,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter an address' : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a password' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: role,
                decoration: const InputDecoration(labelText: 'Role'),
                onChanged: (newRole) => setState(() {
                  role = newRole!;
                }),
                items: ['user', 'admin', 'owner']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateUser,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6F00),
                foregroundColor: Colors.white),
                child: const Text('Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
