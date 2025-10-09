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
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 0),
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

// import 'package:flutter/material.dart';

// class ProductListingScreen extends StatefulWidget {
//   final String title; // e.g. "Dell", "Gaming Laptops", "Search Results"
//   final List<Map<String, dynamic>> products;

//   const ProductListingScreen({
//     super.key,
//     required this.title,
//     required this.products,
//   });

//   @override
//   State<ProductListingScreen> createState() => _ProductListingScreenState();
// }

// class _ProductListingScreenState extends State<ProductListingScreen> {
//   String _selectedSort = "Default";
//   late List<Map<String, dynamic>> _displayedProducts;

//   @override
//   void initState() {
//     super.initState();
//     _displayedProducts = List.from(widget.products);
//   }

//   void _sortProducts(String sortType) {
//     setState(() {
//       _selectedSort = sortType;
//       if (sortType == "Price: Low to High") {
//         _displayedProducts.sort((a, b) => a['price'].compareTo(b['price']));
//       } else if (sortType == "Price: High to Low") {
//         _displayedProducts.sort((a, b) => b['price'].compareTo(a['price']));
//       } else if (sortType == "A-Z") {
//         _displayedProducts.sort((a, b) => a['title'].compareTo(b['title']));
//       } else {
//         _displayedProducts = List.from(widget.products);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: _sortProducts,
//             itemBuilder: (context) => [
//               const PopupMenuItem(value: "Default", child: Text("Default")),
//               const PopupMenuItem(
//                 value: "Price: Low to High",
//                 child: Text("Price: Low to High"),
//               ),
//               const PopupMenuItem(
//                 value: "Price: High to Low",
//                 child: Text("Price: High to Low"),
//               ),
//               const PopupMenuItem(value: "A-Z", child: Text("A-Z")),
//             ],
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: GridView.builder(
//           itemCount: _displayedProducts.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.7,
//           ),
//           itemBuilder: (context, index) {
//             final p = _displayedProducts[index];
//             return _productCard(p);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _productCard(Map<String, dynamic> product) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: InkWell(
//         onTap: () {
//           // Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.asset(
//                   product['img'],
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   errorBuilder: (_, __, ___) =>
//                       Container(color: Colors.grey[200]),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 product['title'],
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 "\$${product['price'].toStringAsFixed(2)}",
//                 style: const TextStyle(
//                   color: Color(0xFFF05105),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }
