import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final Map<String, dynamic>? productData;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.productData,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> addToCollection(String type, Map<String, dynamic> product) async {
    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login first")),
      );
      return;
    }

    await _firestore.collection(type).add({
      'userid': user.uid,
      'productid': widget.productId,
      'name': product['name'],
      'price': product['price'],
      'image': product['image'],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product['name']} added to $type ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF062245),
        title: const Text("Product Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFFF05105)));
          }

          final data = snapshot.data?.data() as Map<String, dynamic>? ??
              widget.productData ??
              {};

          if (data.isEmpty) {
            return const Center(
                child: Text("Product not found",
                    style: TextStyle(
                        color: Color(0xFF062245),
                        fontWeight: FontWeight.bold,
                        fontSize: 18)));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🖼 Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/products/${data['image']}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 280,
                  ),
                ),
                const SizedBox(height: 20),

                /// 🧾 Product Info
                Text(
                  data['name'] ?? "No name",
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF062245)),
                ),
                const SizedBox(height: 8),
                Text(
                  "Rs. ${data['price'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF05105)),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 22),
                    const SizedBox(width: 4),
                    Text(
                      "${data['rating'] ?? 'N/A'} / 5",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  data['description'] ?? "No description available.",
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black87, height: 1.5),
                ),
                const SizedBox(height: 25),

                /// 🛒 Buttons (Cart & Wishlist)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => addToCollection('cart', {
                          'name': data['name'],
                          'price': data['price'],
                          'image': data['image'],
                        }),
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text("Add to Cart"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF05105),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => addToCollection('wishlist', {
                          'name': data['name'],
                          'price': data['price'],
                          'image': data['image'],
                        }),
                        icon: const Icon(Icons.favorite_border),
                        label: const Text("Wishlist"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF062245),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
