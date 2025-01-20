import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/user.dart';
import 'AddUser.dart';
import 'UserDetails.dart';
import 'EditUser.dart';
import '/services/firebase_auth_implementation/firebase_auth_service.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _authService = FirebaseAuthService();
  late CollectionReference usersCollection;
  List<DocumentSnapshot> _users = [];
  bool _isLoading = true;
  String _sortOrder = "Ascending";

  @override
  void initState() {
    super.initState();
    usersCollection = _firestore.collection('users');
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final querySnapshot = await usersCollection.get();
      setState(() {
        _users = querySnapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching users: $e")),
      );
    }
  }

  void _deleteUser(String userId) async {
    try {
      await usersCollection.doc(userId).delete();
      _fetchUsers();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting user: $e")),
      );
    }
  }

  void _navigateToAddUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUser(
          onAddUser: (User user) async {
            try {
              final signUpResult =
                  await _authService.signUpWithEmailAndPassword(
                email: user.email,
                password: user.password,
                role: user.role,
                name: user.name,
                mobile: user.mobile,
                address: user.address,
              );

              if (signUpResult != null) {
                _fetchUsers();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User added successfully')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error during sign-up')),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error adding user: $e")),
              );
            }
          },
        ),
      ),
    );
  }

  void _navigateToEditUser(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUser(
          user: user,
          onUserUpdated: (updatedUser) {
            _fetchUsers();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    List<DocumentSnapshot> sortedUsers = [..._users];
    if (_sortOrder == "Ascending") {
      sortedUsers.sort((a, b) =>
          (a['name'] ?? '').toString().compareTo((b['name'] ?? '').toString()));
    } else {
      sortedUsers.sort((a, b) =>
          (b['name'] ?? '').toString().compareTo((a['name'] ?? '').toString()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        title: const Text('Users List',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          
          DropdownButton<String>(
            dropdownColor: Colors.white,
            value: _sortOrder,
            onChanged: (newValue) {
              setState(() => _sortOrder = newValue!);
            },
            items: const [
              DropdownMenuItem(
                value: "Ascending",
                child: Text("Sort A-Z"),
              ),
              DropdownMenuItem(
                value: "Descending",
                child: Text("Sort Z-A"),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddUser,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : sortedUsers.isEmpty
              ? const Center(
                  child: Text(
                    "No users found.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: sortedUsers.length,
                  itemBuilder: (context, index) {
                    final userDoc = sortedUsers[index];

                    if (!userDoc.exists || userDoc.data() == null) {
                      return Container();
                    }

                    final user = User.fromDocument(userDoc);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text(user.name.isNotEmpty ? user.name[0] : "?"),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _navigateToEditUser(user),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteUser(userDoc.id),
                          ),
                        ],
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
