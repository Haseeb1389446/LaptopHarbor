import 'package:flutter/material.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class WishlistScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const WishlistScreen({super.key, required this.items});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF062245),
        title: const Text("My Wishlist"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: widget.items.isEmpty
          ? const Center(
              child: Text(
                "No items in wishlist ❤️",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                var item = widget.items[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(item["image"], width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text(item["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text(
                      "Rs. ${item["price"]}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          widget.items.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 3),
    );
  }
}
