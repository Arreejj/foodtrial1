import 'package:flutter/material.dart';

class EditRestaurantPage extends StatefulWidget {
  final String name;
  final String location;
  final String status;

  const EditRestaurantPage({
    super.key,
    required this.name,
    required this.location,
    required this.status,
  });

  @override
  _EditRestaurantPageState createState() => _EditRestaurantPageState();
}

class _EditRestaurantPageState extends State<EditRestaurantPage> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _locationController = TextEditingController(text: widget.location);
    _status = widget.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Restaurant Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _status,
              items: const [
                DropdownMenuItem(value: 'Open', child: Text('Open')),
                DropdownMenuItem(value: 'Closed', child: Text('Closed')),
              ],
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final updatedData = {
                  'name': _nameController.text,
                  'location': _locationController.text,
                  'status': _status,
                };
                Navigator.pop(context, updatedData);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
