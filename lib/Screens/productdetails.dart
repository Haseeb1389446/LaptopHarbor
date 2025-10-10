import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final Map<String, dynamic>? productData;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.productData,
  });

  @override
  Widget build(BuildContext context) {
    // agar productData null hai to Firestore se fetch kare
    final Stream<DocumentSnapshot> productStream =
        FirebaseFirestore.instance.collection('products').doc(productId).snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data?.data() as Map<String, dynamic>? ?? productData ?? {};

          if (data.isEmpty) {
            return const Center(child: Text("Product not found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/products/${data['image']}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
                const SizedBox(height: 16),
                Text(
                  data['name'] ?? "No name",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Rs. ${data['price'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 18, color: Colors.green)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text("${data['rating'] ?? 'N/A'}"),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  data['description'] ?? "No description available.",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
