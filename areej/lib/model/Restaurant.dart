class Restaurant {
  final String? id;
  final String name;
  final String location;
  final String cuisine;
  final String ownerId;

  Restaurant({
    this.id,
    required this.name,
    required this.location,
    required this.cuisine,
    required this.ownerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'cuisine':cuisine,
      'ownerId': ownerId,
    };
  }

  factory Restaurant.fromDocument(Map<String, dynamic> data, String id) {
    return Restaurant(
      id: id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      cuisine: data['cuisine']?? '',
      ownerId: data['ownerId'] ?? '',
    );
  }

  String? validateName() {
    if (name.isEmpty) {
      return "Please enter the restaurant name";
    }
    return null;
  }

  String? validateLocation() {
    if (location.isEmpty) {
      return "Please enter the restaurant location";
    }
    return null;
  }
  String? validatecuisine() {
    if (cuisine.isEmpty) {
      return "Please enter the restaurant cuisine";
    }
    return null;
  }
}
