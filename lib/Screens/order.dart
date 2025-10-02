import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Orders Data
    final List<Map<String, dynamic>> orders = [
      {
        "orderId": "ORD12345",
        "product": "Dell Inspiron 15",
        "price": 1200,
        "status": "Delivered",
        "date": "25 Sept 2025"
      },
      {
        "orderId": "ORD98765",
        "product": "MacBook Pro 14",
        "price": 2500,
        "status": "Shipped",
        "date": "20 Sept 2025"
      },
      {
        "orderId": "ORD55555",
        "product": "HP Pavilion Gaming",
        "price": 1600,
        "status": "Processing",
        "date": "18 Sept 2025"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF062245),
        title: const Text("My Orders"),
        centerTitle: true,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          var order = orders[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(
                order["product"],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text("Order ID: ${order["orderId"]}",
                      style: const TextStyle(fontSize: 13)),
                  Text("Date: ${order["date"]}",
                      style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 5),
                  Text("Price: Rs. ${order["price"]}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text("Status: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      Text(
                        order["status"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: order["status"] == "Delivered"
                              ? Colors.green
                              : order["status"] == "Shipped"
                                  ? Colors.orange
                                  : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.black54),
              onTap: () {
                // ✅ Yahan pe Order Details Screen open kar sakte ho
              },
            ),
          );
        },
      ),
    );
  }
}
