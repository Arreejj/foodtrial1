import 'package:flutter/material.dart';
import 'package:areej/services/restaurant_service.dart'; // Import the RestaurantService

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
  String? _selectedImagePath; // Store the image path
  List<Map<String, dynamic>> owners = [];
  final RestaurantService _restaurantService = RestaurantService();

  @override
  void initState() {
    super.initState();
    _fetchOwners();
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
      List<Map<String, dynamic>> fetchedOwners =
          await _restaurantService.fetchOwners();
      setState(() {
        owners = fetchedOwners;
      });
    } catch (e) {
      print("Error fetching owners: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        title: const Text('Add Restaurant',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
              const SizedBox(height: 16),
              // Horizontal Image selection
              const Text('Select Restaurant Image'),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildImageOption('assets/img/res_1.png'),
                    _buildImageOption('assets/img/res_2.png'),
                    _buildImageOption('assets/img/res_3.png'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _selectedOwnerId.isNotEmpty &&
                      _selectedImagePath != null) {
                    try {
                      // Step 1: Add the restaurant
                      String restaurantId =
                          await _restaurantService.addRestaurant(
                        name: _nameController.text,
                        location: _locationController.text,
                        cuisine: _cuisineController.text,
                        ownerId: _selectedOwnerId,
                        imagePath: _selectedImagePath!, // Pass the image path
                      );

                      // Step 2: Update the owner's restaurantId
                      await _restaurantService.updateOwnerWithRestaurant(
                        _selectedOwnerId,
                        restaurantId,
                      );

                      // Navigate back or show success message
                      Navigator.pop(context);
                    } catch (e) {
                      print("Error adding restaurant and updating owner: $e");
                    }
                  } else {
                    print("Please select all fields.");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6F00),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add Restaurant'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display each image as an option
  Widget _buildImageOption(String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedImagePath = imagePath;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedImagePath == imagePath
                ? Colors.orange
                : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          imagePath,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
