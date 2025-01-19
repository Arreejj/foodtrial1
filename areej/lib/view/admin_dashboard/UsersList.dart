import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/user.dart';
import 'AddUser.dart';
import 'UserDetails.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference usersCollection;
  List<DocumentSnapshot> _users = [];

  @override
  void initState() {
    super.initState();
    usersCollection = _firestore.collection('users');
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final querySnapshot = await usersCollection.get();
    setState(() {
      _users = querySnapshot.docs;
    });
  }

  void _deleteUser(String userId) async {
    await usersCollection.doc(userId).delete();
    _fetchUsers(); // Refresh the list after deleting
  }

  void _navigateToAddUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUser(
          onAddUser: (User user) async {
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
            ); // Refresh the list after adding
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
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = User.fromDocument(_users[index]);
          return ListTile(
            leading: CircleAvatar(
              child: Text(user.name[0]),
            ),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteUser(_users[index].id),
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
