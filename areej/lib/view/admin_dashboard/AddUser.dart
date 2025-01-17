// lib/screens/AddUser.dart
import 'package:flutter/material.dart';
import '/model/Userr.dart';


class AddUser extends StatefulWidget {
  final Function(User) onAddUser;

  const AddUser({super.key, required this.onAddUser});

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedType = 'user'; // Default type is 'user'
  int? _ordersCount;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();

      // Create a new User object
      final newUser = User(
        name: name,
        email: email,
        userType: _selectedType,
        joinDate: DateTime.now(), // Use current date as join date
        ordersCount: _selectedType == 'user' ? (_ordersCount ?? 0) : null,
      );

      // Add the user using the callback
      widget.onAddUser(newUser);

      // Navigate back to the UsersList
      Navigator.pop(context);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the email';
                  }
                  // Simple email validation
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // User Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'User Type'),
                items: <String>['user', 'employee']
                    .map((String type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type[0].toUpperCase() + type.substring(1)),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                    if (_selectedType == 'employee') {
                      _ordersCount = null; // Reset ordersCount for employees
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              // Orders Count Field (only visible for 'user' type)
              if (_selectedType == 'user')
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Orders Count'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _ordersCount = int.tryParse(value) ?? 0;
                    });
                  },
                  validator: (value) {
                    if (_selectedType == 'user') {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the orders count';
                      }
                      if (int.tryParse(value.trim()) == null) {
                        return 'Please enter a valid number';
                      }
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 24),
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
