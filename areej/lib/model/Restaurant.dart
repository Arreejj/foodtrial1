class Restaurant {
  final String? id;
  final String name;
  final String location;
  final String cuisine;
  final String ownerId;
  final String imagePath; 

  Restaurant({
    this.id,
    required this.name,
    required this.location,
    required this.cuisine,
    required this.ownerId,
    required this.imagePath, 
  });

  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'cuisine': cuisine,
      'ownerId': ownerId,
      'imagePath': imagePath, 
    };
  }

  
  factory Restaurant.fromDocument(Map<String, dynamic> data, String id) {
    return Restaurant(
      id: id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      cuisine: data['cuisine'] ?? '',
      ownerId: data['ownerId'] ?? '',
      imagePath: data['imagePath'] ?? '', // Use imagePath field
    );
  }

  // Validation for name
  String? validateName() {
    if (name.isEmpty) {
      return "Please enter the restaurant name";
    }
    return null;
  }

  // Validation for location
  String? validateLocation() {
    if (location.isEmpty) {
      return "Please enter the restaurant location";
    }
    return null;
  }

  // Validation for cuisine
  String? validateCuisine() {
    if (cuisine.isEmpty) {
      return "Please enter the restaurant cuisine";
    }
    return null;
  }
}
