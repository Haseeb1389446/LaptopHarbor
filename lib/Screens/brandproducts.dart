import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  final String brandName;
  const BrandProductsScreen({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    // Example: Filtered brand products (you can fetch dynamically later)
    final List<Map<String, dynamic>> products = [
      {
        "title": "MacBook Air M2",
        "image": "assets/products/lp1.png",
        "price": 1299.0,
        "brand": "Apple"
      },
      {
        "title": "MacBook Pro 14\"",
        "image": "assets/products/lp2.png",
        "price": 1799.0,
        "brand": "Apple"
      },
      {
        "title": "Dell Inspiron 15",
        "image": "assets/products/lp3.png",
        "price": 899.0,
        "brand": "Dell"
      },
      {
        "title": "Dell XPS 13",
        "image": "assets/products/lp4.png",
        "price": 1399.0,
        "brand": "Dell"
      },
      {
        "title": "HP Pavilion",
        "image": "assets/products/lp5.png",
        "price": 799.0,
        "brand": "HP"
      },
    ];

    // Filter products by brand name
    final filteredProducts = products
        .where((item) => item["brand"]!.toLowerCase() == brandName.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF062245),
        title: Text(
          "$brandName Laptops",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: filteredProducts.isEmpty
          ? const Center(
              child: Text(
                "No products found for this brand.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return _productCard(product);
                },
              ),
            ),
    );
  }

  Widget _productCard(Map<String, dynamic> product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to product detail page
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  product["image"],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 40),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product["title"],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF062245),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "\$${product["price"].toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Color(0xFFF05105),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
