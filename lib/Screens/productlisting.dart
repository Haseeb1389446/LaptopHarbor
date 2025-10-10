import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor/Screens/productdetails.dart';
import 'package:laptop_harbor/Widgets/appbar.dart';
import 'package:laptop_harbor/Widgets/bottomnavigationbar.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String searchQuery = '';
  String selectedFilter = 'All';
  String selectedSort = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Products',
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF062245)),
            ),
          ),

          /// 🔹 Search + Filter + Sort
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF062245)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),

                _buildDropdown(selectedFilter, ['All', 'Below 50000', 'Above 50000'],
                    (val) => setState(() => selectedFilter = val!)),
                const SizedBox(width: 10),
                _buildDropdown(
                    selectedSort,
                    ['None', 'A-Z', 'Price: Low to High', 'Price: High to Low'],
                    (val) => setState(() => selectedSort = val!)),
              ],
            ),
          ),
          const SizedBox(height: 10),

          /// 🔹 Product Stream
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFFF05105)));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                var products = snapshot.data!.docs.map((doc) {
                  return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
                }).toList();

                products = products
                    .where((p) =>
                        p['name'].toString().toLowerCase().contains(searchQuery))
                    .toList();

                if (selectedFilter == 'Below 50000') {
                  products = products.where((p) => p['price'] < 50000).toList();
                } else if (selectedFilter == 'Above 50000') {
                  products = products.where((p) => p['price'] >= 50000).toList();
                }

                if (selectedSort == 'A-Z') {
                  products.sort((a, b) => a['name'].compareTo(b['name']));
                } else if (selectedSort == 'Price: Low to High') {
                  products.sort((a, b) => a['price'].compareTo(b['price']));
                } else if (selectedSort == 'Price: High to Low') {
                  products.sort((a, b) => b['price'].compareTo(a['price']));
                }

                if (products.isEmpty) {
                  return const Center(child: Text('No products match your filters'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final data = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // ✅ Fix: send productId instead of data
                            builder: (context) => ProductDetailScreen(
                              productId: data['id'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.08),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.vertical(top: Radius.circular(14)),
                                child: Image.asset(
                                  "assets/products/${data['image']}",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF062245))),
                                  const SizedBox(height: 4),
                                  Text('Rs. ${data['price']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFF05105))),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      Text('${data['rating']}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomnavigationbarWidget(currentIndex: 1),
    );
  }

  Widget _buildDropdown(
      String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
