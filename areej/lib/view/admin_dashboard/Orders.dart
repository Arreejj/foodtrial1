import 'package:flutter/material.dart';
import 'package:areej/view/admin_dashboard/OrderDetail.dart'; 
import 'package:areej/model/Order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  
  final List<Order> orders = [
    Order(
      id: '1',
      userId: '1',
      items: [
        OrderItem(itemId: '1', itemName: 'Burger', quantity: 2, price: 5.99),
        OrderItem(itemId: '2', itemName: 'Fries', quantity: 1, price: 2.49),
      ],
      totalPrice: 14.47,
      status: 'Delivered',
      dateCreated: DateTime(2023, 01, 15),
    ),
    Order(
      id: '2',
      userId: '2',
      items: [
        OrderItem(itemId: '3', itemName: 'Pizza', quantity: 1, price: 8.99),
        OrderItem(itemId: '4', itemName: 'Coke', quantity: 2, price: 1.99),
      ],
      totalPrice: 12.97,
      status: 'Pending',
      dateCreated: DateTime(2023, 02, 05),
    ),
 
  ];

 
  void _removeOrder(String orderId) {
    setState(() {
      orders.removeWhere((order) => order.id == orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        title: const Text('My Orders',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Order #${order.id}'),
            subtitle: Text('Status: ${order.status}'),
            trailing: Text('\$${order.totalPrice.toStringAsFixed(2)}'),
            onTap: () {
              // Pass the _removeOrder function to the OrderDetail screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetail(
                    order: order,
                    onCancelOrder: _removeOrder,  
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
