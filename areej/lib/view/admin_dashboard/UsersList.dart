import 'package:flutter/material.dart';
import '/model/Userr.dart';
import 'UserDetails.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<User> users = [
    User(
      name: 'Reem Omar',
      email: 'reem@gmail.com',
      userType: 'employee',
      joinDate: DateTime(2023, 1, 15),
    ),
    User(
      name: 'Lama Ali',
      email: 'lama@exp.com',
      userType: 'user',
      ordersCount: 5 ,
      joinDate: DateTime(2022, 3, 10),
    ),
  
  ];

  
  void _deleteUser(String userId) {
    setState(() {
      users.removeWhere((user) => user.id == userId);
    });
  }

  
  void _addUser(String name, String email, String userType, DateTime joinDate) {
    final newUser = User(
      name: name,
      email: email,
      userType: userType,
      joinDate: joinDate,
    );

    setState(() {
      users.add(newUser); 
    });
  }

 
  void _showAddUserForm() {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    String userType = 'user'; 

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: userType,
                  decoration: const InputDecoration(labelText: 'User Type'),
                  items: ['user', 'employee'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        userType = value;
                      });
                    }
                  },
                ),
                
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  
                  _addUser(
                    nameController.text,
                    emailController.text,
                    userType,
                    DateTime.now(), 
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add User'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddUserForm, 
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user.name[0]),
            ),
            title: Text('${index + 1}. ${user.name}'),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete User'),
                    content: const Text('Are you sure you want to delete this user?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _deleteUser(user.id);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User deleted successfully')),
                          );
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
            onTap: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetails(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
