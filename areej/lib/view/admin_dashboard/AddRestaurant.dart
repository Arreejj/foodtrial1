import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({super.key});

  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();
  String _selectedOwnerId = '';
  List<Map<String, dynamic>> owners = []; // List to hold owners' data

  @override
  void initState() {
    super.initState();
    _fetchOwners(); // Fetch owners when the widget is initialized
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _cuisineController.dispose();
    super.dispose();
  }

  Future<void> _fetchOwners() async {
    try {
      QuerySnapshot ownerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'owner') // Filter owners by role
          .get();

      if (ownerSnapshot.docs.isNotEmpty) {
        // Map the snapshot to a list of owners
        setState(() {
          owners = ownerSnapshot.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id, // Document ID
              'name': data['name'] ?? 'Unknown Owner', // Owner's name
            };
          }).toList();
        });
      } else {
        print("No owners found.");
      }
    } catch (e) {
      print("Error fetching owners: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Restaurant Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the restaurant name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
                const SizedBox(height: 16),
              TextFormField(
                controller: _cuisineController,
                decoration: const InputDecoration(
                  labelText: 'Cuisine',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cuisine';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedOwnerId.isEmpty ? null : _selectedOwnerId,
                hint: const Text('Select Restaurant Owner'),
                items: owners.map((owner) {
                  return DropdownMenuItem<String>(
                    value: owner['id'], // Set the owner id as the value
                    child: Text(owner['name']), // Display the owner's name
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedOwnerId = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Owner',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedOwnerId.isNotEmpty) {
                    // Add restaurant to Firestore with the selected owner
                    FirebaseFirestore.instance.collection('restaurants').add({
                      'name': _nameController.text,
                      'location': _locationController.text,
                      'cuisine': _cuisineController.text,
                      'ownerId': _selectedOwnerId, // Associate the restaurant with the selected owner
                    }).then((value) {
                      Navigator.pop(context); // Close the screen after adding the restaurant
                    }).catchError((error) {
                      print("Failed to add restaurant: $error");
                    });
                  } else {
                    print("Please select an owner.");
                  }
                },
                child: const Text('Add Restaurant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
