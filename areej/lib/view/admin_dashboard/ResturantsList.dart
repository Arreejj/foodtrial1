import 'package:areej/view/admin_dashboard/AddRestaurant.dart';
import 'package:areej/view/admin_dashboard/EditRestaurantPage.dart';
import 'package:flutter/material.dart';


class RestaurantsList extends StatefulWidget {
  const RestaurantsList ({super.key});

  @override
  _RestaurantsListState createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList > {
  // Dummy data for restaurants
  final List<Map<String, String>> _restaurants = [
    {'name': 'Spontini', 'location': 'Cairo', 'status': 'Open'},
    {'name': 'Chinatown', 'location': 'Alexandria', 'status': 'Closed'},
    {'name': 'Garnell', 'location': 'Giza', 'status': 'Open'},
    {'name': 'TacoBell', 'location': 'Nasr City', 'status': 'Open'},
    {'name': 'GreatSteak', 'location': 'Cairo', 'status': 'Closed'},
  ];

  
  late List<String> _locations;

  
  String? _selectedLocation;
  String _searchQuery = '';

 
  List<Map<String, String>> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _locations = _restaurants
        .map((restaurant) => restaurant['location']!)
        .toSet()
        .toList();
    _locations.insert(0, 'All'); 
    _selectedLocation = 'All';
    _filteredRestaurants = List.from(_restaurants); 
  }

  
  void _applyFilters() {
    setState(() {
      _filteredRestaurants = _restaurants.where((restaurant) {
        final matchesLocation = _selectedLocation == 'All' ||
            restaurant['location'] == _selectedLocation;
        final matchesSearchQuery = restaurant['name']!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        return matchesLocation && matchesSearchQuery;
      }).toList();
    });
  }

 
  void _filterByLocation(String? location) {
    setState(() {
      _selectedLocation = location;
    });
    _applyFilters();
  }

 
  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants List'),
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
      setState(() {
        _restaurants.add(newRestaurant);
        _applyFilters(); 
      });

      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restaurant added successfully!')),
      );
    }
  },
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
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text(
                              restaurant['name']![0], 
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(restaurant['name']!),
                          subtitle: Text(
                            'Location: ${restaurant['location']!}\nStatus: ${restaurant['status']!}',
                          ),
                          trailing: PopupMenuButton(
                            onSelected: (value) async {
  if (value == 'edit') {
    final updatedRestaurant = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRestaurantPage(
          name: restaurant['name']!,
          location: restaurant['location']!,
          status: restaurant['status']!,
        ),
      ),
    );

    if (updatedRestaurant != null) {
      setState(() {
        _restaurants[index] = updatedRestaurant;
        _applyFilters(); 
      });
    }
  } else if (value == 'delete') {
     setState(() {
    _restaurants.removeAt(index);
     _applyFilters();
 });
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
                          onTap: () {
                            // Navigate to restaurant details page (to be implemented)
                          },
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
