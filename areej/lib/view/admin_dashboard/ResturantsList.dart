import 'package:areej/view/admin_dashboard/AddRestaurant.dart';
import 'package:areej/view/admin_dashboard/EditRestaurantPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({super.key});

  @override
  _RestaurantsListState createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  late List<String> _locations;
  late List<String> _cuisines;
  String? _selectedLocation;
  String? _selectedCuisine;
  String _searchQuery = '';
  List<DocumentSnapshot> _restaurants = [];
  List<DocumentSnapshot> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _locations = ['All'];
    _cuisines = ['All'];
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .get();

      setState(() {
        _restaurants = snapshot.docs;
        _filteredRestaurants = List.from(_restaurants);
      });

      // Extract locations and cuisines
      _locations = ['All'];
      _cuisines = ['All'];
      for (var restaurant in _restaurants) {
        var data = restaurant.data() as Map<String, dynamic>;
        if (data['location'] != null && !_locations.contains(data['location'])) {
          _locations.add(data['location']);
        }
        if (data['cuisine'] != null && !_cuisines.contains(data['cuisine'])) {
          _cuisines.add(data['cuisine']);
        }
      }
    } catch (e) {
      print("Error fetching restaurants: $e");
    }
  }

  // Apply filters based on location, cuisine, and search query
  void _applyFilters() {
    setState(() {
      _filteredRestaurants = _restaurants.where((restaurant) {
        final data = restaurant.data() as Map<String, dynamic>;

        final matchesLocation = _selectedLocation == 'All' ||
            data['location'] == _selectedLocation;
        final matchesCuisine = _selectedCuisine == 'All' ||
            data['cuisine'] == _selectedCuisine;
        final matchesSearchQuery = data['name'] != null &&
            data['name']!.toLowerCase().contains(_searchQuery.toLowerCase());

        return matchesLocation && matchesCuisine && matchesSearchQuery;
      }).toList();
    });
  }

  // Handle location filter change
  void _filterByLocation(String? location) {
    setState(() {
      _selectedLocation = location;
    });
    _applyFilters();
  }

  // Handle cuisine filter change
  void _filterByCuisine(String? cuisine) {
    setState(() {
      _selectedCuisine = cuisine;
    });
    _applyFilters();
  }

  // Update search query and apply filters
  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  // Delete restaurant from Firestore
  Future<void> _deleteRestaurant(String restaurantId) async {
    try {
      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantId)
          .delete();
      _fetchRestaurants(); // Re-fetch the list after deletion
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restaurant deleted successfully!')),
      );
    } catch (e) {
      print("Error deleting restaurant: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        title: const Text('Restaurants List',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
  // Navigate to AddRestaurantPage and wait for the result
  final newRestaurant = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddRestaurant(),
    ),
  );

  if (newRestaurant != null) {
    // Fetch the updated list of restaurants from Firestore
    await _fetchRestaurants();

    // Show the SnackBar after the list is refreshed
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restaurant added successfully!')),
    );
  }
}
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: _updateSearchQuery,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Filter by Location:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedLocation,
                  items: _locations
                      .map((location) => DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          ))
                      .toList(),
                  onChanged: _filterByLocation,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Filter by Cuisine:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedCuisine,
                  items: _cuisines
                      .map((cuisine) => DropdownMenuItem<String>(
                            value: cuisine,
                            child: Text(cuisine),
                          ))
                      .toList(),
                  onChanged: _filterByCuisine,
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredRestaurants.isEmpty
                ? const Center(
                    child: Text(
                      'No restaurants found.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = _filteredRestaurants[index];
                      final data = restaurant.data() as Map<String, dynamic>;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text(
                              data['name']?.isNotEmpty ?? false
                                  ? data['name']![0]
                                  : 'N',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(data['name'] ?? 'Unknown'),
                          subtitle: Text(
                            'Location: ${data['location'] ?? 'Unknown'}\nCuisine: ${data['cuisine'] ?? 'Unknown'}',
                          ),
                          trailing: PopupMenuButton(
                            onSelected: (value) async {
                              if (value == 'edit') {
                                final updatedRestaurant =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditRestaurantPage(
                                      restaurantId: restaurant.id, // Pass the restaurant ID
                                    ),
                                  ),
                                );

                                if (updatedRestaurant != null) {
                                  setState(() {
                                    _fetchRestaurants();  // Refresh the list after update
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Restaurant updated successfully!')),
                                  );
                                }
                              } else if (value == 'delete') {
                                await _deleteRestaurant(restaurant.id); 
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

