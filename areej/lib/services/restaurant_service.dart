import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all owners from Firestore
  Future<List<Map<String, dynamic>>> fetchOwners() async {
    try {
      QuerySnapshot ownerSnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'owner')
          .get();

      if (ownerSnapshot.docs.isNotEmpty) {
        return ownerSnapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id,
            'name': data['name'] ?? 'Unknown Owner',
          };
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching owners: $e");
      throw Exception("Failed to fetch owners");
    }
  }

  // Add a new restaurant to Firestore
  Future<String> addRestaurant({
    required String name,
    required String location,
    required String cuisine,
    required String ownerId,
    required String imagePath, // New parameter for image path
  }) async {
    try {
      DocumentReference restaurantRef =
          await _firestore.collection('restaurants').add({
        'name': name,
        'location': location,
        'cuisine': cuisine,
        'ownerId': ownerId,
        'imagePath': imagePath, // Save the image path to Firestore
      });
      return restaurantRef.id; // Return the newly created restaurant ID
    } catch (e) {
      print("Error adding restaurant: $e");
      throw Exception("Failed to add restaurant");
    }
  }

  // Update restaurant details
  Future<void> updateRestaurant({
    required String restaurantId,
    required String name,
    required String location,
    required String cuisine,
    required String ownerId,
    String? imagePath, // Optional image path
  }) async {
    try {
      await _firestore.collection('restaurants').doc(restaurantId).update({
        'name': name,
        'location': location,
        'cuisine': cuisine,
        'ownerId': ownerId, // Update the selected owner
        'imagePath': imagePath, // Update the image path if provided
      });
    } catch (e) {
      print("Error updating restaurant: $e");
      throw Exception("Failed to update restaurant");
    }
  }

  // Update the owner with the assigned restaurant ID
  Future<void> updateOwnerWithRestaurant(
      String ownerId, String restaurantId) async {
    try {
      await _firestore.collection('users').doc(ownerId).update({
        'restaurantId': restaurantId,
      });
    } catch (e) {
      print("Error updating owner: $e");
      throw Exception("Failed to update owner");
    }
  }
}
