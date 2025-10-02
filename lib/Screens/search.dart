import 'package:flutter/material.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = ["Dell XPS", "MacBook", "Gaming Laptop"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF062245),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search laptops...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          onSubmitted: (value) {
            setState(() {
              if (value.isNotEmpty && !recentSearches.contains(value)) {
                recentSearches.insert(0, value);
              }
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🕘 Recent Searches
            const Text("Recent Searches",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF062245))),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: recentSearches
                  .map((e) => Chip(
                        label: Text(e),
                        backgroundColor: Colors.blue.shade50,
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            recentSearches.remove(e);
                          });
                        },
                      ))
                  .toList(),
            ),

            const SizedBox(height: 20),

            /// 🎯 Suggested Products
            const Text("Suggested Laptops",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF062245))),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                productCard("Dell Inspiron", "assets/images/logo.png", 799),
                productCard("MacBook Air", "assets/images/logo.png", 1299),
                productCard("HP Omen", "assets/images/logo.png", 1099),
                productCard("Lenovo ThinkPad", "assets/images/logo.png", 899),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 1),
    );
  }

  /// 💻 Product Card Widget
  Widget productCard(String title, String imagePath, double price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text("\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
