import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/user.dart';
import 'AddUser.dart';
import 'UserDetails.dart';
import 'EditUser.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference usersCollection;
  List<DocumentSnapshot> _users = [];
  bool _isLoading = true; 

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
              await usersCollection.add({
                'name': user.name,
                'email': user.email,
                'mobile': user.mobile,
                'address': user.address,
                'password': user.password,
                'userType': user.role,
                'joinDate': user.joinDate,
                'ordersCount': user.ordersCount,
              });
              _fetchUsers();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User added successfully')),
              );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        actions: [
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
          : _users.isEmpty
              ? const Center(
                  child: Text(
                    "No users found.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final userDoc = _users[index];

                    if (!userDoc.exists || userDoc.data() == null) {
                      return Container(); // Skip invalid documents
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
