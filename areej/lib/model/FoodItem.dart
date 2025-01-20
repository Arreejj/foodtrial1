import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItem {
  final String id;
  final String name;
  final double price;
  final String category;
  final String description;
  final String imageUrl;  
  final double rate;
  final String restaurantId;  

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.rate,
    required this.restaurantId,  
  });

  // Convert the food item to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'rate': rate,
      'restaurant_id': restaurantId,
      'created_at': FieldValue.serverTimestamp(),
    };
  }

  // Convert a Firestore document into a food item object
  factory FoodItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FoodItem(
      id: doc.id,
      name: data['name'],
      price: data['price'],
      category: data['category'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      rate: data['rate'],
      restaurantId: data['restaurant_id'],
    );
  }
}
