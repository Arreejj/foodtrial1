import 'package:flutter/material.dart';
import 'Category.dart';

class Products extends StatefulWidget {
  final List<String> categories; // Pass categories from the AddCategoryPage

  const Products({super.key, required this.categories});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  String? _selectedCategory;
  final List<Map<String, dynamic>> _foodItems = []; // Store food items locally for now.

  void _addFoodItem() {
    String foodName = _foodNameController.text.trim();
    String foodPrice = _foodPriceController.text.trim();
    String? category = _selectedCategory;

    if (foodName.isNotEmpty && foodPrice.isNotEmpty && category != null) {
      setState(() {
        _foodItems.add({
          'name': foodName,
          'price': double.tryParse(foodPrice) ?? 0.0,
          'category': category,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Food item '$foodName' added under '$category'!")),
      );
      _foodNameController.clear();
      _foodPriceController.clear();
      _selectedCategory = null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields.")),
      );
    }
  }

  void _deleteFoodItem(int index) {
    String removedFoodName = _foodItems[index]['name'];
    setState(() {
      _foodItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Food item '$removedFoodName' removed successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food Items"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Food Item:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _foodNameController,
              decoration: const InputDecoration(
                hintText: "Enter food name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _foodPriceController,
              decoration: const InputDecoration(
                hintText: "Enter food price",
                border: OutlineInputBorder(),
                prefixText: "\$ ",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: widget.categories
                  .map((category) =>
                      DropdownMenuItem(value: category, child: Text(category)))
                  .toList(),
              decoration: const InputDecoration(
                hintText: "Select Category",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addFoodItem,
              child: const Text("Add Food Item"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Current Food Items:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _foodItems.isEmpty
                  ? const Center(
                      child: Text(
                        "No food items added yet.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _foodItems.length,
                      itemBuilder: (context, index) {
                        final item = _foodItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(item['name']),
                            subtitle: Text(
                                "Price: \$${item['price'].toStringAsFixed(2)} | Category: ${item['category']}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteFoodItem(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
