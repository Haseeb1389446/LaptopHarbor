import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // final Map<String, dynamic> product;

  // const ProductDetailScreen({super.key, required this.product});
  const ProductDetailScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF062245),
        // title: Text(product["title"]),
        title: Text("hello"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.favorite_border, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Product Image ---
            Container(
              width: double.infinity,
              height: 260,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                // child: Image.asset(
                //   product["image"],
                //   fit: BoxFit.contain,
                //   errorBuilder: (_, __, ___) => const Center(
                //     child: Icon(Icons.image, size: 60),
                //   ),
                // ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Product Info ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              // child: Text(
              //   product["title"],
              //   style: const TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xFF062245),
              //   ),
              // ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            //   child: Text(
            //     "\$${product["price"].toStringAsFixed(2)}",
            //     style: const TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Color(0xFFF05105),
            //     ),
            //   ),
            // ),

            const Divider(thickness: 1),

            // --- Product Description ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                // product["description"] ??
                    "Experience high performance and sleek design with this laptop. Perfect for work, study, and entertainment with long battery life and stunning visuals.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- Buttons ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to Cart")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF062245),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text("Add to Cart"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to Wishlist")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF05105),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.favorite_border),
                      label: const Text("Wishlist"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
