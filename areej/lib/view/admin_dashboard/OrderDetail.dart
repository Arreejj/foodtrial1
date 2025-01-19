import 'package:flutter/material.dart';
import 'package:areej/model/Order.dart';  

class OrderDetail extends StatelessWidget {
  final Order order;
  final Function(String) onCancelOrder; 

  const OrderDetail({
    super.key, 
    required this.order,
    required this.onCancelOrder,  // Accept the cancellation function
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        title: const Text('Order Details',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Status: ${order.status}', style: const TextStyle(fontSize: 16)),
            Text('Date Created: ${order.dateCreated.toString()}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Items:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            for (var item in order.items)  // Loop through the order items
              Text('${item.itemName} x${item.quantity} - \$${(item.price * item.quantity).toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Total Price: \$${order.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            if (order.status == 'Pending')  // Show cancel button only if the order is pending
              ElevatedButton(
                onPressed: () {
                  // Cancel the order by calling the onCancelOrder function
                  onCancelOrder(order.id);  // Remove the order by its ID
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order has been cancelled.')));
                  Navigator.pop(context);  // Go back to the orders list
                },
                child: const Text('Cancel Order'),
              ),
          ],
        ),
      ),
    );
  }
}
