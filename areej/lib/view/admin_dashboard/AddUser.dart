import 'package:flutter/material.dart';
import '/model/user.dart';

class AddUser extends StatelessWidget {
  final Function(User) onAddUser;

  const AddUser({super.key, required this.onAddUser});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();
    final addressController = TextEditingController();
    final passwordController = TextEditingController();
    String userRole = 'user'; 

    return Scaffold(
      appBar: AppBar(title: const Text('Add New User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              
             
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  final emailPattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  final regExp = RegExp(emailPattern);
                  if (!regExp.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              
              
              TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: 'Mobile'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a mobile number';
                  }
                  if (value.length < 10) {
                    return 'Mobile number must be at least 10 digits';
                  }
                  return null;
                },
              ),
              
             
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              
            
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              
           
              DropdownButtonFormField<String>(
                value: userRole,
                decoration: const InputDecoration(labelText: 'User Role'),
                items: <String>['user', 'owner', 'admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    userRole = newValue;
                  }
                },
              ),

              const SizedBox(height: 16),
          
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final newUser = User(
                      name: nameController.text,
                      email: emailController.text,
                      mobile: mobileController.text,
                      address: addressController.text,
                      password: passwordController.text,
                      role: userRole,
                      joinDate: DateTime.now(),
                    );
                    onAddUser(newUser); // Call the callback function to add the user
                    Navigator.pop(context); // Close the AddUser page
                  }
                },
                child: const Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
