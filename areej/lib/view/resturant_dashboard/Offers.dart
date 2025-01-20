import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final TextEditingController _offerTitleController = TextEditingController();
  final TextEditingController _offerDescriptionController =
      TextEditingController();
  final TextEditingController _offerDiscountController =
      TextEditingController();

  final List<Map<String, dynamic>> _offers = []; 

  void _addOffer() {
    String title = _offerTitleController.text.trim();
    String description = _offerDescriptionController.text.trim();
    String discount = _offerDiscountController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty && discount.isNotEmpty) {
      setState(() {
        _offers.add({
          'title': title,
          'description': description,
          'discount': double.tryParse(discount) ?? 0.0,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Offer '$title' added successfully!")),
      );

      _offerTitleController.clear();
      _offerDescriptionController.clear();
      _offerDiscountController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
    }
  }

  void _deleteOffer(int index) {
    String removedOfferTitle = _offers[index]['title'];
    setState(() {
      _offers.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Offer '$removedOfferTitle' removed successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        title: const Text("Manage Offers"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Offer:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _offerTitleController,
              decoration: const InputDecoration(
                hintText: "Offer Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _offerDescriptionController,
              decoration: const InputDecoration(
                hintText: "Offer Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _offerDiscountController,
              decoration: const InputDecoration(
                hintText: "Discount (%)",
                border: OutlineInputBorder(),
                suffixText: "%",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addOffer,
              child: const Text("Add Offer"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Current Offers:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _offers.isEmpty
                  ? const Center(
                      child: Text(
                        "No offers added yet.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _offers.length,
                      itemBuilder: (context, index) {
                        final offer = _offers[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(offer['title']),
                            subtitle: Text(
                              "${offer['description']}\nDiscount: ${offer['discount']}%",
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteOffer(index),
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
