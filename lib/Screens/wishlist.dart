import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Dummy wishlist items
  List<Map<String, dynamic>> wishlistItems = [
    {"title": "Dell XPS 13", "price": 2200, "image": "assets/products/lp1.png"},
    {"title": "MacBook Air", "price": 3200, "image": "assets/products/lp2.png"},
    {"title": "HP Omen 16", "price": 1800, "image": "assets/products/lp3.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF062245),
        title: const Text("My Wishlist"),
        centerTitle: true,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: wishlistItems.isEmpty
          ? const Center(
              child: Text(
                "Your Wishlist is Empty",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                var item = wishlistItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(item["image"],
                          width: 70, height: 70, fit: BoxFit.cover),
                    ),
                    title: Text(item["title"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text("Rs. ${item["price"]}",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// ❤️ Remove button
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              wishlistItems.removeAt(index);
                            });
                          },
                        ),
                        /// 🛒 Move to cart
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "${item["title"]} moved to Cart ✅")),
                            );
                          },
                          child: const Text(
                            "Move to Cart",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFF05105),
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
