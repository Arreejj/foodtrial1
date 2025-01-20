class Categories {
  final String? id;
  final String name;

  Categories ({
    this.id,
    required this.name,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  
  factory Categories .fromDocument(Map<String, dynamic> data, String id) {
    return Categories (
      id: id,
      name: data['name'] ?? '',
    );
  }

  
  String? validateName() {
    if (name.isEmpty) {
      return "Please enter the category name";
    }
    return null;
  }
}
