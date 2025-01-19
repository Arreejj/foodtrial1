import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditRestaurantPage extends StatefulWidget {
  final String restaurantId;  // Added restaurantId to uniquely identify the restaurant

  const EditRestaurantPage({
    super.key,
    required this.restaurantId, // Pass the restaurantId for updating the data
  });

  @override
  _EditRestaurantPageState createState() => _EditRestaurantPageState();
}

class _EditRestaurantPageState extends State<EditRestaurantPage> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _cuisineController;
  String _selectedOwnerId = '';
  List<Map<String, dynamic>> owners = []; // List to hold owners' data

  @override
  void initState() {
    super.initState();
    _fetchRestaurantData();
    _fetchOwners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _cuisineController.dispose();
    super.dispose();
  }

  Future<void> _fetchRestaurantData() async {
    try {
      DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.restaurantId) // Fetch the restaurant using the provided ID
          .get();

      if (restaurantSnapshot.exists) {
        var data = restaurantSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _nameController = TextEditingController(text: data['name']);
          _locationController = TextEditingController(text: data['location']);
          _cuisineController = TextEditingController(text: data['cuisine']);
          _selectedOwnerId = data['ownerId']; // Set the selected owner ID
        });
      } else {
        print("Restaurant not found.");
      }
    } catch (e) {
      print("Error fetching restaurant data: $e");
    }
  }

  Future<void> _fetchOwners() async {
    try {
      QuerySnapshot ownerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'owner') // Filter owners by role
          .get();

      if (ownerSnapshot.docs.isNotEmpty) {
        setState(() {
          owners = ownerSnapshot.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'name': data['name'] ?? 'Unknown Owner',
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

  Future<void> _saveChanges() async {
    try {
      await FirebaseFirestore.instance.collection('restaurants').doc(widget.restaurantId).update({
        'name': _nameController.text,
        'location': _locationController.text,
        'cuisine': _cuisineController.text,
        'ownerId': _selectedOwnerId, // Update the selected owner
      });
      Navigator.pop(context, 'Restaurant updated successfully');
      
    } catch (e) {
      print("Error updating restaurant: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Restaurant Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cuisineController,
              decoration: const InputDecoration(
                labelText: 'Cuisine',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>( 
              value: _selectedOwnerId.isEmpty ? null : _selectedOwnerId,
              hint: const Text('Select Restaurant Owner'),
              items: owners.map((owner) {
                return DropdownMenuItem<String>(
                  value: owner['id'],
                  child: Text(owner['name']),
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
                if (_nameController.text.isNotEmpty && 
                    _locationController.text.isNotEmpty && 
                    _cuisineController.text.isNotEmpty &&
                    _selectedOwnerId.isNotEmpty) {
                  _saveChanges();
                } else {
                  print("Please fill all fields.");
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
